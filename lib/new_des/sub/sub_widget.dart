import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/bepaid/bepaid_service.dart';
import '/backend/currency/nbrb_usd_byn.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/itog/admin/dashboard/admin_tariffs_panel.dart'
    show ensureDefaultTariffs, readingsFromBits;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'sub_model.dart';
export 'sub_model.dart';

class SubWidget extends StatefulWidget {
  const SubWidget({super.key});

  static String routeName = 'Sub';
  static String routePath = 'sub';

  @override
  State<SubWidget> createState() => _SubWidgetState();
}

class _SubWidgetState extends State<SubWidget> {
  late SubModel _model;
  DocumentReference? _purchasingTariffRef;
  double? _usdToByn;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SubModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'Sub'});
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('SUB_PAGE_Sub_ON_INIT_STATE');
      await ensureDefaultTariffs();
      try {
        final rate = await NbrbUsdBynRate.fetchUsdToByn();
        if (mounted) {
          safeSetState(() => _usdToByn = rate);
        }
      } catch (_) {}
      logFirebaseEvent('Sub_firestore_query');
      _model.subExistResponce = await querySubscriptionsRecordOnce(
        queryBuilder: (q) => q.where(
          'user_id',
          isEqualTo: currentUserReference,
        ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      if (_model.subExistResponce == null && currentUserReference != null) {
        logFirebaseEvent('Sub_backend_call');
        final ref = SubscriptionsRecord.collection.doc();
        await ref.set({
          ...createSubscriptionsRecordData(
            userId: currentUserReference,
            isActive: false,
            tariffId: null,
            answerAiLeft: 0,
          ),
          ...mapToFirestore(
            {
              'start_date': FieldValue.serverTimestamp(),
            },
          ),
        });
        _model.subExistResponce =
            await SubscriptionsRecord.getDocumentOnce(ref);
      }
      if (mounted) {
        safeSetState(() {});
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> _purchaseTariff(TariffRecord tariff) async {
    if (_purchasingTariffRef != null) {
      return;
    }
    if (currentUserReference == null) {
      showSnackbar(context, 'Войдите в аккаунт, чтобы купить тариф');
      return;
    }

    final amountUsd = tariff.price.toDouble();
    final bits = tariff.countAiResponce;
    if (amountUsd < 1) {
      showSnackbar(context, 'Минимальная сумма тарифа — 1\$');
      return;
    }
    if (bits <= 0) {
      showSnackbar(context, 'В тарифе не указано количество bit');
      return;
    }

    safeSetState(() => _purchasingTariffRef = tariff.reference);

    try {
      logFirebaseEvent('SUB_PAGE__BTN_ON_TAP');
      final usdToByn = await NbrbUsdBynRate.fetchUsdToByn();
      final amountByn = NbrbUsdBynRate.usdToByn(amountUsd, usdToByn);
      if (amountByn <= 0) {
        throw Exception('Некорректная сумма после конвертации в BYN.');
      }

      // Cloud credits floor(amountByn / rate) == bits
      final cloudRate = amountByn / bits;
      final usdBitRate = amountUsd / bits;

      final checkout = await BePaidService.createCheckout(
        amount: amountByn,
        amountUsd: amountUsd,
        rate: cloudRate,
        description:
            'Тариф ${tariff.tariffType} · $bits bit · ${amountUsd.toStringAsFixed(0)}\$',
        trackingId:
            'tariff_${tariff.reference.id}_${currentUserUid}_${DateTime.now().millisecondsSinceEpoch}',
      );
      if (!mounted) {
        return;
      }

      final paidResult = await context.pushNamed(
        BePaidCheckoutWidget.routeName,
        extra: <String, dynamic>{
          'redirectUrl': checkout.redirectUrl,
          'token': checkout.token,
        },
      );
      final paidMap = paidResult is Map
          ? Map<String, dynamic>.from(paidResult as Map)
          : null;
      final paidOk = paidMap?['success'] == true || paidResult == true;
      if (!paidOk) {
        if (mounted &&
            (paidMap?['success'] == false || paidResult == false)) {
          showSnackbar(context, 'Оплата не завершена');
        }
        return;
      }

      await BePaidService.creditSuccessfulTopUp(
        amount: amountUsd,
        rate: usdBitRate,
        token: checkout.token,
        paymentId: paidMap?['paymentId']?.toString(),
        transferType:
            'Тариф ${tariff.tariffType} · ${amountUsd.toStringAsFixed(0)}\$ · bePaid',
      );

      // История подписки — для аналитики; баланс уже пополнен bit'ами.
      var subscription = _model.subExistResponce;
      if (subscription == null) {
        subscription = await querySubscriptionsRecordOnce(
          queryBuilder: (q) => q.where(
            'user_id',
            isEqualTo: currentUserReference,
          ),
          singleRecord: true,
        ).then((s) => s.firstOrNull);
        _model.subExistResponce = subscription;
      }
      if (subscription == null) {
        final ref = SubscriptionsRecord.collection.doc();
        await ref.set({
          ...createSubscriptionsRecordData(
            userId: currentUserReference,
            isActive: true,
            tariffId: tariff.reference,
            answerAiLeft: bits,
          ),
          ...mapToFirestore(
            {
              'start_date': FieldValue.serverTimestamp(),
            },
          ),
        });
      } else {
        await subscription.reference.update({
          ...createSubscriptionsRecordData(
            isActive: true,
            tariffId: tariff.reference,
            userId: currentUserReference,
            answerAiLeft: bits,
          ),
          ...mapToFirestore(
            {
              'start_date': FieldValue.serverTimestamp(),
            },
          ),
        });
      }

      if (!mounted) {
        return;
      }
      logFirebaseEvent('Button_navigate_to');
      context.pushNamed(SuccessSubWidget.routeName);
    } catch (e) {
      if (mounted) {
        showSnackbar(
          context,
          e.toString().replaceFirst('Exception: ', ''),
        );
      }
    } finally {
      if (mounted) {
        safeSetState(() => _purchasingTariffRef = null);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: theme.primaryText,
        appBar: AppBar(
          backgroundColor: theme.customColor4,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: theme.secondaryBackground,
              size: 30.0,
            ),
            onPressed: () async {
              context.safePop();
            },
          ),
          title: Text(
            'Тарифы',
            style: theme.headlineMedium.override(
              fontFamily: 'JOST',
              color: theme.secondaryBackground,
              fontSize: 22.0,
              letterSpacing: 0.0,
              fontWeight: FontWeight.w300,
            ),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/bitmystic-1.firebasestorage.app/o/osnova%2F%D0%94%D0%B8%D0%B7%D0%B0%D0%B9%D0%BD%20%D0%B1%D0%B5%D0%B7%20%D0%BD%D0%B0%D0%B7%D0%B2%D0%B0%D0%BD%D0%B8%D1%8F%20(7).png?alt=media&token=a1b19f70-df11-4ca5-a0fd-972a1e81e803',
                  ).image,
                ),
              ),
              child: Opacity(
                opacity: 0.55,
                child: Align(
                  alignment: const AlignmentDirectional(-1.5, -1.22),
                  child: Lottie.network(
                    'https://lottie.host/99e96481-9ff4-4849-8b8a-3b11091498ca/Efvg31RTi8.json',
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height,
                    fit: BoxFit.cover,
                    animate: true,
                  ),
                ),
              ),
            ),
            SafeArea(
              child: StreamBuilder<List<TariffRecord>>(
                stream: queryTariffRecord(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text(
                          'Не удалось загрузить тарифы.\nПопробуйте позже.',
                          textAlign: TextAlign.center,
                          style: theme.bodyLarge.override(
                            fontFamily: 'JOST',
                            color: theme.secondaryBackground,
                            letterSpacing: 0.0,
                          ),
                        ),
                      ),
                    );
                  }

                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 48.0,
                        height: 48.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            theme.primary,
                          ),
                        ),
                      ),
                    );
                  }

                  final tariffs = snapshot.data!
                      .where((t) => !t.hasIsActive() || t.isActive)
                      .toList()
                    ..sort((a, b) => a.price.compareTo(b.price));

                  return ListView(
                    padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 40.0),
                    children: [
                      Text(
                        'Выберите пакет bit',
                        style: theme.headlineMedium.override(
                          fontFamily: 'JOST',
                          color: Colors.white,
                          fontSize: 26.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Старт — 7 bit · гадание — 3 bit.\n'
                        'Оплата через bePaid, bit сразу на баланс.',
                        style: theme.bodyMedium.override(
                          fontFamily: 'JOST',
                          color: theme.secondaryBackground.withValues(
                            alpha: 0.78,
                          ),
                          fontSize: 15.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      if (tariffs.isEmpty)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 28.0,
                          ),
                          decoration: BoxDecoration(
                            color: theme.customColor5,
                            borderRadius: BorderRadius.circular(24.0),
                            border: Border.all(
                              color: theme.customColor3,
                              width: 0.8,
                            ),
                          ),
                          child: Text(
                            'Сейчас нет активных тарифов.\nЗагляните позже.',
                            textAlign: TextAlign.center,
                            style: theme.bodyMedium.override(
                              fontFamily: 'JOST',
                              color: theme.secondaryBackground,
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        )
                      else
                        ...tariffs.mapIndexed((index, tariff) {
                          final isFeatured = index == tariffs.length - 1 &&
                              tariffs.length > 1;
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: index == tariffs.length - 1 ? 0 : 16.0,
                            ),
                            child: _TariffCard(
                              tariff: tariff,
                              isFeatured: isFeatured,
                              isLoading:
                                  _purchasingTariffRef == tariff.reference,
                              isDisabled: _purchasingTariffRef != null,
                              usdToByn: _usdToByn,
                              onPurchase: () => _purchaseTariff(tariff),
                            ),
                          );
                        }),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TariffCard extends StatelessWidget {
  const _TariffCard({
    required this.tariff,
    required this.isFeatured,
    required this.isLoading,
    required this.isDisabled,
    required this.onPurchase,
    this.usdToByn,
  });

  final TariffRecord tariff;
  final bool isFeatured;
  final bool isLoading;
  final bool isDisabled;
  final Future<void> Function() onPurchase;
  final double? usdToByn;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final bits = tariff.countAiResponce;
    final readings = readingsFromBits(bits);
    final title = tariff.tariffType.trim().isEmpty
        ? 'Тариф'
        : tariff.tariffType.trim();
    final description = tariff.description.trim();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isFeatured
              ? [
                  theme.customColor3,
                  theme.customColor6,
                ]
              : [
                  theme.customColor5,
                  theme.customColor4.withValues(alpha: 0.92),
                ],
          begin: const AlignmentDirectional(-1.0, 1.0),
          end: const AlignmentDirectional(1.0, -1.0),
        ),
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: isFeatured
              ? theme.primary.withValues(alpha: 0.85)
              : theme.customColor3,
          width: isFeatured ? 1.4 : 0.8,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22.0, 22.0, 22.0, 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: theme.titleMedium.override(
                      fontFamily: 'JOST',
                      color: theme.secondaryBackground,
                      fontSize: 20.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (isFeatured)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: theme.primary.withValues(alpha: 0.22),
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: theme.primary.withValues(alpha: 0.55),
                      ),
                    ),
                    child: Text(
                      'Выгоднее',
                      style: theme.bodySmall.override(
                        fontFamily: 'JOST',
                        color: theme.secondaryBackground,
                        fontSize: 12.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
            if (description.isNotEmpty) ...[
              const SizedBox(height: 10.0),
              Text(
                description,
                style: theme.bodyMedium.override(
                  fontFamily: 'JOST',
                  color: theme.secondaryBackground.withValues(alpha: 0.82),
                  fontSize: 14.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
            const SizedBox(height: 18.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: _MetaChip(
                    label: '$bits bit · ~$readings гад.',
                  ),
                ),
                const SizedBox(width: 12.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${tariff.price}\$',
                      style: theme.headlineSmall.override(
                        fontFamily: 'JOST',
                        color: theme.secondaryBackground,
                        fontSize: 28.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (usdToByn != null && usdToByn! > 0)
                      Text(
                        '≈ ${NbrbUsdBynRate.usdToByn(tariff.price.toDouble(), usdToByn!).toStringAsFixed(2)} BYN',
                        style: theme.bodySmall.override(
                          fontFamily: 'JOST',
                          color: theme.secondaryBackground
                              .withValues(alpha: 0.72),
                          fontSize: 12.0,
                          letterSpacing: 0.0,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 18.0),
            Opacity(
              opacity: isDisabled && !isLoading ? 0.55 : 1.0,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(50.0),
                  onTap: isDisabled ? null : onPurchase,
                  child: Ink(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFBA3AE7),
                          Color(0xFF6822B9),
                        ],
                        begin: AlignmentDirectional(-0.98, 1.0),
                        end: AlignmentDirectional(0.98, -1.0),
                      ),
                      borderRadius: BorderRadius.circular(50.0),
                      border: Border.all(
                        color: const Color(0xB5ACA7E1),
                        width: 2.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      child: Center(
                        child: isLoading
                            ? SizedBox(
                                width: 22.0,
                                height: 22.0,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    theme.secondaryBackground,
                                  ),
                                ),
                              )
                            : Text(
                                'Оплатить через bePaid',
                                style: theme.titleSmall.override(
                                  fontFamily: 'JOST',
                                  color: theme.secondaryBackground,
                                  fontSize: 17.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        label,
        style: theme.bodySmall.override(
          fontFamily: 'JOST',
          color: theme.secondaryBackground,
          fontSize: 13.0,
          letterSpacing: 0.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
