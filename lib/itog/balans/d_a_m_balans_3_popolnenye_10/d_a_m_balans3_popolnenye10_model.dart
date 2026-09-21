import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'd_a_m_balans3_popolnenye10_widget.dart'
    show DAMBalans3Popolnenye10Widget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class DAMBalans3Popolnenye10Model
    extends FlutterFlowModel<DAMBalans3Popolnenye10Widget> {
  ///  Local state fields for this page.

  double? cash;

  bool showTypePayment = false;

  bool isPaying = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for money widget.
  FocusNode? moneyFocusNode;
  TextEditingController? moneyTextController;
  String? Function(BuildContext, String?)? moneyTextControllerValidator;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // Stores action output result for [Backend Call - Create Document] action in Container widget.
  PaymentsRecord? doc;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    moneyFocusNode?.dispose();
    moneyTextController?.dispose();
  }
}
