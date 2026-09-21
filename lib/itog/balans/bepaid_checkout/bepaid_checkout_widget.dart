import '/backend/bepaid/bepaid_config.dart';
import '/backend/bepaid/bepaid_service.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'bepaid_checkout_model.dart';
export 'bepaid_checkout_model.dart';

class BePaidCheckoutWidget extends StatefulWidget {
  const BePaidCheckoutWidget({
    super.key,
    required this.redirectUrl,
    required this.token,
  });

  final String redirectUrl;
  final String token;

  static String routeName = 'BePaidCheckout';
  static String routePath = 'bepaid-checkout';

  @override
  State<BePaidCheckoutWidget> createState() => _BePaidCheckoutWidgetState();
}

class _BePaidCheckoutWidgetState extends State<BePaidCheckoutWidget> {
  late BePaidCheckoutModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BePaidCheckoutModel());
    logFirebaseEvent('screen_view', parameters: {'screen_name': 'BePaidCheckout'});
    _initWebView();
  }

  Future<void> _initWebView() async {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFF050E42))
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            if (_handleReturnUrl(request.url)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onPageStarted: (url) {
            _handleReturnUrl(url);
          },
          onPageFinished: (url) {
            if (mounted) {
              safeSetState(() => _model.isLoading = false);
            }
            _handleReturnUrl(url);
          },
          onWebResourceError: (error) {
            if (_model.finishing || !mounted) {
              return;
            }
            if (error.isForMainFrame == false) {
              return;
            }
            safeSetState(() {
              _model.isLoading = false;
              _model.errorMessage =
                  'Не удалось открыть страницу оплаты. Проверьте интернет и попробуйте снова.';
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.redirectUrl));

    _model.webViewController = controller;
    safeSetState(() {});
  }

  bool _handleReturnUrl(String url) {
    if (_model.finishing) {
      return true;
    }

    if (BePaidService.isReturnUrl(url, BePaidConfig.successPath)) {
      _finish(url: url, successHint: true);
      return true;
    }
    if (BePaidService.isReturnUrl(url, BePaidConfig.failPath) ||
        BePaidService.isReturnUrl(url, BePaidConfig.declinePath) ||
        BePaidService.isReturnUrl(url, BePaidConfig.cancelPath)) {
      _finish(url: url, successHint: false);
      return true;
    }
    return false;
  }

  Future<void> _finish({
    required String url,
    required bool successHint,
  }) async {
    if (_model.finishing) {
      return;
    }
    _model.finishing = true;
    if (mounted) {
      safeSetState(() => _model.isLoading = true);
    }

    BePaidConfirmResult result = BePaidConfirmResult(success: successHint);
    try {
      result = await BePaidService.confirmPayment(
        widget.token,
        returnUrl: url,
      );
      if (!result.success &&
          successHint &&
          Uri.tryParse(url)?.queryParameters['status'] == 'successful') {
        result = const BePaidConfirmResult(success: true);
      }
    } catch (_) {
      result = BePaidConfirmResult(success: successHint);
    }

    if (!mounted) {
      return;
    }
    context.pop(<String, dynamic>{
      'success': result.success,
      'paymentId': result.paymentId,
    });
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          onPressed: () {
            if (_model.finishing) {
              return;
            }
            context.pop(false);
          },
        ),
        title: Text(
          'Оплата bePaid',
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
          if (_model.errorMessage != null)
            _ErrorState(
              message: _model.errorMessage!,
              onRetry: () {
                safeSetState(() {
                  _model.errorMessage = null;
                  _model.isLoading = true;
                  _model.finishing = false;
                });
                _initWebView();
              },
            )
          else if (_model.webViewController != null)
            WebViewWidget(controller: _model.webViewController!),
          if (_model.isLoading && _model.errorMessage == null)
            Container(
              color: const Color(0xCC050E42),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 46.0,
                      height: 46.0,
                      child: CircularProgressIndicator(
                        strokeWidth: 3.0,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          FlutterFlowTheme.of(context).customColor2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      _model.finishing
                          ? 'Проверяем оплату…'
                          : 'Открываем безопасную оплату bePaid',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'JOST',
                            color: const Color(0xFFFFE183),
                            letterSpacing: 0.0,
                          ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: FlutterFlowTheme.of(context).customColor4,
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.credit_card_off_rounded,
            color: FlutterFlowTheme.of(context).customColor2,
            size: 42.0,
          ),
          const SizedBox(height: 16.0),
          Text(
            message,
            textAlign: TextAlign.center,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'JOST',
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  fontSize: 16.0,
                  letterSpacing: 0.0,
                ),
          ),
          const SizedBox(height: 24.0),
          InkWell(
            onTap: onRetry,
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFBA3AE7), Color(0xFF6822B9)],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
                borderRadius: BorderRadius.circular(50.0),
                border: Border.all(color: const Color(0xB5ACA7E1), width: 2.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 14.0),
              child: Text(
                'Повторить',
                style: FlutterFlowTheme.of(context).bodyLarge.override(
                      fontFamily: 'JOST',
                      color: Colors.white,
                      letterSpacing: 0.0,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
