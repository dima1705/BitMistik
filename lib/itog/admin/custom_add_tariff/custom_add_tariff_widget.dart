import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'custom_add_tariff_model.dart';
export 'custom_add_tariff_model.dart';

class CustomAddTariffWidget extends StatefulWidget {
  const CustomAddTariffWidget({
    super.key,
    this.tarif,
  });

  final TariffRecord? tarif;

  @override
  State<CustomAddTariffWidget> createState() => _CustomAddTariffWidgetState();
}

class _CustomAddTariffWidgetState extends State<CustomAddTariffWidget> {
  late CustomAddTariffModel _model;
  bool _saving = false;
  String? _error;

  bool get _isEdit => widget.tarif != null;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CustomAddTariffModel());

    _model.textController1 ??=
        TextEditingController(text: widget.tarif?.tariffType ?? '');
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??=
        TextEditingController(text: widget.tarif?.price.toString() ?? '');
    _model.textFieldFocusNode2 ??= FocusNode();

    _model.textController3 ??=
        TextEditingController(text: widget.tarif?.description ?? '');
    _model.textFieldFocusNode3 ??= FocusNode();

    _model.textController4 ??= TextEditingController(
        text: widget.tarif?.countAiResponce.toString() ?? '');
    _model.textFieldFocusNode4 ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  InputDecoration _fieldDecoration(BuildContext context, String hint) {
    final theme = FlutterFlowTheme.of(context);
    final border = OutlineInputBorder(
      borderSide: BorderSide(
        color: theme.customColor3.withValues(alpha: 0.55),
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(12.0),
    );
    return InputDecoration(
      isDense: true,
      hintText: hint,
      hintStyle: theme.labelMedium.override(
        fontFamily: 'JOST',
        color: theme.primaryText.withValues(alpha: 0.45),
        letterSpacing: 0.0,
      ),
      enabledBorder: border,
      focusedBorder: border.copyWith(
        borderSide: BorderSide(color: theme.primary, width: 1.2),
      ),
      errorBorder: border.copyWith(
        borderSide: BorderSide(color: theme.error, width: 1.0),
      ),
      focusedErrorBorder: border.copyWith(
        borderSide: BorderSide(color: theme.error, width: 1.2),
      ),
      filled: true,
      fillColor: theme.secondaryBackground,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
    );
  }

  TextStyle _labelStyle(BuildContext context) {
    return FlutterFlowTheme.of(context).bodyMedium.override(
          fontFamily: 'JOST',
          color: FlutterFlowTheme.of(context).secondaryBackground,
          fontSize: 13.0,
          letterSpacing: 0.0,
          fontWeight: FontWeight.w500,
        );
  }

  TextStyle _inputStyle(BuildContext context) {
    return FlutterFlowTheme.of(context).bodyMedium.override(
          fontFamily: 'JOST',
          color: FlutterFlowTheme.of(context).primaryText,
          letterSpacing: 0.0,
        );
  }

  Future<void> _save() async {
    if (_saving) {
      return;
    }

    final name = _model.textController1.text.trim();
    final price = int.tryParse(_model.textController2.text.trim());
    final description = _model.textController3.text.trim();
    final bits = int.tryParse(_model.textController4.text.trim());

    if (name.isEmpty) {
      safeSetState(() => _error = 'Укажите название тарифа');
      return;
    }
    if (price == null || price < 1) {
      safeSetState(() => _error = 'Цена от 1\$');
      return;
    }
    if (bits == null || bits < 1) {
      safeSetState(() => _error = 'Укажите количество bit');
      return;
    }

    safeSetState(() {
      _saving = true;
      _error = null;
    });

    try {
      final data = createTariffRecordData(
        tariffType: name,
        description: description,
        price: price,
        countAiResponce: bits,
        isActive: widget.tarif?.isActive ?? true,
      );

      if (widget.tarif != null) {
        await widget.tarif!.reference.update(data);
      } else {
        await TariffRecord.collection.doc().set(data);
      }

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        safeSetState(() {
          _saving = false;
          _error = e.toString().replaceFirst('Exception: ', '');
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 400.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [theme.customColor3, theme.customColor4],
            begin: const AlignmentDirectional(-0.98, 1.0),
            end: const AlignmentDirectional(0.98, -1.0),
          ),
          borderRadius: BorderRadius.circular(22.0),
          border: Border.all(
            color: const Color(0xFFFFE183).withValues(alpha: 0.35),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 20.0),
          child: Form(
            key: _model.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _isEdit ? 'Редактировать тариф' : 'Новый тариф',
                        style: theme.titleMedium.override(
                          fontFamily: 'JOST',
                          color: theme.secondaryBackground,
                          fontSize: 20.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      visualDensity: VisualDensity.compact,
                      icon: Icon(
                        Icons.close_rounded,
                        color: theme.secondaryBackground,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Цена в \$ · bit зачисляются после оплаты',
                  style: theme.bodySmall.override(
                    fontFamily: 'JOST',
                    color: theme.secondaryBackground.withValues(alpha: 0.7),
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 18.0),
                Text('Название', style: _labelStyle(context)),
                const SizedBox(height: 6.0),
                TextFormField(
                  controller: _model.textController1,
                  focusNode: _model.textFieldFocusNode1,
                  textInputAction: TextInputAction.next,
                  decoration: _fieldDecoration(context, 'Например, Стандарт'),
                  style: _inputStyle(context),
                  cursorColor: theme.primary,
                ),
                const SizedBox(height: 14.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Цена, \$', style: _labelStyle(context)),
                          const SizedBox(height: 6.0),
                          TextFormField(
                            controller: _model.textController2,
                            focusNode: _model.textFieldFocusNode2,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: _fieldDecoration(context, '1'),
                            style: _inputStyle(context),
                            cursorColor: theme.primary,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Bit', style: _labelStyle(context)),
                          const SizedBox(height: 6.0),
                          TextFormField(
                            controller: _model.textController4,
                            focusNode: _model.textFieldFocusNode4,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: _fieldDecoration(context, '45'),
                            style: _inputStyle(context),
                            cursorColor: theme.primary,
                            onChanged: (_) => safeSetState(() {}),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Builder(
                  builder: (context) {
                    final bits =
                        int.tryParse(_model.textController4.text.trim()) ?? 0;
                    if (bits <= 0) {
                      return const SizedBox.shrink();
                    }
                    final readings = bits ~/ 3;
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '~$readings гаданий · 3 bit = 1 гадание',
                        style: theme.bodySmall.override(
                          fontFamily: 'JOST',
                          color: const Color(0xFFFFE183)
                              .withValues(alpha: 0.85),
                          letterSpacing: 0.0,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 14.0),
                Text('Описание', style: _labelStyle(context)),
                const SizedBox(height: 6.0),
                TextFormField(
                  controller: _model.textController3,
                  focusNode: _model.textFieldFocusNode3,
                  minLines: 3,
                  maxLines: 4,
                  textInputAction: TextInputAction.done,
                  decoration: _fieldDecoration(
                    context,
                    'Коротко, что даёт пакет',
                  ),
                  style: _inputStyle(context),
                  cursorColor: theme.primary,
                ),
                if (_error != null) ...[
                  const SizedBox(height: 12.0),
                  Text(
                    _error!,
                    style: theme.bodySmall.override(
                      fontFamily: 'JOST',
                      color: theme.error,
                      letterSpacing: 0.0,
                    ),
                  ),
                ],
                const SizedBox(height: 20.0),
                FFButtonWidget(
                  onPressed: _saving ? null : _save,
                  text: _saving
                      ? 'Сохраняем…'
                      : (_isEdit ? 'Сохранить' : 'Добавить тариф'),
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 48.0,
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        16.0, 0.0, 16.0, 0.0),
                    color: theme.primary,
                    textStyle: theme.titleSmall.override(
                      fontFamily: 'JOST',
                      color: Colors.white,
                      letterSpacing: 0.0,
                    ),
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(14.0),
                    disabledColor: theme.primary.withValues(alpha: 0.5),
                    disabledTextColor: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
