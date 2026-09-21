import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/bepaid/bepaid_service.dart';
import '/backend/currency/nbrb_usd_byn.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'd_a_m_balans3_popolnenye10_model.dart';
export 'd_a_m_balans3_popolnenye10_model.dart';

class DAMBalans3Popolnenye10Widget extends StatefulWidget {
  const DAMBalans3Popolnenye10Widget({super.key});

  static String routeName = 'DA_M_Balans_3_Popolnenye_10';
  static String routePath = 'Balans-Popolnenye';

  @override
  State<DAMBalans3Popolnenye10Widget> createState() =>
      _DAMBalans3Popolnenye10WidgetState();
}

class _DAMBalans3Popolnenye10WidgetState
    extends State<DAMBalans3Popolnenye10Widget> {
  late DAMBalans3Popolnenye10Model _model;
  double? _usdToByn;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DAMBalans3Popolnenye10Model());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'DA_M_Balans_3_Popolnenye_10'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('D_A_M_BALANS_3_POPOLNENYE_10_DA_M_Balans');
      try {
        final rate = await NbrbUsdBynRate.fetchUsdToByn();
        if (mounted) {
          safeSetState(() => _usdToByn = rate);
        }
      } catch (_) {}
      if (valueOrDefault(currentUserDocument?.balance, 0.0) == null) {
        logFirebaseEvent('DA_M_Balans_3_Popolnenye_10_backend_call');

        await currentUserReference!.update(createUsersRecordData(
          balance: 0.0,
        ));
        logFirebaseEvent('DA_M_Balans_3_Popolnenye_10_update_page_');
        _model.cash = valueOrDefault(currentUserDocument?.balance, 0.0);
        safeSetState(() {});
      } else {
        logFirebaseEvent('DA_M_Balans_3_Popolnenye_10_update_page_');
        _model.cash = valueOrDefault(currentUserDocument?.balance, 0.0);
        safeSetState(() {});
      }
    });

    _model.moneyTextController ??= TextEditingController();
    _model.moneyFocusNode ??= FocusNode();
    _model.moneyTextController!.addListener(() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryText,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).customColor4,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30.0,
          borderWidth: 1.0,
          buttonSize: 54.0,
          icon: FaIcon(
            FontAwesomeIcons.angleLeft,
            color: FlutterFlowTheme.of(context).secondaryBackground,
            size: 24.0,
          ),
          onPressed: () async {
            logFirebaseEvent('D_A_M_BALANS_3_POPOLNENYE_10_angleLeft_I');
            logFirebaseEvent('IconButton_navigate_back');
            context.pop();
          },
        ),
        title: Text(
          'Пополнение ',
          style: FlutterFlowTheme.of(context).titleSmall.override(
                fontFamily: 'JOST',
                color: FlutterFlowTheme.of(context).info,
                fontSize: 20.0,
                letterSpacing: 0.0,
              ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 2.0,
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
              opacity: 0.7,
              child: Lottie.network(
                'https://lottie.host/99e96481-9ff4-4849-8b8a-3b11091498ca/Efvg31RTi8.json',
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: MediaQuery.sizeOf(context).height * 1.0,
                fit: BoxFit.cover,
                animate: true,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0x00FFFFFF),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          24.0, 24.0, 24.0, 24.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  spacing: 24.0,
                                  runSpacing: 24.0,
                                  alignment: WrapAlignment.start,
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  direction: Axis.horizontal,
                                  runAlignment: WrapAlignment.center,
                                  verticalDirection: VerticalDirection.down,
                                  clipBehavior: Clip.none,
                                  children: [
                                    Align(
                                      alignment:
                                          AlignmentDirectional(0.0, -1.0),
                                      child: Container(
                                        width: 750.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Container(
                                                  width: 450.0,
                                                  constraints: BoxConstraints(
                                                    minWidth: 250.0,
                                                    maxWidth: double.infinity,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Color(0x00F1F4F8),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Stack(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                1.0, -1.0),
                                                        children: [
                                                          Material(
                                                            color: Colors
                                                                .transparent,
                                                            elevation: 2.0,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18.0),
                                                            ),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                gradient:
                                                                    LinearGradient(
                                                                  colors: [
                                                                    Color(
                                                                        0x372E1371),
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .customColor6
                                                                  ],
                                                                  stops: [
                                                                    0.0,
                                                                    1.0
                                                                  ],
                                                                  begin:
                                                                      AlignmentDirectional(
                                                                          -0.98,
                                                                          1.0),
                                                                  end:
                                                                      AlignmentDirectional(
                                                                          0.98,
                                                                          -1.0),
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            18.0),
                                                                border:
                                                                    Border.all(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .accent3,
                                                                  width: 2.0,
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        10.0,
                                                                        10.0,
                                                                        10.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            2.0,
                                                                            0.0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Text(
                                                                                    'Текущий баланс',
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'JOST',
                                                                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                          fontSize: 10.0,
                                                                                          letterSpacing: 0.0,
                                                                                        ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  RichText(
                                                                                    textScaler: MediaQuery.of(context).textScaler,
                                                                                    text: TextSpan(
                                                                                      children: [
                                                                                        TextSpan(
                                                                                          text: valueOrDefault<String>(
                                                                                            _model.cash?.toString(),
                                                                                            '0.0',
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'JOST',
                                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                fontSize: 26.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.bold,
                                                                                              ),
                                                                                        ),
                                                                                        TextSpan(
                                                                                          text: ' bity',
                                                                                          style: TextStyle(),
                                                                                        )
                                                                                      ],
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: 'JOST',
                                                                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                            fontSize: 26.0,
                                                                                            letterSpacing: 0.0,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                                                    child: InkWell(
                                                                                      splashColor: Colors.transparent,
                                                                                      focusColor: Colors.transparent,
                                                                                      hoverColor: Colors.transparent,
                                                                                      highlightColor: Colors.transparent,
                                                                                      onTap: () async {
                                                                                        logFirebaseEvent('D_A_M_BALANS_3_POPOLNENYE_10_Container_b');
                                                                                        logFirebaseEvent('Container_navigate_to');

                                                                                        context.pushNamed(DABalans1IstoryaVsePopolnenye8Widget.routeName);
                                                                                      },
                                                                                      child: Container(
                                                                                        decoration: BoxDecoration(
                                                                                          gradient: LinearGradient(
                                                                                            colors: [
                                                                                              Color(0xFFBA3AE7),
                                                                                              Color(0xFF6822B9)
                                                                                            ],
                                                                                            stops: [0.0, 1.0],
                                                                                            begin: AlignmentDirectional(-0.98, 1.0),
                                                                                            end: AlignmentDirectional(0.98, -1.0),
                                                                                          ),
                                                                                          borderRadius: BorderRadius.circular(50.0),
                                                                                          border: Border.all(
                                                                                            color: Color(0xB5ACA7E1),
                                                                                            width: 1.0,
                                                                                          ),
                                                                                        ),
                                                                                        child: Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(10.0, 8.0, 10.0, 8.0),
                                                                                          child: Row(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Text(
                                                                                                'История оплат',
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: 'JOST',
                                                                                                      color: FlutterFlowTheme.of(context).info,
                                                                                                      fontSize: 12.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.bold,
                                                                                                    ),
                                                                                              ),
                                                                                              Icon(
                                                                                                Icons.history_rounded,
                                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                size: 18.0,
                                                                                              ),
                                                                                            ].divide(SizedBox(width: 6.0)),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ].divide(SizedBox(width: 10.0)),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    1.2, 0.37),
                                                            child:
                                                                Lottie.network(
                                                              'https://lottie.host/a72bbfa7-fced-414c-828d-bf97e98ee8df/FXawSRJNan.json',
                                                              width: 145.3,
                                                              height: 111.0,
                                                              fit: BoxFit
                                                                  .contain,
                                                              animate: true,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        'Введите сумму в \$ (мин. 1\$)',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'JOST',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  fontSize:
                                                                      20.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    4.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          child: TextFormField(
                                                            controller: _model
                                                                .moneyTextController,
                                                            focusNode: _model
                                                                .moneyFocusNode,
                                                            autofocus: false,
                                                            autofillHints: [
                                                              AutofillHints.name
                                                            ],
                                                            textCapitalization:
                                                                TextCapitalization
                                                                    .none,
                                                            textInputAction:
                                                                TextInputAction
                                                                    .next,
                                                            obscureText: false,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText:
                                                                  'Сумма в \$',
                                                              hintStyle: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'JOST',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground
                                                                        .withOpacity(
                                                                            0.5),
                                                                    fontSize:
                                                                        16.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .customColor3,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                              errorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                              focusedErrorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .error,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                              filled: true,
                                                              fillColor: FlutterFlowTheme
                                                                      .of(context)
                                                                  .customColor5,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'JOST',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  fontSize:
                                                                      16.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  lineHeight:
                                                                      1.0,
                                                                ),
                                                            textAlign:
                                                                TextAlign.start,
                                                            minLines: 1,
                                                            keyboardType:
                                                                const TextInputType
                                                                    .numberWithOptions(
                                                                    decimal:
                                                                        true),
                                                            cursorColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                            validator: _model
                                                                .moneyTextControllerValidator
                                                                .asValidator(
                                                                    context),
                                                            inputFormatters: [
                                                              if (!isAndroid &&
                                                                  !isiOS)
                                                                TextInputFormatter
                                                                    .withFunction(
                                                                        (oldValue,
                                                                            newValue) {
                                                                  return TextEditingValue(
                                                                    selection:
                                                                        newValue
                                                                            .selection,
                                                                    text: newValue
                                                                        .text
                                                                        .toCapitalization(
                                                                            TextCapitalization.none),
                                                                  );
                                                                }),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Builder(
                                                        builder: (context) {
                                                          final amountUsd =
                                                              double.tryParse(_model
                                                                  .moneyTextController
                                                                  .text
                                                                  .replaceAll(
                                                                      ',', '.')
                                                                  .trim());
                                                          if (amountUsd ==
                                                                  null ||
                                                              amountUsd <= 0) {
                                                            return Text(
                                                              'Сумма в \$ · списание в BYN по курсу НБРБ',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodySmall
                                                                  .override(
                                                                    fontFamily:
                                                                        'JOST',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground
                                                                        .withOpacity(
                                                                            0.7),
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            );
                                                          }
                                                          if (_usdToByn ==
                                                                  null ||
                                                              _usdToByn! <=
                                                                  0) {
                                                            return Text(
                                                              '${amountUsd.toStringAsFixed(2)} \$ · курс НБРБ загружается…',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodySmall
                                                                  .override(
                                                                    fontFamily:
                                                                        'JOST',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground
                                                                        .withOpacity(
                                                                            0.7),
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            );
                                                          }
                                                          final amountByn =
                                                              NbrbUsdBynRate
                                                                  .usdToByn(
                                                            amountUsd,
                                                            _usdToByn!,
                                                          );
                                                          return Text(
                                                            '${amountUsd.toStringAsFixed(2)} \$ ≈ ${amountByn.toStringAsFixed(2)} BYN',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'JOST',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          );
                                                        },
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 10.0)),
                                                  ),
                                                ),
                                              ].divide(SizedBox(height: 16.0)),
                                            ),
                                            if (_model.showTypePayment)
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        'Способ оплаты',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'JOST',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                  FlutterFlowChoiceChips(
                                                    options: [
                                                      ChipData(
                                                          'Карта · bePaid',
                                                          Icons
                                                              .radio_button_checked),
                                                      ChipData(
                                                          'Яндекс.Деньги',
                                                          Icons
                                                              .radio_button_checked),
                                                      ChipData(
                                                          'WebMoney',
                                                          Icons
                                                              .radio_button_checked),
                                                      ChipData(
                                                          'Сбербанк',
                                                          Icons
                                                              .radio_button_checked),
                                                      ChipData('Альфа-Клик'),
                                                      ChipData(
                                                          'Терминал оплаты')
                                                    ],
                                                    onChanged: (val) =>
                                                        safeSetState(() => _model
                                                                .choiceChipsValue =
                                                            val?.firstOrNull),
                                                    selectedChipStyle:
                                                        ChipStyle(
                                                      backgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .customColor3,
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily:
                                                                    'JOST',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                      iconColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .telemagenta1,
                                                      iconSize: 18.0,
                                                      labelPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  10.0,
                                                                  10.0,
                                                                  10.0),
                                                      elevation: 0.0,
                                                      borderColor:
                                                          Color(0x878F82E3),
                                                      borderWidth: 1.0,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                    ),
                                                    unselectedChipStyle:
                                                        ChipStyle(
                                                      backgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .customColor5,
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'JOST',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                              ),
                                                      iconColor: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      iconSize: 18.0,
                                                      labelPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  10.0,
                                                                  10.0,
                                                                  10.0),
                                                      elevation: 0.0,
                                                      borderColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .customColor3,
                                                      borderWidth: 1.0,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                    ),
                                                    chipSpacing: 10.0,
                                                    rowSpacing: 10.0,
                                                    multiselect: false,
                                                    alignment:
                                                        WrapAlignment.start,
                                                    controller: _model
                                                            .choiceChipsValueController ??=
                                                        FormFieldController<
                                                            List<String>>(
                                                      [],
                                                    ),
                                                    wrapped: true,
                                                  ),
                                                ].divide(
                                                    SizedBox(height: 16.0)),
                                              ),
                                          ].divide(SizedBox(height: 14.0)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ]
                                  .divide(SizedBox(height: 24.0))
                                  .addToEnd(SizedBox(height: 24.0)),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 0.0, 0.0),
                              child: StreamBuilder<List<RateRecord>>(
                                stream: queryRateRecord(
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
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  List<RateRecord> containerRateRecordList =
                                      snapshot.data!;
                                  // Return an empty Container when the item does not exist.
                                  if (snapshot.data!.isEmpty) {
                                    return Container();
                                  }
                                  final containerRateRecord =
                                      containerRateRecordList.isNotEmpty
                                          ? containerRateRecordList.first
                                          : null;

                                  return InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      if (_model.isPaying) {
                                        return;
                                      }
                                      logFirebaseEvent(
                                          'D_A_M_BALANS_3_POPOLNENYE_10_Container_c');

                                      final amountUsd = double.tryParse(_model
                                          .moneyTextController.text
                                          .replaceAll(',', '.')
                                          .trim());
                                      final bitRate =
                                          containerRateRecord?.exchangeRate;

                                      if (amountUsd == null || amountUsd < 1) {
                                        showSnackbar(
                                          context,
                                          'Минимальная сумма пополнения — 1\$',
                                        );
                                        return;
                                      }
                                      if (bitRate == null || bitRate <= 0) {
                                        showSnackbar(
                                          context,
                                          'Неверный курс конвертации.',
                                        );
                                        return;
                                      }

                                      safeSetState(() => _model.isPaying = true);
                                      try {
                                        logFirebaseEvent(
                                            'Container_bepaid_checkout');
                                        final usdToByn =
                                            await NbrbUsdBynRate.fetchUsdToByn();
                                        final amountByn =
                                            NbrbUsdBynRate.usdToByn(
                                          amountUsd,
                                          usdToByn,
                                        );
                                        if (amountByn <= 0) {
                                          throw Exception(
                                            'Некорректная сумма после конвертации в BYN.',
                                          );
                                        }
                                        final bits =
                                            (amountUsd / bitRate).floor();
                                        if (bits < 1) {
                                          throw Exception(
                                            'Сумма слишком мала для зачисления bit',
                                          );
                                        }
                                        // Cloud credits floor(amountByn / rate).
                                        final cloudRate = amountByn / bits;

                                        final checkout =
                                            await BePaidService.createCheckout(
                                          amount: amountByn,
                                          amountUsd: amountUsd,
                                          rate: cloudRate,
                                          description:
                                              'Пополнение ${amountUsd.toStringAsFixed(2)}\$ · bitMystic',
                                        );
                                        if (!mounted) {
                                          return;
                                        }

                                        final paidResult =
                                            await context.pushNamed(
                                          BePaidCheckoutWidget.routeName,
                                          extra: <String, dynamic>{
                                            'redirectUrl':
                                                checkout.redirectUrl,
                                            'token': checkout.token,
                                          },
                                        );
                                        final paidMap = paidResult is Map
                                            ? Map<String, dynamic>.from(
                                                paidResult as Map)
                                            : null;
                                        final paidOk =
                                            paidMap?['success'] == true ||
                                                paidResult == true;
                                        if (!paidOk) {
                                          if (mounted &&
                                              (paidMap?['success'] == false ||
                                                  paidResult == false)) {
                                            showSnackbar(
                                              context,
                                              'Оплата не завершена',
                                            );
                                          }
                                          return;
                                        }

                                        logFirebaseEvent(
                                            'Container_backend_call');
                                        _model.doc = await BePaidService
                                            .creditSuccessfulTopUp(
                                          amount: amountUsd,
                                          rate: bitRate,
                                          token: checkout.token,
                                          paymentId:
                                              paidMap?['paymentId']?.toString(),
                                        );
                                        _model.cash = _model.doc?.balance ??
                                            valueOrDefault(
                                                currentUserDocument?.balance,
                                                0.0);
                                        safeSetState(() {});
                                        logFirebaseEvent(
                                            'Container_navigate_to');

                                        final paymentNumber =
                                            await queryPaymentsRecordCount(
                                          queryBuilder: (paymentsRecord) =>
                                              paymentsRecord.where(
                                            'user',
                                            isEqualTo: currentUserReference,
                                          ),
                                        );

                                        context.pushNamed(
                                          DABalans2IstoryaODNOPopolnenye9Widget
                                              .routeName,
                                          queryParameters: {
                                            'peymentDoc': serializeParam(
                                              _model.doc,
                                              ParamType.Document,
                                            ),
                                            'paymentNumber': serializeParam(
                                              paymentNumber,
                                              ParamType.int,
                                            ),
                                          }.withoutNulls,
                                          extra: <String, dynamic>{
                                            'peymentDoc': _model.doc,
                                          },
                                        );
                                      } catch (e) {
                                        if (mounted) {
                                          showSnackbar(
                                            context,
                                            e.toString().replaceFirst(
                                                'Exception: ', ''),
                                          );
                                        }
                                      } finally {
                                        if (mounted) {
                                          safeSetState(
                                              () => _model.isPaying = false);
                                        }
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFFBA3AE7),
                                            Color(0xFF6822B9)
                                          ],
                                          stops: [0.0, 1.0],
                                          begin:
                                              AlignmentDirectional(-0.98, 1.0),
                                          end: AlignmentDirectional(0.98, -1.0),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        border: Border.all(
                                          color: Color(0xB5ACA7E1),
                                          width: 2.0,
                                        ),
                                      ),
                                        child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 16.0, 16.0, 16.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            if (_model.isPaying)
                                              SizedBox(
                                                width: 22.0,
                                                height: 22.0,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 2.4,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(
                                                    Colors.white,
                                                  ),
                                                ),
                                              )
                                            else
                                              Icon(
                                                Icons.credit_card_rounded,
                                                color: Colors.white,
                                                size: 24.0,
                                              ),
                                            Text(
                                              _model.isPaying
                                                  ? 'Подключаем bePaid…'
                                                  : 'Оплатить через bePaid',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyLarge
                                                  .override(
                                                    fontFamily: 'JOST',
                                                    color: Colors.white,
                                                    fontSize: 18.0,
                                                    letterSpacing: 0.0,
                                                  ),
                                            ),
                                          ].divide(SizedBox(width: 14.0)),
                                        ),
                                      ),
                                    ),
                                  );
                                },
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
        ],
      ),
    );
  }
}
