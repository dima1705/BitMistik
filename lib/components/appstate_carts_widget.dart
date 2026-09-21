import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'appstate_carts_model.dart';
export 'appstate_carts_model.dart';

class AppstateCartsWidget extends StatefulWidget {
  const AppstateCartsWidget({super.key});

  @override
  State<AppstateCartsWidget> createState() => _AppstateCartsWidgetState();
}

class _AppstateCartsWidgetState extends State<AppstateCartsWidget> {
  late AppstateCartsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AppstateCartsModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(8.0, 20.0, 8.0, 20.0),
          child: Material(
            color: Colors.transparent,
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Container(
              width: 88.2,
              height: 134.03,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).customColor5,
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: Image.asset(
                    'assets/images/___(17).png',
                  ).image,
                ),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: FlutterFlowTheme.of(context).tertiary,
                  width: 1.0,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(8.0, 20.0, 8.0, 20.0),
          child: Material(
            color: Colors.transparent,
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Container(
              width: 88.2,
              height: 134.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).customColor5,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: FlutterFlowTheme.of(context).tertiary,
                  width: 1.0,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(8.0, 20.0, 8.0, 20.0),
          child: Material(
            color: Colors.transparent,
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Container(
              width: 88.2,
              height: 134.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).customColor5,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: FlutterFlowTheme.of(context).tertiary,
                  width: 1.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
