import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/title_with_subtitle/title_with_subtitle_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'setting_passw_delite_widget.dart' show SettingPasswDeliteWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SettingPasswDeliteModel
    extends FlutterFlowModel<SettingPasswDeliteWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for titleWithSubtitle component.
  late TitleWithSubtitleModel titleWithSubtitleModel1;
  // State field(s) for e-mail widget.
  FocusNode? eMailFocusNode;
  TextEditingController? eMailTextController;
  String? Function(BuildContext, String?)? eMailTextControllerValidator;
  // Model for titleWithSubtitle component.
  late TitleWithSubtitleModel titleWithSubtitleModel2;
  // Model for titleWithSubtitle component.
  late TitleWithSubtitleModel titleWithSubtitleModel3;

  @override
  void initState(BuildContext context) {
    titleWithSubtitleModel1 =
        createModel(context, () => TitleWithSubtitleModel());
    titleWithSubtitleModel2 =
        createModel(context, () => TitleWithSubtitleModel());
    titleWithSubtitleModel3 =
        createModel(context, () => TitleWithSubtitleModel());
  }

  @override
  void dispose() {
    titleWithSubtitleModel1.dispose();
    eMailFocusNode?.dispose();
    eMailTextController?.dispose();

    titleWithSubtitleModel2.dispose();
    titleWithSubtitleModel3.dispose();
  }
}
