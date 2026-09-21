import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/new_des/test/sovet_dnya_copy/sovet_dnya_copy_widget.dart';
import 'dart:ui';
import 'test_card_advice_widget.dart' show TestCardAdviceWidget;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TestCardAdviceModel extends FlutterFlowModel<TestCardAdviceWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (Get Random Card List)] action in Button widget.
  ApiCallResponse? randomCards;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
