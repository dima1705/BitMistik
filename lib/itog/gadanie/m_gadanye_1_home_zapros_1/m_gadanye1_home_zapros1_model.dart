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
import 'm_gadanye1_home_zapros1_widget.dart' show MGadanye1HomeZapros1Widget;
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

class MGadanye1HomeZapros1Model
    extends FlutterFlowModel<MGadanye1HomeZapros1Widget> {
  ///  Local state fields for this page.

  List<String> imagesForComp = [];
  void addToImagesForComp(String item) => imagesForComp.add(item);
  void removeFromImagesForComp(String item) => imagesForComp.remove(item);
  void removeAtIndexFromImagesForComp(int index) =>
      imagesForComp.removeAt(index);
  void insertAtIndexInImagesForComp(int index, String item) =>
      imagesForComp.insert(index, item);
  void updateImagesForCompAtIndex(int index, Function(String) updateFn) =>
      imagesForComp[index] = updateFn(imagesForComp[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in M_Gadanye_1_Home_Zapros_1 widget.
  UserQuestionnaireRecord? userQuestion;
  // State field(s) for question widget.
  FocusNode? questionFocusNode;
  TextEditingController? questionTextController;
  String? Function(BuildContext, String?)? questionTextControllerValidator;
  // Stores action output result for [Backend Call - API (Get Random Card List)] action in Button widget.
  ApiCallResponse? randomCards;
  // State field(s) for SwipeableStack widget.
  late CardSwiperController swipeableStackController;
  // Model for addCardsCopy component.
  late AddCardsCopyModel addCardsCopyModel;

  @override
  void initState(BuildContext context) {
    swipeableStackController = CardSwiperController();
    addCardsCopyModel = createModel(context, () => AddCardsCopyModel());
  }

  @override
  void dispose() {
    questionFocusNode?.dispose();
    questionTextController?.dispose();

    addCardsCopyModel.dispose();
  }
}
