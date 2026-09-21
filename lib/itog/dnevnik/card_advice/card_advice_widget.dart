import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'card_advice_model.dart';
export 'card_advice_model.dart';

class AdviceDialogResult {
  const AdviceDialogResult({
    this.diary,
    this.openDiary = false,
  });

  final DiaryRecord? diary;
  final bool openDiary;
}

class CardAdviceWidget extends StatefulWidget {
  const CardAdviceWidget({
    super.key,
    required this.title,
    required this.image,
    required this.loadFuture,
  });

  final String? title;
  final String? image;
  final Future<({String advice, DiaryRecord diary})> loadFuture;

  @override
  State<CardAdviceWidget> createState() => _CardAdviceWidgetState();
}

class _CardAdviceWidgetState extends State<CardAdviceWidget> {
  late CardAdviceModel _model;
  bool _loading = true;
  String _advice = '';
  DiaryRecord? _diary;
  String? _error;

  static const _imagePlaceholder = Color(0xFF1A1630);

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CardAdviceModel());
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    try {
      final result = await widget.loadFuture;
      if (!mounted) {
        return;
      }
      setState(() {
        _advice = result.advice;
        _diary = result.diary;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) {
        return;
      }
      setState(() {
        _loading = false;
        _error = 'Не удалось получить совет. Попробуйте позже.';
      });
    }
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  void _close({required bool openDiary}) {
    if (!mounted) {
      return;
    }
    Navigator.of(context, rootNavigator: true).pop(
      AdviceDialogResult(
        diary: _diary,
        openDiary: openDiary && _diary != null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final imageUrl = (widget.image ?? '').trim();

    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(24.0, 20.0, 24.0, 20.0),
              child: Material(
                color: Colors.transparent,
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height * 0.82,
                  constraints: const BoxConstraints(maxHeight: 680.0),
                  decoration: BoxDecoration(
                    color: theme.customColor5,
                    borderRadius: BorderRadius.circular(24.0),
                    border: Border.all(
                      color: theme.tertiary,
                      width: 1.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${widget.title ?? ''}✨',
                            textAlign: TextAlign.center,
                            style: theme.bodyMedium.override(
                              fontFamily: 'JOST',
                              color: theme.secondaryBackground,
                              fontSize: 26.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Material(
                            color: Colors.transparent,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: imageUrl.isEmpty
                                  ? Container(
                                      width: 250.0,
                                      height: 380.0,
                                      color: _imagePlaceholder,
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: imageUrl,
                                      width: 250.0,
                                      height: 380.0,
                                      fit: BoxFit.cover,
                                      fadeInDuration: Duration.zero,
                                      fadeOutDuration: Duration.zero,
                                      placeholder: (_, __) => Container(
                                        width: 250.0,
                                        height: 380.0,
                                        color: _imagePlaceholder,
                                      ),
                                      errorWidget: (_, __, ___) => Container(
                                        width: 250.0,
                                        height: 380.0,
                                        color: _imagePlaceholder,
                                        alignment: Alignment.center,
                                        child: Icon(
                                          Icons.image_not_supported_outlined,
                                          color: theme.secondaryBackground,
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          if (_loading)
                            Column(
                              children: [
                                const SizedBox(
                                  width: 28.0,
                                  height: 28.0,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.4,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Color(0xFFE5E5E5),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12.0),
                                Text(
                                  'Готовим совет дня…',
                                  style: theme.bodyMedium.override(
                                    fontFamily: 'JOST',
                                    color: theme.secondaryBackground
                                        .withValues(alpha: 0.85),
                                    letterSpacing: 0.0,
                                  ),
                                ),
                              ],
                            )
                          else if (_error != null)
                            Text(
                              _error!,
                              textAlign: TextAlign.center,
                              style: theme.bodyMedium.override(
                                fontFamily: 'JOST',
                                color: theme.error,
                                letterSpacing: 0.0,
                              ),
                            )
                          else
                            Text(
                              _advice,
                              textAlign: TextAlign.center,
                              style: theme.bodyMedium.override(
                                fontFamily: 'JOST',
                                color: theme.secondaryBackground,
                                fontSize: 16.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          const SizedBox(height: 20.0),
                          if (!_loading && _diary != null)
                            FFButtonLike(
                              label: 'Открыть запись',
                              onTap: () async => _close(openDiary: true),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: const AlignmentDirectional(0.91, -0.88),
          child: SafeArea(
            child: FlutterFlowIconButton(
              borderColor: theme.tertiary,
              borderRadius: 25.0,
              borderWidth: 2.0,
              buttonSize: 50.0,
              fillColor: theme.customColor5,
              icon: Icon(
                Icons.close_rounded,
                color: theme.secondaryBackground,
                size: 24.0,
              ),
              onPressed: () => _close(openDiary: false),
            ),
          ),
        ),
      ],
    );
  }
}

class FFButtonLike extends StatelessWidget {
  const FFButtonLike({
    super.key,
    required this.label,
    required this.onTap,
  });

  final String label;
  final Future<void> Function() onTap;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(50.0),
        onTap: onTap,
        child: Ink(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFBA3AE7), Color(0xFF6822B9)],
              begin: AlignmentDirectional(-0.98, 1.0),
              end: AlignmentDirectional(0.98, -1.0),
            ),
            borderRadius: BorderRadius.circular(50.0),
            border: Border.all(
              color: const Color(0xB5ACA7E1),
              width: 2.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: theme.bodyMedium.override(
                fontFamily: 'JOST',
                color: theme.secondaryBackground,
                fontSize: 16.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
