import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/itog/gadanie/loading/loading_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'choose_card_app_state_model.dart';
export 'choose_card_app_state_model.dart';

class ChooseCardAppStateWidget extends StatefulWidget {
  const ChooseCardAppStateWidget({
    super.key,
    required this.title,
    required this.image,
    required this.description,
    required this.cardId,
    required this.question,
    this.amountCards,
    this.spreadType,
  });

  final String? title;
  final String? image;
  final String? description;
  final String? cardId;
  final String? question;
  final int? amountCards;
  final String? spreadType;

  @override
  State<ChooseCardAppStateWidget> createState() =>
      _ChooseCardAppStateWidgetState();
}

class _ChooseCardAppStateWidgetState extends State<ChooseCardAppStateWidget> {
  late ChooseCardAppStateModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChooseCardAppStateModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 20.0, 24.0, 20.0),
              child: Material(
                color: Colors.transparent,
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                child: Container(
                  width: double.infinity,
                  height: 600.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).customColor5,
                    borderRadius: BorderRadius.circular(24.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).tertiary,
                      width: 1.0,
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                          color: Colors.transparent,
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Container(
                            width: 269.9,
                            height: 417.7,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).customColor5,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: Image.network(
                                  widget!.image!,
                                ).image,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 20.0,
                                  color: Color(0xFF161063),
                                  offset: Offset(
                                    0.0,
                                    5.0,
                                  ),
                                  spreadRadius: 2.0,
                                )
                              ],
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 24.0, 0.0, 0.0),
                          child: Text(
                            '${widget!.title}✨',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'JOST',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  fontSize: 26.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w300,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: AlignmentDirectional(0.91, -0.88),
          child: Builder(
            builder: (context) => StreamBuilder<List<UserQuestionnaireRecord>>(
              stream: queryUserQuestionnaireRecord(
                queryBuilder: (userQuestionnaireRecord) =>
                    userQuestionnaireRecord.where(
                  'user',
                  isEqualTo: currentUserReference,
                ),
                singleRecord: true,
              ),
              builder: (context, snapshot) {
                // Customize what your widget looks like when it's loading.
                if (!snapshot.hasData) {
                  return Center(
                    child: SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          FlutterFlowTheme.of(context).primary,
                        ),
                      ),
                    ),
                  );
                }
                List<UserQuestionnaireRecord>
                    iconButtonUserQuestionnaireRecordList = snapshot.data!;
                // Return an empty Container when the item does not exist.
                if (snapshot.data!.isEmpty) {
                  return Container();
                }
                final iconButtonUserQuestionnaireRecord =
                    iconButtonUserQuestionnaireRecordList.isNotEmpty
                        ? iconButtonUserQuestionnaireRecordList.first
                        : null;

                return FlutterFlowIconButton(
                  borderColor: FlutterFlowTheme.of(context).tertiary,
                  borderRadius: 25.0,
                  borderWidth: 2.0,
                  buttonSize: 50.0,
                  fillColor: FlutterFlowTheme.of(context).customColor5,
                  icon: Icon(
                    Icons.close_rounded,
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    size: 24.0,
                  ),
                  onPressed: () async {
                    logFirebaseEvent(
                        'CHOOSE_CARD_APP_STATE_close_rounded_ICN_');
                    logFirebaseEvent('IconButton_update_app_state');
                    FFAppState().addToCards(widget!.title!);
                    FFAppState().addToCardImage(widget!.image!);
                    FFAppState().addToCardsId(widget!.cardId!);
                    FFAppState().addToCardInfo(CardStruct(
                      title: widget!.title,
                      image: widget!.image,
                    ));
                    safeSetState(() {});
                    if (FFAppState().cards.length == widget!.amountCards) {
                      const readingCost = 3.0;
                      final balance = valueOrDefault(
                          currentUserDocument?.balance, 0.0);
                      if (balance < readingCost) {
                        logFirebaseEvent('IconButton_alert_dialog');
                        // Undo in-progress reading so user can top up and retry.
                        FFAppState().cardTitle = [];
                        FFAppState().cards = [];
                        FFAppState().cardInfo = [];
                        FFAppState().cardsId = [];
                        FFAppState().cardImage = [];
                        safeSetState(() {});
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                        final theme = FlutterFlowTheme.of(context);
                        await showDialog(
                          context: context,
                          builder: (alertDialogContext) {
                            return AlertDialog(
                              backgroundColor: theme.customColor4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                side: BorderSide(
                                  color: theme.customColor3,
                                  width: 0.8,
                                ),
                              ),
                              title: Text(
                                'Недостаточно bit',
                                style: theme.titleMedium.override(
                                  fontFamily: 'JOST',
                                  color: theme.secondaryBackground,
                                  letterSpacing: 0.0,
                                ),
                              ),
                              content: Text(
                                'Стоимость одного гадания — 3 bit.\n'
                                'Пополните баланс, чтобы получить ответ.',
                                style: theme.bodyMedium.override(
                                  fontFamily: 'JOST',
                                  color: theme.secondaryBackground
                                      .withValues(alpha: 0.9),
                                  letterSpacing: 0.0,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(alertDialogContext),
                                  child: Text(
                                    'Закрыть',
                                    style: theme.bodyMedium.override(
                                      fontFamily: 'JOST',
                                      color: theme.secondaryBackground,
                                      letterSpacing: 0.0,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(alertDialogContext);
                                    context.pushNamed(
                                      DAMBalans3Popolnenye10Widget.routeName,
                                    );
                                  },
                                  child: Text(
                                    'Пополнить баланс',
                                    style: theme.bodyMedium.override(
                                      fontFamily: 'JOST',
                                      color: theme.primary,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                        return;
                      }

                      await Future.wait([
                        Future(() async {
                          logFirebaseEvent('IconButton_alert_dialog');
                          await showDialog(
                            context: context,
                            builder: (dialogContext) {
                              return Dialog(
                                elevation: 0,
                                insetPadding: EdgeInsets.zero,
                                backgroundColor: Colors.transparent,
                                alignment: AlignmentDirectional(0.0, 0.0)
                                    .resolve(Directionality.of(context)),
                                child: LoadingWidget(),
                              );
                            },
                          );
                        }),
                        Future(() async {
                          logFirebaseEvent('IconButton_backend_call');
                          _model.ai = await OpenAPIAIGroup.sendPromptCall.call(
                            cardInfoJson: <String, List<String>?>{
                              'cards': FFAppState().cards,
                            },
                            question: widget!.question,
                            userQuestionnaireJson: FFAppState().userQ,
                            spreadType: widget!.spreadType,
                          );

                          logFirebaseEvent('IconButton_backend_call');

                          var fortuneTellingRecordReference =
                              FortuneTellingRecord.collection.doc();
                          await fortuneTellingRecordReference.set({
                            ...createFortuneTellingRecordData(
                              responseFromGPT:
                                  OpenAPIAIGroup.sendPromptCall.responseAI(
                                (_model.ai?.jsonBody ?? ''),
                              ),
                              answer: widget!.question,
                              userId: currentUserReference,
                              spreadType: widget!.spreadType,
                            ),
                            ...mapToFirestore(
                              {
                                'created_at': FieldValue.serverTimestamp(),
                                'cards': getCardListFirestoreData(
                                  FFAppState().cardInfo,
                                ),
                              },
                            ),
                          });
                          _model.aIresponse =
                              FortuneTellingRecord.getDocumentFromData({
                            ...createFortuneTellingRecordData(
                              responseFromGPT:
                                  OpenAPIAIGroup.sendPromptCall.responseAI(
                                (_model.ai?.jsonBody ?? ''),
                              ),
                              answer: widget!.question,
                              userId: currentUserReference,
                              spreadType: widget!.spreadType,
                            ),
                            ...mapToFirestore(
                              {
                                'created_at': DateTime.now(),
                                'cards': getCardListFirestoreData(
                                  FFAppState().cardInfo,
                                ),
                              },
                            ),
                          }, fortuneTellingRecordReference);

                          // 3 bit per completed reading.
                          final userRef = currentUserReference;
                          if (userRef != null) {
                            logFirebaseEvent('IconButton_backend_call');
                            await userRef.update({
                              'balance': FieldValue.increment(-3.0),
                            });
                          }

                          logFirebaseEvent('IconButton_update_app_state');
                          FFAppState().cardTitle = [];
                          FFAppState().cards = [];
                          FFAppState().cardInfo = [];
                          FFAppState().cardsId = [];
                          FFAppState().cardImage = [];
                          safeSetState(() {});
                          logFirebaseEvent('IconButton_navigate_to');

                          context.pushNamed(
                            Gadanye4OdnoIzIstoryi4Widget.routeName,
                            queryParameters: {
                              'aiResponse': serializeParam(
                                _model.aIresponse,
                                ParamType.Document,
                              ),
                            }.withoutNulls,
                            extra: <String, dynamic>{
                              'aiResponse': _model.aIresponse,
                            },
                          );
                        }),
                      ]);
                    } else {
                      logFirebaseEvent('IconButton_close_dialog_drawer_etc');
                      Navigator.pop(context);
                    }

                    safeSetState(() {});
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
