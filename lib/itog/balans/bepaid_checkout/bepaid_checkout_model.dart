import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'bepaid_checkout_widget.dart' show BePaidCheckoutWidget;

class BePaidCheckoutModel extends FlutterFlowModel<BePaidCheckoutWidget> {
  WebViewController? webViewController;
  bool isLoading = true;
  String? errorMessage;
  bool finishing = false;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
