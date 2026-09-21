import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/title_with_subtitle/title_with_subtitle_widget.dart';
import '/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'setting_passw_delite_model.dart';
export 'setting_passw_delite_model.dart';

class SettingPasswDeliteWidget extends StatefulWidget {
  const SettingPasswDeliteWidget({super.key});

  static String routeName = 'SettingPasswDelite';
  static String routePath = 'SettingPasswDelite';

  @override
  State<SettingPasswDeliteWidget> createState() =>
      _SettingPasswDeliteWidgetState();
}

class _SettingPasswDeliteWidgetState extends State<SettingPasswDeliteWidget> {
  late SettingPasswDeliteModel _model;
  bool _busyEmail = false;
  bool _busyReset = false;
  bool _busyDelete = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  FirebaseAuthManager get _firebaseAuth => authManager;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SettingPasswDeliteModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'SettingPasswDelite'});
    _model.eMailTextController ??= TextEditingController(
      text: currentUserEmail,
    );
    _model.eMailFocusNode ??= FocusNode();
    _model.eMailTextControllerValidator = _emailValidator;

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  String? _emailValidator(BuildContext context, String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) {
      return 'Введите почту';
    }
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(email)) {
      return 'Некорректный e-mail';
    }
    return null;
  }

  void _showSnack(String message, {bool isError = false}) {
    if (!mounted) {
      return;
    }
    final theme = FlutterFlowTheme.of(context);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: theme.secondaryBackground),
        ),
        backgroundColor: isError ? theme.error : theme.tertiary,
        duration: const Duration(milliseconds: 4000),
      ),
    );
  }

  bool get _hasPasswordProvider {
    final providers =
        FirebaseAuth.instance.currentUser?.providerData ?? const [];
    return providers.any((p) => p.providerId == 'password');
  }

  Future<String?> _askPassword({
    required String title,
    required String subtitle,
  }) async {
    final theme = FlutterFlowTheme.of(context);
    final controller = TextEditingController();
    var obscure = true;

    final result = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: theme.customColor4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(color: theme.customColor3, width: 0.8),
              ),
              title: Text(
                title,
                style: theme.titleMedium.override(
                  fontFamily: 'JOST',
                  color: theme.secondaryBackground,
                  letterSpacing: 0.0,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    subtitle,
                    style: theme.bodyMedium.override(
                      fontFamily: 'JOST',
                      color: theme.secondaryBackground.withValues(alpha: 0.8),
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: controller,
                    obscureText: obscure,
                    autofocus: true,
                    style: theme.bodyMedium.override(
                      fontFamily: 'JOST',
                      color: theme.secondaryBackground,
                      letterSpacing: 0.0,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Пароль',
                      labelStyle: theme.labelMedium.override(
                        fontFamily: 'JOST',
                        color: theme.secondaryBackground,
                        letterSpacing: 0.0,
                      ),
                      filled: true,
                      fillColor: theme.customColor5,
                      suffixIcon: IconButton(
                        onPressed: () =>
                            setDialogState(() => obscure = !obscure),
                        icon: Icon(
                          obscure
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: theme.secondaryBackground,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: theme.customColor3,
                          width: 0.8,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: theme.primary,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onSubmitted: (_) {
                      if (controller.text.isNotEmpty) {
                        Navigator.of(dialogContext).pop(controller.text);
                      }
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: Text(
                    'Отмена',
                    style: theme.bodyMedium.override(
                      fontFamily: 'JOST',
                      color: theme.secondaryBackground,
                      letterSpacing: 0.0,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (controller.text.isEmpty) {
                      return;
                    }
                    Navigator.of(dialogContext).pop(controller.text);
                  },
                  child: Text(
                    'Подтвердить',
                    style: theme.bodyMedium.override(
                      fontFamily: 'JOST',
                      color: theme.primary,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );

    controller.dispose();
    return result;
  }

  Future<bool> _confirmDelete() async {
    final theme = FlutterFlowTheme.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: theme.customColor4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(color: theme.customColor3, width: 0.8),
          ),
          title: Text(
            'Удалить аккаунт?',
            style: theme.titleMedium.override(
              fontFamily: 'JOST',
              color: theme.secondaryBackground,
              letterSpacing: 0.0,
            ),
          ),
          content: Text(
            'Это действие необратимо. Профиль и связанные данные будут удалены.',
            style: theme.bodyMedium.override(
              fontFamily: 'JOST',
              color: theme.secondaryBackground.withValues(alpha: 0.85),
              letterSpacing: 0.0,
              fontWeight: FontWeight.w300,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(
                'Отмена',
                style: theme.bodyMedium.override(
                  fontFamily: 'JOST',
                  color: theme.secondaryBackground,
                  letterSpacing: 0.0,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(
                'Удалить',
                style: theme.bodyMedium.override(
                  fontFamily: 'JOST',
                  color: theme.error,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
    return confirmed == true;
  }

  Future<void> _changeEmail() async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final newEmail = _model.eMailTextController.text.trim();
    if (newEmail.toLowerCase() == currentUserEmail.toLowerCase()) {
      _showSnack('Это уже ваша текущая почта.');
      return;
    }

    if (!_hasPasswordProvider) {
      _showSnack(
        'Смена почты доступна для аккаунта с паролем. Войдите через e-mail.',
        isError: true,
      );
      return;
    }

    final password = await _askPassword(
      title: 'Подтвердите пароль',
      subtitle: 'Для смены почты нужно подтвердить текущий пароль.',
    );
    if (password == null) {
      return;
    }

    safeSetState(() => _busyEmail = true);
    try {
      logFirebaseEvent('SETTING_PASSW_DELITE_PAGE____BTN_ON_TAP');
      await _firebaseAuth.reauthenticateWithPassword(password);

      final ok = await authManager.updateEmail(
        email: newEmail,
        context: context,
      );
      if (!mounted) {
        return;
      }
      if (ok) {
        final authEmail = FirebaseAuth.instance.currentUser?.email;
        if (authEmail != null &&
            authEmail.toLowerCase() == newEmail.toLowerCase()) {
          _showSnack('Почта успешно изменена.');
        } else {
          _showSnack(
            'На новую почту отправлено письмо. Подтвердите переход по ссылке.',
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      _showSnack(
        e.code == 'wrong-password' || e.code == 'invalid-credential'
            ? 'Неверный пароль.'
            : (e.message ?? 'Не удалось сменить почту.'),
        isError: true,
      );
    } catch (e) {
      _showSnack('Не удалось сменить почту: $e', isError: true);
    } finally {
      if (mounted) {
        safeSetState(() => _busyEmail = false);
      }
    }
  }

  Future<void> _resetPassword() async {
    FocusScope.of(context).unfocus();
    final email = currentUserEmail.trim().isNotEmpty
        ? currentUserEmail.trim()
        : _model.eMailTextController.text.trim();

    if (email.isEmpty) {
      _showSnack('Не найдена почта для сброса пароля.', isError: true);
      return;
    }
    if (!_hasPasswordProvider) {
      _showSnack(
        'Сброс пароля доступен только для входа по e-mail и паролю.',
        isError: true,
      );
      return;
    }

    safeSetState(() => _busyReset = true);
    try {
      logFirebaseEvent('SETTING_PASSW_DELITE_PAGE___BTN_ON_TAP');
      await authManager.resetPassword(
        email: email,
        context: context,
      );
    } finally {
      if (mounted) {
        safeSetState(() => _busyReset = false);
      }
    }
  }

  Future<void> _deleteAccount() async {
    FocusScope.of(context).unfocus();
    if (!await _confirmDelete()) {
      return;
    }

    if (!_hasPasswordProvider) {
      _showSnack(
        'Удаление доступно для аккаунта с паролем. Войдите через e-mail.',
        isError: true,
      );
      return;
    }

    final password = await _askPassword(
      title: 'Подтвердите удаление',
      subtitle: 'Введите пароль, чтобы навсегда удалить аккаунт.',
    );
    if (password == null) {
      return;
    }

    safeSetState(() => _busyDelete = true);
    try {
      logFirebaseEvent('SETTING_PASSW_DELITE_PAGE___BTN_ON_TAP');
      await _firebaseAuth.reauthenticateWithPassword(password);
      // Same pattern as sign-out: suppress auth-driven rebuild, then navigate.
      GoRouter.of(context).prepareAuthEvent();
      final ok = await authManager.deleteUser(context);
      GoRouter.of(context).clearRedirectLocation();
      if (!mounted) {
        return;
      }
      if (ok) {
        logFirebaseEvent('Button_navigate_to');
        context.goNamedAuth(SplashWidget.routeName, context.mounted);
        return;
      }
    } on FirebaseAuthException catch (e) {
      _showSnack(
        e.code == 'wrong-password' || e.code == 'invalid-credential'
            ? 'Неверный пароль.'
            : (e.message ?? 'Не удалось удалить аккаунт.'),
        isError: true,
      );
    } catch (e) {
      _showSnack('Не удалось удалить аккаунт: $e', isError: true);
    } finally {
      if (mounted) {
        safeSetState(() => _busyDelete = false);
      }
    }
  }

  Widget _actionButton({
    required String text,
    required VoidCallback? onPressed,
    required bool loading,
    Color? borderColor,
  }) {
    final theme = FlutterFlowTheme.of(context);
    return FFButtonWidget(
      onPressed: loading ? null : onPressed,
      text: loading ? 'Подождите…' : text,
      options: FFButtonOptions(
        width: double.infinity,
        height: 50.0,
        padding: EdgeInsets.zero,
        iconAlignment: IconAlignment.end,
        iconPadding: EdgeInsets.zero,
        color: const Color(0x5B6D5FED),
        textStyle: theme.bodyMedium.override(
          fontFamily: 'JOST',
          color: theme.secondaryBackground,
          letterSpacing: 0.0,
        ),
        elevation: 0.0,
        borderSide: BorderSide(
          color: borderColor ?? theme.primary,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(25.0),
        disabledColor: const Color(0x3B6D5FED),
        disabledTextColor: theme.secondaryBackground.withValues(alpha: 0.6),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final anyBusy = _busyEmail || _busyReset || _busyDelete;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: theme.primaryText,
        appBar: AppBar(
          backgroundColor: theme.customColor4,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 54.0,
            icon: FaIcon(
              FontAwesomeIcons.angleLeft,
              color: theme.secondaryBackground,
              size: 24.0,
            ),
            onPressed: anyBusy
                ? null
                : () async {
                    logFirebaseEvent(
                        'SETTING_PASSW_DELITE_angleLeft_ICN_ON_TA');
                    logFirebaseEvent('IconButton_navigate_back');
                    context.pop();
                  },
          ),
          title: Text(
            'Персональные настройки',
            style: theme.titleSmall.override(
              fontFamily: 'JOST',
              color: theme.info,
              fontSize: 20.0,
              letterSpacing: 0.0,
            ),
          ),
          actions: const [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/bitmystic-1.firebasestorage.app/o/osnova%2F%D0%94%D0%B8%D0%B7%D0%B0%D0%B9%D0%BD%20%D0%B1%D0%B5%D0%B7%20%D0%BD%D0%B0%D0%B7%D0%B2%D0%B0%D0%BD%D0%B8%D1%8F%20(7).png?alt=media&token=a1b19f70-df11-4ca5-a0fd-972a1e81e803',
                  ).image,
                ),
              ),
              child: Opacity(
                opacity: 0.6,
                child: Align(
                  alignment: const AlignmentDirectional(-1.5, -1.22),
                  child: Lottie.network(
                    'https://lottie.host/99e96481-9ff4-4849-8b8a-3b11091498ca/Efvg31RTi8.json',
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height,
                    fit: BoxFit.cover,
                    animate: true,
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Личная информация под надежной защитой',
                        style: theme.displaySmall.override(
                          fontFamily: 'JOST',
                          color: theme.secondaryBackground,
                          fontSize: 22.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Текущая почта: ${currentUserEmail.isEmpty ? 'не указана' : currentUserEmail}',
                        style: theme.bodyMedium.override(
                          fontFamily: 'JOST',
                          color: theme.secondaryBackground.withValues(
                            alpha: 0.75,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      wrapWithModel(
                        model: _model.titleWithSubtitleModel1,
                        updateCallback: () => safeSetState(() {}),
                        child: const TitleWithSubtitleWidget(
                          title: 'Изменить почту',
                          subtitle:
                              'Введите новый e-mail и подтвердите текущим паролем.',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(top: 10.0),
                        child: TextFormField(
                          controller: _model.eMailTextController,
                          focusNode: _model.eMailFocusNode,
                          enabled: !anyBusy,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Новый e-mail',
                            labelStyle: theme.labelMedium.override(
                              fontFamily: 'JOST',
                              color: theme.secondaryBackground,
                              letterSpacing: 0.0,
                            ),
                            hintText: 'name@example.com',
                            hintStyle: theme.labelMedium.override(
                              fontFamily: 'JOST',
                              color: theme.secondaryBackground.withValues(
                                alpha: 0.55,
                              ),
                              letterSpacing: 0.0,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: theme.customColor3,
                                width: 0.8,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: theme.primary,
                                width: 0.8,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: theme.error,
                                width: 0.8,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: theme.error,
                                width: 0.8,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            filled: true,
                            fillColor: theme.customColor5,
                            contentPadding:
                                const EdgeInsetsDirectional.fromSTEB(
                                    20.0, 14.0, 20.0, 14.0),
                          ),
                          style: theme.titleSmall.override(
                            fontFamily: 'JOST',
                            color: theme.secondaryBackground,
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w300,
                          ),
                          validator: (value) =>
                              _model.eMailTextControllerValidator
                                  ?.call(context, value),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(top: 20.0),
                        child: _actionButton(
                          text: 'Изменить электронный адрес',
                          loading: _busyEmail,
                          onPressed: anyBusy ? null : _changeEmail,
                        ),
                      ),
                      wrapWithModel(
                        model: _model.titleWithSubtitleModel2,
                        updateCallback: () => safeSetState(() {}),
                        child: const TitleWithSubtitleWidget(
                          title: 'Сбросить пароль',
                          subtitle:
                              'Отправим ссылку для сброса на вашу текущую почту.',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(top: 20.0),
                        child: _actionButton(
                          text: 'Отправить ссылку сброса',
                          loading: _busyReset,
                          onPressed: anyBusy ? null : _resetPassword,
                        ),
                      ),
                      wrapWithModel(
                        model: _model.titleWithSubtitleModel3,
                        updateCallback: () => safeSetState(() {}),
                        child: const TitleWithSubtitleWidget(
                          title: 'Удалить аккаунт',
                          subtitle:
                              'Профиль будет удалён безвозвратно. Потребуется пароль.',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            top: 20.0, bottom: 24.0),
                        child: _actionButton(
                          text: 'Удалить аккаунт',
                          loading: _busyDelete,
                          borderColor: theme.error,
                          onPressed: anyBusy ? null : _deleteAccount,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
