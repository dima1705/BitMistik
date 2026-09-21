import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/cloud_functions/cloud_functions.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/flutter_flow_util.dart';
import 'bepaid_config.dart';

class BePaidCheckoutSession {
  const BePaidCheckoutSession({
    required this.token,
    required this.redirectUrl,
  });

  final String token;
  final String redirectUrl;
}

class BePaidConfirmResult {
  const BePaidConfirmResult({
    required this.success,
    this.paymentId,
  });

  final bool success;
  final String? paymentId;
}

class BePaidCredentials {
  const BePaidCredentials({
    required this.shopId,
    required this.secretKey,
    required this.testMode,
    required this.currency,
  });

  final String shopId;
  final String secretKey;
  final bool testMode;
  final String currency;

  bool get isValid => shopId.isNotEmpty && secretKey.isNotEmpty;
}

class BePaidService {
  BePaidService._();

  static Future<BePaidCredentials> resolveCredentials() async {
    if (BePaidConfig.hasClientCredentials) {
      return BePaidCredentials(
        shopId: BePaidConfig.shopId,
        secretKey: BePaidConfig.secretKey,
        testMode: BePaidConfig.testMode,
        currency: BePaidConfig.currency,
      );
    }

    try {
      final doc = await FirebaseFirestore.instance
          .collection('app_config')
          .doc('bepaid')
          .get();
      if (doc.exists) {
        final data = doc.data() ?? {};
        return BePaidCredentials(
          shopId: (data['shop_id'] ?? data['shopId'] ?? '').toString().trim(),
          secretKey:
              (data['secret_key'] ?? data['secretKey'] ?? '').toString().trim(),
          testMode: data['test'] == true,
          currency: (data['currency'] ?? BePaidConfig.currency).toString(),
        );
      }
    } catch (_) {}

    return BePaidCredentials(
      shopId: '',
      secretKey: '',
      testMode: BePaidConfig.testMode,
      currency: BePaidConfig.currency,
    );
  }

  static Future<BePaidCheckoutSession> createCheckout({
    required double amount,
    required String description,
    double? rate,
    double? amountUsd,
    String? email,
    String? trackingId,
  }) async {
    final cloud = await makeCloudCall(
      'createBePaidCheckout',
      {
        'amount': amount,
        'rate': rate,
        if (amountUsd != null) 'amountUsd': amountUsd,
        'currency': 'BYN',
        'description': description,
        'email': email ?? currentUserEmail,
        'trackingId': trackingId ??
            '${currentUserUid}_${DateTime.now().millisecondsSinceEpoch}',
      },
    );

    final cloudUrl = (cloud['redirect_url'] ?? cloud['redirectUrl'])?.toString();
    final cloudToken = cloud['token']?.toString();
    if (cloudUrl != null &&
        cloudUrl.isNotEmpty &&
        cloudToken != null &&
        cloudToken.isNotEmpty) {
      return BePaidCheckoutSession(token: cloudToken, redirectUrl: cloudUrl);
    }

    final credentials = await resolveCredentials();
    if (!credentials.isValid) {
      throw Exception(
        'Не заданы данные магазина bePaid. Укажите Shop ID и Secret Key '
        'в lib/backend/bepaid/bepaid_config.dart, через --dart-define '
        'или в Firestore: app_config/bepaid.',
      );
    }

    final amountMinor = (amount * 100).round();
    if (amountMinor <= 0) {
      throw Exception('Сумма оплаты должна быть больше нуля.');
    }

    final payload = {
      'checkout': {
        'transaction_type': 'payment',
        'attempts': 3,
        'iframe': true,
        'test': credentials.testMode,
        'duplicate_check': false,
        'order': {
          'amount': amountMinor,
          'currency': 'BYN',
          'description': description,
          'tracking_id': trackingId ??
              '${currentUserUid}_${DateTime.now().millisecondsSinceEpoch}',
        },
        'settings': {
          'language': 'ru',
          'success_url': BePaidConfig.successUrl,
          'fail_url': BePaidConfig.failUrl,
          'decline_url': BePaidConfig.declineUrl,
          'cancel_url': BePaidConfig.cancelUrl,
          'notification_url': BePaidConfig.notificationUrl,
        },
        'payment_method': {
          'types': ['credit_card'],
        },
        if ((email ?? currentUserEmail).isNotEmpty)
          'customer': {
            'email': email ?? currentUserEmail,
          },
      },
    };

    final response = await _authorizedRequest(
      credentials: credentials,
      method: 'POST',
      path: '/ctp/api/checkouts',
      body: payload,
    );

    final checkout = response['checkout'];
    if (checkout is! Map) {
      throw Exception(_errorMessage(response) ?? 'bePaid не вернул данные оплаты.');
    }

    final token = checkout['token']?.toString() ?? '';
    final redirectUrl = checkout['redirect_url']?.toString() ?? '';
    if (token.isEmpty || redirectUrl.isEmpty) {
      throw Exception(_errorMessage(response) ?? 'bePaid не вернул ссылку на оплату.');
    }

    return BePaidCheckoutSession(token: token, redirectUrl: redirectUrl);
  }

  static Future<BePaidConfirmResult> confirmPayment(
    String token, {
    String? returnUrl,
  }) async {
    final cloud = await makeCloudCall(
      'confirmBePaidCheckout',
      {'token': token},
    );
    final cloudPaymentId = cloud['paymentId']?.toString();
    if (cloud['success'] == true) {
      return BePaidConfirmResult(
        success: true,
        paymentId: (cloudPaymentId != null && cloudPaymentId.isNotEmpty)
            ? cloudPaymentId
            : null,
      );
    }

    final queried = await queryCheckoutSuccessful(token);
    if (queried == true) {
      // Payment succeeded at bePaid; ask cloud once more for the ledger row.
      final retry = await makeCloudCall(
        'confirmBePaidCheckout',
        {'token': token},
      );
      final retryId = retry['paymentId']?.toString();
      return BePaidConfirmResult(
        success: true,
        paymentId: (retryId != null && retryId.isNotEmpty) ? retryId : null,
      );
    }
    if (queried == false) {
      return const BePaidConfirmResult(success: false);
    }

    final status = Uri.tryParse(returnUrl ?? '')?.queryParameters['status'];
    return BePaidConfirmResult(success: status == 'successful');
  }

  /// `true` / `false` / `null` if status cannot be determined.
  static Future<bool?> queryCheckoutSuccessful(String token) async {
    try {
      final credentials = await resolveCredentials();
      if (!credentials.isValid) {
        return null;
      }

      final response = await _authorizedRequest(
        credentials: credentials,
        method: 'GET',
        path: '/ctp/api/checkouts/$token',
      );

      final checkout = response['checkout'];
      if (checkout is! Map) {
        return null;
      }

      final status = checkout['status']?.toString().toLowerCase();
      final gateway = checkout['gateway_response'];
      String? paymentStatus;
      if (gateway is Map) {
        final payment = gateway['payment'];
        if (payment is Map) {
          paymentStatus = payment['status']?.toString().toLowerCase();
        }
      }

      if (status == 'successful' || paymentStatus == 'successful') {
        return true;
      }
      if (status == 'error' ||
          status == 'failed' ||
          status == 'declined' ||
          paymentStatus == 'failed' ||
          paymentStatus == 'declined' ||
          paymentStatus == 'error') {
        return false;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  static bool isReturnUrl(String url, String path) {
    return url.contains(path);
  }

  static Future<PaymentsRecord> creditSuccessfulTopUp({
    required double amount,
    required double rate,
    String? token,
    String? paymentId,
    String transferType = 'Пополнение счета · bePaid',
  }) async {
    Future<PaymentsRecord?> loadById(String? id) async {
      if (id == null || id.isEmpty) {
        return null;
      }
      try {
        return await PaymentsRecord.getDocumentOnce(
          PaymentsRecord.collection.doc(id),
        );
      } catch (_) {
        return null;
      }
    }

    // Prefer the payment already created by Cloud Functions / webhook.
    final fromArg = await loadById(paymentId);
    if (fromArg != null) {
      return fromArg;
    }

    if (token != null && token.isNotEmpty) {
      final cloud = await makeCloudCall(
        'confirmBePaidCheckout',
        {'token': token},
      );
      final fromCloud = await loadById(cloud['paymentId']?.toString());
      if (fromCloud != null) {
        return fromCloud;
      }

      try {
        final pending = await FirebaseFirestore.instance
            .collection('bepaid_checkouts')
            .doc(token)
            .get();
        final pendingId = pending.data()?['paymentId']?.toString();
        if (pending.data()?['credited'] == true) {
          final fromPending = await loadById(pendingId);
          if (fromPending != null) {
            return fromPending;
          }
        }
      } catch (_) {}

      try {
        final existing = await PaymentsRecord.collection
            .where('bepaid_token', isEqualTo: token)
            .limit(1)
            .get();
        if (existing.docs.isNotEmpty) {
          return PaymentsRecord.fromSnapshot(existing.docs.first);
        }
      } catch (_) {}
    }

    // Fallback only when server did not create a payment row yet.
    final newBalance = functions.convertToBitWithValidation(
      amount,
      rate,
      valueOrDefault(currentUserDocument?.balance, 0.0),
    );

    await currentUserReference!.update(createUsersRecordData(
      balance: newBalance,
    ));

    final paymentsRecordReference = PaymentsRecord.collection.doc();
    final paymentData = createPaymentsRecordData(
      user: currentUserReference,
      transferAmount: amount,
      transferType: transferType,
      balance: newBalance,
      converted: amount / rate,
      rate: rate,
    );

    await paymentsRecordReference.set({
      ...paymentData,
      'balance_is_after': true,
      if (token != null && token.isNotEmpty) 'bepaid_token': token,
      ...mapToFirestore({
        'created_at': FieldValue.serverTimestamp(),
      }),
    });

    if (token != null && token.isNotEmpty) {
      try {
        await FirebaseFirestore.instance
            .collection('bepaid_checkouts')
            .doc(token)
            .set(
          {
            'uid': currentUserUid,
            'amount': amount,
            'rate': rate,
            'credited': true,
            'paymentId': paymentsRecordReference.id,
          },
          SetOptions(merge: true),
        );
      } catch (_) {}
    }

    return PaymentsRecord.getDocumentFromData(
      {
        ...paymentData,
        ...mapToFirestore({
          'created_at': DateTime.now(),
        }),
      },
      paymentsRecordReference,
    );
  }

  static Future<Map<String, dynamic>> _authorizedRequest({
    required BePaidCredentials credentials,
    required String method,
    required String path,
    Map<String, dynamic>? body,
  }) async {
    final uri = Uri.https(BePaidConfig.checkoutHost, path);
    final headers = {
      'Authorization':
          'Basic ${base64Encode(utf8.encode('${credentials.shopId}:${credentials.secretKey}'))}',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'X-API-Version': '2',
    };

    late http.Response response;
    if (method == 'GET') {
      response = await http.get(uri, headers: headers);
    } else {
      response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(body ?? {}),
      );
    }

    Map<String, dynamic> decoded = {};
    if (response.body.isNotEmpty) {
      final parsed = jsonDecode(response.body);
      if (parsed is Map<String, dynamic>) {
        decoded = parsed;
      } else if (parsed is Map) {
        decoded = Map<String, dynamic>.from(parsed);
      }
    }

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        _errorMessage(decoded) ??
            'Ошибка bePaid (${response.statusCode}). Проверьте данные магазина.',
      );
    }

    return decoded;
  }

  static String? _errorMessage(Map<String, dynamic> response) {
    final message = response['message'] ??
        response['error'] ??
        (response['errors'] is Map
            ? (response['errors'] as Map).values.first
            : null);
    if (message == null) {
      return null;
    }
    return message.toString();
  }
}
