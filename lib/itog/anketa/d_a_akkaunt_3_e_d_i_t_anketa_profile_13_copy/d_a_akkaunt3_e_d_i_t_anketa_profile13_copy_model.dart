import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:math';
import 'dart:ui';
import '/index.dart';
import 'd_a_akkaunt3_e_d_i_t_anketa_profile13_copy_widget.dart'
    show DAAkkaunt3EDITAnketaProfile13CopyWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class DAAkkaunt3EDITAnketaProfile13CopyModel
    extends FlutterFlowModel<DAAkkaunt3EDITAnketaProfile13CopyWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  bool isDataUploading_userPhoto = false;
  FFUploadedFile uploadedLocalFile_userPhoto =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_userPhoto = '';

  // State field(s) for yourName widget.
  FocusNode? yourNameFocusNode;
  TextEditingController? yourNameTextController;
  String? Function(BuildContext, String?)? yourNameTextControllerValidator;
  String? _yourNameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for instagram widget.
  FocusNode? instagramFocusNode;
  TextEditingController? instagramTextController;
  String? Function(BuildContext, String?)? instagramTextControllerValidator;
  // State field(s) for Country widget.
  FocusNode? countryFocusNode;
  TextEditingController? countryTextController;
  String? Function(BuildContext, String?)? countryTextControllerValidator;
  // State field(s) for SexDropDown widget.
  String? sexDropDownValue;
  FormFieldController<String>? sexDropDownValueController;
  // State field(s) for Age widget.
  FocusNode? ageFocusNode;
  TextEditingController? ageTextController;
  String? Function(BuildContext, String?)? ageTextControllerValidator;
  // State field(s) for MarStatDropDown widget.
  String? marStatDropDownValue;
  FormFieldController<String>? marStatDropDownValueController;
  // State field(s) for Color widget.
  FocusNode? colorFocusNode;
  TextEditingController? colorTextController;
  String? Function(BuildContext, String?)? colorTextControllerValidator;
  // State field(s) for Film widget.
  FocusNode? filmFocusNode;
  TextEditingController? filmTextController;
  String? Function(BuildContext, String?)? filmTextControllerValidator;
  // State field(s) for Book widget.
  FocusNode? bookFocusNode;
  TextEditingController? bookTextController;
  String? Function(BuildContext, String?)? bookTextControllerValidator;
  // State field(s) for Profession widget.
  FocusNode? professionFocusNode;
  TextEditingController? professionTextController;
  String? Function(BuildContext, String?)? professionTextControllerValidator;
  // State field(s) for Hobby widget.
  FocusNode? hobbyFocusNode;
  TextEditingController? hobbyTextController;
  String? Function(BuildContext, String?)? hobbyTextControllerValidator;

  @override
  void initState(BuildContext context) {
    yourNameTextControllerValidator = _yourNameTextControllerValidator;
  }

  @override
  void dispose() {
    yourNameFocusNode?.dispose();
    yourNameTextController?.dispose();

    instagramFocusNode?.dispose();
    instagramTextController?.dispose();

    countryFocusNode?.dispose();
    countryTextController?.dispose();

    ageFocusNode?.dispose();
    ageTextController?.dispose();

    colorFocusNode?.dispose();
    colorTextController?.dispose();

    filmFocusNode?.dispose();
    filmTextController?.dispose();

    bookFocusNode?.dispose();
    bookTextController?.dispose();

    professionFocusNode?.dispose();
    professionTextController?.dispose();

    hobbyFocusNode?.dispose();
    hobbyTextController?.dispose();
  }
}
