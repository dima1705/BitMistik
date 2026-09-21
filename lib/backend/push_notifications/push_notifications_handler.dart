import 'dart:async';
import 'dart:convert';

import 'serialization_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../index.dart';
import '../../main.dart';

final _handledMessageIds = <String?>{};

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    if (isWeb) {
      return;
    }

    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    if (_handledMessageIds.contains(message.messageId)) {
      return;
    }
    _handledMessageIds.add(message.messageId);

    safeSetState(() => _loading = true);
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final parametersBuilder = parametersBuilderMap[initialPageName];
      if (parametersBuilder != null) {
        final parameterData = await parametersBuilder(initialParameterData);
        if (mounted) {
          context.pushNamed(
            initialPageName,
            pathParameters: parameterData.pathParameters,
            extra: parameterData.extra,
          );
        } else {
          appNavigatorKey.currentContext?.pushNamed(
            initialPageName,
            pathParameters: parameterData.pathParameters,
            extra: parameterData.extra,
          );
        }
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      safeSetState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      handleOpenedPushNotification();
    });
  }

  @override
  Widget build(BuildContext context) => _loading
      ? Container(
          color: Color(0xFF0C0840),
          child: Image.asset(
            'assets/images/photo_2025-05-06_23-23-07.jpg',
            fit: BoxFit.contain,
          ),
        )
      : widget.child;
}

class ParameterData {
  const ParameterData(
      {this.requiredParams = const {}, this.allParams = const {}});
  final Map<String, String?> requiredParams;
  final Map<String, dynamic> allParams;

  Map<String, String> get pathParameters => Map.fromEntries(
        requiredParams.entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
  Map<String, dynamic> get extra => Map.fromEntries(
        allParams.entries.where((e) => e.value != null),
      );

  static Future<ParameterData> Function(Map<String, dynamic>) none() =>
      (data) async => ParameterData();
}

final parametersBuilderMap =
    <String, Future<ParameterData> Function(Map<String, dynamic>)>{
  'Splash': ParameterData.none(),
  'SignIn': ParameterData.none(),
  'Onboarding_Slideshow': ParameterData.none(),
  'Onboarding_CreateAccount': ParameterData.none(),
  'ForgotPassword': ParameterData.none(),
  'promtai': ParameterData.none(),
  'M_Gadanye_1_Home_Zapros_1': ParameterData.none(),
  'M_Gadanye_2_History_2': ParameterData.none(),
  'Dnevnik_2_Odna_zapis_6': (data) async => ParameterData(
        allParams: {
          'diaryDoc': await getDocumentParameter<DiaryRecord>(
              data, 'diaryDoc', DiaryRecord.fromSnapshot),
        },
      ),
  'Dnevnik_3_Create_Zapis_Knopka_7': ParameterData.none(),
  'Gadanye_4_Odno_iz_istoryi_4': (data) async => ParameterData(
        allParams: {
          'aiResponse': await getDocumentParameter<FortuneTellingRecord>(
              data, 'aiResponse', FortuneTellingRecord.fromSnapshot),
        },
      ),
  'DA_M_Akkaunt_1_Nav_11': ParameterData.none(),
  'DA_Akkaunt_2_Anketa_12': ParameterData.none(),
  'DA_Akkaunt_4_Setting_13': ParameterData.none(),
  'DA_Balans_1_Istorya_vsePopolnenye_8': ParameterData.none(),
  'DA_Akkaunt_3_EDIT_Anketa_profile_13Copy': ParameterData.none(),
  'DA_Balans_2_Istorya_ODNO_Popolnenye_9': (data) async => ParameterData(
        allParams: {
          'peymentDoc': await getDocumentParameter<PaymentsRecord>(
              data, 'peymentDoc', PaymentsRecord.fromSnapshot),
        },
      ),
  'DA_M_Balans_3_Popolnenye_10': ParameterData.none(),
  'payment': ParameterData.none(),
  'payment_succes': ParameterData.none(),
  'testpay2222': ParameterData.none(),
  'DA_M_Dnevnik_1_Istorya_vse_5': ParameterData.none(),
  'Dayyly5566': ParameterData.none(),
  'dailyDay222': ParameterData.none(),
  'Sub': ParameterData.none(),
  'SuccessSub': ParameterData.none(),
  'SettingPasswDelite': ParameterData.none(),
  'Dashboard': ParameterData.none(),
  'Karty': ParameterData.none(),
  'drag2': ParameterData.none(),
  'karty83': ParameterData.none(),
  'testUserQAppState': ParameterData.none(),
  'testCardAdvice': ParameterData.none(),
  'Map': ParameterData.none(),
  'test': ParameterData.none(),
};

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}
