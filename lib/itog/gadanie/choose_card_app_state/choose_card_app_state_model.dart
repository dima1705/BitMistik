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
import 'choose_card_app_state_widget.dart' show ChooseCardAppStateWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChooseCardAppStateModel
    extends FlutterFlowModel<ChooseCardAppStateWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (Send Prompt)] action in IconButton widget.
  ApiCallResponse? ai;
  // Stores action output result for [Backend Call - Create Document] action in IconButton widget.
  FortuneTellingRecord? aIresponse;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
