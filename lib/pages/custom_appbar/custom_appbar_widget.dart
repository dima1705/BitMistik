import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'custom_appbar_model.dart';
export 'custom_appbar_model.dart';

class CustomAppbarWidget extends StatefulWidget {
  const CustomAppbarWidget({
    super.key,
    required this.backButton,
    bool? actionButton,
    this.actionButtonText,
    this.actionButtonAction,
    bool? optionsButton,
    required this.optionsButtonAction,
  })  : this.actionButton = actionButton ?? false,
        this.optionsButton = optionsButton ?? false;

  final bool? backButton;
  final bool actionButton;
  final String? actionButtonText;
  final Future Function()? actionButtonAction;
  final bool optionsButton;
  final Future Function()? optionsButtonAction;

  @override
  State<CustomAppbarWidget> createState() => _CustomAppbarWidgetState();
}

class _CustomAppbarWidgetState extends State<CustomAppbarWidget> {
  late CustomAppbarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CustomAppbarModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0x682B1949),
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
          logFirebaseEvent('CUSTOM_APPBAR_COMP_angleLeft_ICN_ON_TAP');
          logFirebaseEvent('IconButton_navigate_back');
          context.pop();
        },
      ),
      title: Text(
        'Ваша анкета',
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
    );
  }
}
