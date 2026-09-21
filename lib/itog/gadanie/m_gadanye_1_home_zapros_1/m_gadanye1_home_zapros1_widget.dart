import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_swipeable_stack.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/itog/gadanie/add_cards_copy/add_cards_copy_widget.dart';
import '/itog/gadanie/choose_card_app_state/choose_card_app_state_widget.dart';
import '/itog/gadanie/double_card_error/double_card_error_widget.dart';
import 'dart:math';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'm_gadanye1_home_zapros1_model.dart';
export 'm_gadanye1_home_zapros1_model.dart';

class MGadanye1HomeZapros1Widget extends StatefulWidget {
  const MGadanye1HomeZapros1Widget({super.key});

  static String routeName = 'M_Gadanye_1_Home_Zapros_1';
  static String routePath = 'M_Gadanye_1_Home_Zapros_1';

  @override
  State<MGadanye1HomeZapros1Widget> createState() =>
      _MGadanye1HomeZapros1WidgetState();
}

class _MGadanye1HomeZapros1WidgetState extends State<MGadanye1HomeZapros1Widget>
    with TickerProviderStateMixin {
  late MGadanye1HomeZapros1Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MGadanye1HomeZapros1Model());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'M_Gadanye_1_Home_Zapros_1'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('M_GADANYE_1_HOME_ZAPROS_1_M_Gadanye_1_Ho');
      if (currentUserDocument?.userQuestionnaire == null) {
        logFirebaseEvent('M_Gadanye_1_Home_Zapros_1_navigate_to');

        context.pushNamed(DAAkkaunt2Anketa12Widget.routeName);
      } else {
        logFirebaseEvent('M_Gadanye_1_Home_Zapros_1_firestore_quer');
        _model.userQuestion = await queryUserQuestionnaireRecordOnce(
          queryBuilder: (userQuestionnaireRecord) =>
              userQuestionnaireRecord.where(
            'user',
            isEqualTo: currentUserReference,
          ),
          singleRecord: true,
        ).then((s) => s.firstOrNull);
        logFirebaseEvent('M_Gadanye_1_Home_Zapros_1_update_app_sta');
        FFAppState().userQ = <String, String?>{
          'age': _model.userQuestion?.age,
          'favBook': _model.userQuestion?.favBook,
          'favColor': _model.userQuestion?.favColor,
          'favFilm': _model.userQuestion?.favFilm,
          'hooby': _model.userQuestion?.hooby,
          'maritalStatus': _model.userQuestion?.maritalStatus,
          'profession': _model.userQuestion?.profession,
          'sex': _model.userQuestion?.sex,
        };
        safeSetState(() {});
      }
    });

    _model.questionTextController ??= TextEditingController();
    _model.questionFocusNode ??= FocusNode();

    animationsMap.addAll({
      'buttonOnPageLoadAnimation': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            color: Color(0x80FFFFFF),
            angle: 0.524,
          ),
        ],
      ),
      'swipeableStackOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryText,
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
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Opacity(
                    opacity: 0.6,
                    child: Align(
                      alignment: AlignmentDirectional(-1.5, -1.22),
                      child: Lottie.network(
                        'https://lottie.host/99e96481-9ff4-4849-8b8a-3b11091498ca/Efvg31RTi8.json',
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: MediaQuery.sizeOf(context).height * 1.0,
                        fit: BoxFit.cover,
                        animate: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 44.0, 0.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 10.0, 0.0, 0.0),
                                  child: Text(
                                    'Узнай, что вселенная говорит тебе 🔮',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'JOST',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          fontSize: 20.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w300,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 16.0, 24.0, 10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _model.questionTextController,
                                  focusNode: _model.questionFocusNode,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'Введите свой вопрос...',
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'JOST',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          letterSpacing: 0.0,
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .customColor3,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .customColor2,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    filled: true,
                                    fillColor: FlutterFlowTheme.of(context)
                                        .customColor5,
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            16.0, 12.0, 16.0, 12.0),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'JOST',
                                        color: Color(0xFFE5E5E5),
                                        letterSpacing: 0.0,
                                      ),
                                  maxLines: 2,
                                  minLines: 2,
                                  cursorColor: Color(0xFFE5E5E5),
                                  validator: _model
                                      .questionTextControllerValidator
                                      .asValidator(context),
                                  inputFormatters: [
                                    if (!isAndroid && !isiOS)
                                      TextInputFormatter.withFunction(
                                          (oldValue, newValue) {
                                        return TextEditingValue(
                                          selection: newValue.selection,
                                          text: newValue.text.toCapitalization(
                                              TextCapitalization.sentences),
                                        );
                                      }),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    logFirebaseEvent(
                                        'M_GADANYE_1_HOME_ZAPROS_1__BTN_ON_TAP');
                                    const readingCost = 3.0;
                                    final balance = valueOrDefault(
                                        currentUserDocument?.balance, 0.0);
                                    if (balance < readingCost) {
                                      logFirebaseEvent('Button_alert_dialog');
                                      final theme =
                                          FlutterFlowTheme.of(context);
                                      await showDialog(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            backgroundColor:
                                                theme.customColor4,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              side: BorderSide(
                                                color: theme.customColor3,
                                                width: 0.8,
                                              ),
                                            ),
                                            title: Text(
                                              'Недостаточно bit',
                                              style: theme.titleMedium
                                                  .override(
                                                fontFamily: 'JOST',
                                                color: theme
                                                    .secondaryBackground,
                                                letterSpacing: 0.0,
                                              ),
                                            ),
                                            content: Text(
                                              'Стоимость одного гадания — 3 bit.\n'
                                              'На балансе сейчас: ${balance.toStringAsFixed(balance.truncateToDouble() == balance ? 0 : 1)} bit.\n\n'
                                              'Пополните баланс, чтобы гадать.',
                                              style: theme.bodyMedium
                                                  .override(
                                                fontFamily: 'JOST',
                                                color: theme
                                                    .secondaryBackground
                                                    .withValues(alpha: 0.9),
                                                letterSpacing: 0.0,
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(
                                                        alertDialogContext),
                                                child: Text(
                                                  'Закрыть',
                                                  style: theme.bodyMedium
                                                      .override(
                                                    fontFamily: 'JOST',
                                                    color: theme
                                                        .secondaryBackground,
                                                    letterSpacing: 0.0,
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(
                                                      alertDialogContext);
                                                  context.pushNamed(
                                                    DAMBalans3Popolnenye10Widget
                                                        .routeName,
                                                  );
                                                },
                                                child: Text(
                                                  'Пополнить баланс',
                                                  style: theme.bodyMedium
                                                      .override(
                                                    fontFamily: 'JOST',
                                                    color: theme.primary,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      return;
                                    }

                                    logFirebaseEvent('Button_backend_call');
                                    _model.randomCards = await OpenAPIAIGroup
                                        .getRandomCardListCall
                                        .call(
                                      question:
                                          _model.questionTextController.text,
                                    );

                                    safeSetState(() {});
                                  },
                                  text: '',
                                  icon: Icon(
                                    Icons.auto_awesome,
                                    size: 20.0,
                                  ),
                                  options: FFButtonOptions(
                                    width: 56.0,
                                    height: 56.0,
                                    padding: EdgeInsets.all(8.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    iconColor: Color(0xFFE5E5E5),
                                    color: Color(0xFF7B2CBF),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'JOST',
                                          color: Color(0xFFE5E5E5),
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                    elevation: 10.0,
                                    borderSide: BorderSide(
                                      color: Color(0xFF9D4EDD),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ).animateOnPageLoad(animationsMap[
                                    'buttonOnPageLoadAnimation']!),
                              ),
                            ].divide(SizedBox(width: 10.0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (OpenAPIAIGroup.getRandomCardListCall.error(
                            (_model.randomCards?.jsonBody ?? ''),
                          ) !=
                          null &&
                      OpenAPIAIGroup.getRandomCardListCall.error(
                            (_model.randomCards?.jsonBody ?? ''),
                          ) !=
                          '')
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(),
                      child: Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          child: Text(
                            'Пожалуйста, задай вопрос, который можно рассмотреть через карты Таро',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'JOST',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w300,
                                ),
                          ),
                        ),
                      ),
                    ),
                  if (OpenAPIAIGroup.getRandomCardListCall.error(
                            (_model.randomCards?.jsonBody ?? ''),
                          ) ==
                          null ||
                      OpenAPIAIGroup.getRandomCardListCall.error(
                            (_model.randomCards?.jsonBody ?? ''),
                          ) ==
                          '')
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0x00FFFFFF),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 24.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (OpenAPIAIGroup.getRandomCardListCall
                                            .spreadType(
                                          (_model.randomCards?.jsonBody ?? ''),
                                        ) !=
                                        null &&
                                    OpenAPIAIGroup.getRandomCardListCall
                                            .spreadType(
                                          (_model.randomCards?.jsonBody ?? ''),
                                        ) !=
                                        '')
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 10.0, 0.0, 10.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 5.0),
                                            child: Text(
                                              valueOrDefault<String>(
                                                'Расклад: ${OpenAPIAIGroup.getRandomCardListCall.spreadType(
                                                  (_model.randomCards
                                                          ?.jsonBody ??
                                                      ''),
                                                )}',
                                                'Тип гадания',
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'JOST',
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    fontSize: 20.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Text(
                                            valueOrDefault<String>(
                                              'Вытяните ${OpenAPIAIGroup.getRandomCardListCall.maxcards(
                                                    (_model.randomCards
                                                            ?.jsonBody ??
                                                        ''),
                                                  )?.toString()}${() {
                                                if (OpenAPIAIGroup
                                                        .getRandomCardListCall
                                                        .maxcards(
                                                      (_model.randomCards
                                                              ?.jsonBody ??
                                                          ''),
                                                    )! >=
                                                    5) {
                                                  return ' карт';
                                                } else if (OpenAPIAIGroup
                                                        .getRandomCardListCall
                                                        .maxcards(
                                                      (_model.randomCards
                                                              ?.jsonBody ??
                                                          ''),
                                                    ) ==
                                                    1) {
                                                  return ' карту';
                                                } else {
                                                  return ' карты';
                                                }
                                              }()}',
                                              'Тип гадания',
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'JOST',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  fontSize: 20.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                if ((_model.questionTextController.text ==
                                            null ||
                                        _model.questionTextController.text ==
                                            '') ||
                                    (() {
                                      final cards = OpenAPIAIGroup
                                              .getRandomCardListCall
                                              .randomCards(
                                                (_model.randomCards
                                                        ?.jsonBody ??
                                                    ''),
                                              )
                                              ?.toList() ??
                                          [];
                                      return cards.isEmpty;
                                    })())
                                  Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          50.0, 0.0, 0.0, 0.0),
                                      child: Lottie.network(
                                        'https://lottie.host/d5c61089-52b1-4755-a1f3-12c8ad41d8c6/CKaZgWw9KY.json',
                                        width: 250.0,
                                        height: 500.0,
                                        fit: BoxFit.contain,
                                        animate: true,
                                      ),
                                    ),
                                  ),
                                ClipRRect(
                                  child: Container(
                                    height: 360.0,
                                    decoration: BoxDecoration(),
                                    child: Builder(
                                      builder: (context) {
                                        final randomCard = OpenAPIAIGroup
                                                .getRandomCardListCall
                                                .randomCards(
                                                  (_model.randomCards
                                                          ?.jsonBody ??
                                                      ''),
                                                )
                                                ?.toList() ??
                                            [];
                                        final hasQuestion = _model
                                                    .questionTextController
                                                    .text !=
                                                null &&
                                            _model.questionTextController
                                                .text !=
                                                '';
                                        if (!hasQuestion ||
                                            randomCard.isEmpty) {
                                          return const SizedBox.shrink();
                                        }

                                        return Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: FlutterFlowSwipeableStack(
                                                onSwipeFn: (randomCardIndex) {},
                                                onLeftSwipe:
                                                    (randomCardIndex) {},
                                                onRightSwipe:
                                                    (randomCardIndex) {},
                                                onUpSwipe: (randomCardIndex) {},
                                                onDownSwipe:
                                                    (randomCardIndex) {},
                                                itemBuilder:
                                                    (context, randomCardIndex) {
                                                  final randomCardItem =
                                                      randomCard[
                                                          randomCardIndex];
                                                  return Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Builder(
                                                      builder: (context) =>
                                                          InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          logFirebaseEvent(
                                                              'M_GADANYE_1_HOME_ZAPROS_1_Image_ae0k2ytw');
                                                          if (functions
                                                                  .stringInList(
                                                                      getJsonField(
                                                                        randomCardItem,
                                                                        r'''$.id''',
                                                                      )
                                                                          .toString(),
                                                                      FFAppState()
                                                                          .cardsId
                                                                          .toList()) ==
                                                              false) {
                                                            logFirebaseEvent(
                                                                'Image_alert_dialog');
                                                            await showDialog(
                                                              context: context,
                                                              builder:
                                                                  (dialogContext) {
                                                                return Dialog(
                                                                  elevation: 0,
                                                                  insetPadding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  alignment: AlignmentDirectional(
                                                                          0.0,
                                                                          0.0)
                                                                      .resolve(
                                                                          Directionality.of(
                                                                              context)),
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      FocusScope.of(
                                                                              dialogContext)
                                                                          .unfocus();
                                                                      FocusManager
                                                                          .instance
                                                                          .primaryFocus
                                                                          ?.unfocus();
                                                                    },
                                                                    child:
                                                                        ChooseCardAppStateWidget(
                                                                      title:
                                                                          getJsonField(
                                                                        randomCardItem,
                                                                        r'''$.title''',
                                                                      ).toString(),
                                                                      image:
                                                                          getJsonField(
                                                                        randomCardItem,
                                                                        r'''$.cardImage''',
                                                                      ).toString(),
                                                                      description:
                                                                          getJsonField(
                                                                        randomCardItem,
                                                                        r'''$.cardDescription''',
                                                                      ).toString(),
                                                                      cardId:
                                                                          getJsonField(
                                                                        randomCardItem,
                                                                        r'''$.id''',
                                                                      ).toString(),
                                                                      question: _model
                                                                          .questionTextController
                                                                          .text,
                                                                      amountCards: OpenAPIAIGroup
                                                                          .getRandomCardListCall
                                                                          .maxcards(
                                                                        (_model.randomCards?.jsonBody ??
                                                                            ''),
                                                                      ),
                                                                      spreadType: OpenAPIAIGroup
                                                                          .getRandomCardListCall
                                                                          .spreadType(
                                                                        (_model.randomCards?.jsonBody ??
                                                                            ''),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            );

                                                            logFirebaseEvent(
                                                                'Image_update_page_state');
                                                            _model
                                                                .addToImagesForComp(
                                                                    getJsonField(
                                                              randomCardItem,
                                                              r'''$.cardImage''',
                                                            ).toString());
                                                            safeSetState(() {});
                                                          } else {
                                                            logFirebaseEvent(
                                                                'Image_alert_dialog');
                                                            await showDialog(
                                                              context: context,
                                                              builder:
                                                                  (dialogContext) {
                                                                return Dialog(
                                                                  elevation: 0,
                                                                  insetPadding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  alignment: AlignmentDirectional(
                                                                          0.0,
                                                                          0.0)
                                                                      .resolve(
                                                                          Directionality.of(
                                                                              context)),
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      FocusScope.of(
                                                                              dialogContext)
                                                                          .unfocus();
                                                                      FocusManager
                                                                          .instance
                                                                          .primaryFocus
                                                                          ?.unfocus();
                                                                    },
                                                                    child:
                                                                        DoubleCardErrorWidget(),
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          }
                                                        },
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          child: Image.network(
                                                            'https://firebasestorage.googleapis.com/v0/b/bitmystic-1.firebasestorage.app/o/Cards%2Fcards%20(2).png?alt=media&token=62cef944-b4f0-4cf2-afaa-2a3d82c840d7',
                                                            width: 260.0,
                                                            height:
                                                                double.infinity,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                itemCount: randomCard.length,
                                                controller: _model
                                                    .swipeableStackController,
                                                loop: false,
                                                cardDisplayCount: 10,
                                                scale: 0.9,
                                                cardPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                backCardOffset:
                                                    const Offset(0.0, 29.0),
                                              ).animateOnPageLoad(animationsMap[
                                                  'swipeableStackOnPageLoadAnimation']!),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.sizeOf(context).width * 0.95,
                                  ),
                                  decoration: BoxDecoration(),
                                  child: Visibility(
                                    visible: _model
                                                .questionTextController.text !=
                                            null &&
                                        _model.questionTextController.text !=
                                            '',
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 14.0, 0.0, 0.0),
                                      child: wrapWithModel(
                                        model: _model.addCardsCopyModel,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: AddCardsCopyWidget(
                                          images: _model.imagesForComp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ].addToEnd(SizedBox(height: 40.0)),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.86, 0.69),
              child: FlutterFlowIconButton(
                borderColor: FlutterFlowTheme.of(context).tertiary,
                borderRadius: 25.0,
                borderWidth: 2.0,
                buttonSize: 50.0,
                fillColor: FlutterFlowTheme.of(context).primary,
                icon: FaIcon(
                  FontAwesomeIcons.question,
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  size: 24.0,
                ),
                onPressed: () async {
                  logFirebaseEvent('M_GADANYE_1_HOME_ZAPROS_1_question_ICN_O');
                  logFirebaseEvent('IconButton_alert_dialog');
                  await showDialog(
                    context: context,
                    builder: (alertDialogContext) {
                      return AlertDialog(
                        title: Text('Как гадать на Таро ✨'),
                        content: Text(
                            'Введите свой вопрос и нажмите на кнопку рядом. AI определит тип гадания и предложит вам количество карт. Выберите их из колоды и получите ответ на свой вопрос 🔮\n\nСтоимость одного гадания — 3 bit. Если на балансе меньше 3 bit, пополните его перед гаданием.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(alertDialogContext),
                            child: Text('оки'),
                          ),
                        ],
                      );
                    },
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
