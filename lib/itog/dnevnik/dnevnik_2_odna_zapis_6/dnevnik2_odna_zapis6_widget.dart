import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'dnevnik2_odna_zapis6_model.dart';
export 'dnevnik2_odna_zapis6_model.dart';

class Dnevnik2OdnaZapis6Widget extends StatefulWidget {
  const Dnevnik2OdnaZapis6Widget({
    super.key,
    required this.diaryDoc,
  });

  final DiaryRecord? diaryDoc;

  static String routeName = 'Dnevnik_2_Odna_zapis_6';
  static String routePath = 'dnevnik2OdnaZapis6';

  @override
  State<Dnevnik2OdnaZapis6Widget> createState() =>
      _Dnevnik2OdnaZapis6WidgetState();
}

class _Dnevnik2OdnaZapis6WidgetState extends State<Dnevnik2OdnaZapis6Widget> {
  late Dnevnik2OdnaZapis6Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Dnevnik2OdnaZapis6Model());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'Dnevnik_2_Odna_zapis_6'});
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  DiaryRecord? get _doc => widget.diaryDoc;

  String get _dateLabel {
    final created = _doc?.createdAt;
    if (created == null) {
      return '';
    }
    return dateTimeFormat(
      'EEEE, d MMMM · Hm',
      created,
      locale: FFLocalizations.of(context).languageCode,
    );
  }

  bool get _hasAnswers {
    final d = _doc;
    if (d == null) {
      return false;
    }
    return d.answ1res.trim().isNotEmpty ||
        d.answ2res.trim().isNotEmpty ||
        d.answ3res.trim().isNotEmpty;
  }

  bool get _hasAdvice {
    final d = _doc;
    if (d == null) {
      return false;
    }
    return d.adviceDay.trim().isNotEmpty || d.cardImageDay.trim().isNotEmpty;
  }

  Future<void> _openCreate() async {
    logFirebaseEvent('DNEVNIK_2_ODNA_ZAPIS_6_add_ICN_ON_TAP');
    logFirebaseEvent('IconButton_navigate_to');
    context.pushNamed(Dnevnik3CreateZapisKnopka7Widget.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

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
          leading: IconButton(
            onPressed: () async {
              logFirebaseEvent('DNEVNIK_2_ODNA_ZAPIS_6_angleLeft_ICN_ON_');
              logFirebaseEvent('IconButton_navigate_to');
              context.goNamed(DAMDnevnik1IstoryaVse5Widget.routeName);
            },
            icon: FaIcon(
              FontAwesomeIcons.angleLeft,
              color: theme.secondaryBackground,
              size: 22.0,
            ),
          ),
          title: Text(
            'Запись',
            style: theme.titleSmall.override(
              fontFamily: 'JOST',
              color: theme.info,
              fontSize: 20.0,
              letterSpacing: 0.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Center(
                child: Material(
                  color: Colors.transparent,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: _openCreate,
                    child: Ink(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [theme.customColor2, theme.customColor3],
                          begin: const AlignmentDirectional(-1.0, -1.0),
                          end: const AlignmentDirectional(1.0, 1.0),
                        ),
                        border: Border.all(
                          color: theme.tertiary.withValues(alpha: 0.7),
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        Icons.add_rounded,
                        color: theme.secondaryBackground,
                        size: 22.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
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
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (_dateLabel.isNotEmpty)
                      Text(
                        _dateLabel,
                        style: theme.bodyMedium.override(
                          fontFamily: 'JOST',
                          color: theme.secondaryBackground
                              .withValues(alpha: 0.7),
                          fontSize: 13.0,
                          letterSpacing: 0.2,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    if (_dateLabel.isNotEmpty) const SizedBox(height: 14.0),
                    if (_hasAnswers) ...[
                      _AnswersCard(
                        answ1: _doc?.answ1res.trim() ?? '',
                        answ2: _doc?.answ2res.trim() ?? '',
                        answ3: _doc?.answ3res.trim() ?? '',
                      ),
                      const SizedBox(height: 16.0),
                    ],
                    if (_hasAdvice) ...[
                      _AdviceCard(
                        title: _doc?.title.trim() ?? '',
                        advice: _doc?.adviceDay.trim() ?? '',
                        cardImage: _doc?.cardImageDay.trim() ?? '',
                      ),
                      const SizedBox(height: 16.0),
                    ],
                    if (!_hasAnswers && !_hasAdvice)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 48.0),
                        child: Text(
                          'В этой записи пока нет текста',
                          textAlign: TextAlign.center,
                          style: theme.bodyMedium.override(
                            fontFamily: 'JOST',
                            color: theme.secondaryBackground
                                .withValues(alpha: 0.75),
                            letterSpacing: 0.0,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnswersCard extends StatelessWidget {
  const _AnswersCard({
    required this.answ1,
    required this.answ2,
    required this.answ3,
  });

  final String answ1;
  final String answ2;
  final String answ3;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final blocks = <({String label, String text})>[
      if (answ1.isNotEmpty) (label: 'В теле', text: answ1),
      if (answ2.isNotEmpty) (label: 'Мысли', text: answ2),
      if (answ3.isNotEmpty) (label: 'Чувства', text: answ3),
    ];

    return Container(
      decoration: BoxDecoration(
        color: theme.customColor5,
        borderRadius: BorderRadius.circular(22.0),
        border: Border.all(
          color: theme.customColor3.withValues(alpha: 0.85),
          width: 0.8,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'В этот день',
            style: theme.titleMedium.override(
              fontFamily: 'JOST',
              color: theme.secondaryBackground,
              fontSize: 18.0,
              letterSpacing: 0.2,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 14.0),
          for (var i = 0; i < blocks.length; i++) ...[
            if (i > 0) ...[
              const SizedBox(height: 14.0),
              Divider(
                height: 1.0,
                thickness: 1.0,
                color: theme.secondaryBackground.withValues(alpha: 0.12),
              ),
              const SizedBox(height: 14.0),
            ],
            Text(
              blocks[i].label,
              style: theme.titleSmall.override(
                fontFamily: 'JOST',
                color: const Color(0xFFD4A8F7),
                fontSize: 13.0,
                letterSpacing: 0.4,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              blocks[i].text,
              style: theme.bodyMedium.override(
                fontFamily: 'JOST',
                color: theme.secondaryBackground.withValues(alpha: 0.92),
                fontSize: 14.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w300,
                lineHeight: 1.45,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _AdviceCard extends StatelessWidget {
  const _AdviceCard({
    required this.title,
    required this.advice,
    required this.cardImage,
  });

  final String title;
  final String advice;
  final String cardImage;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.customColor5,
        borderRadius: BorderRadius.circular(22.0),
        border: Border.all(
          color: theme.customColor3.withValues(alpha: 0.85),
          width: 0.8,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16.0, 18.0, 16.0, 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Совет дня',
            textAlign: TextAlign.center,
            style: theme.titleMedium.override(
              fontFamily: 'JOST',
              color: theme.secondaryBackground,
              fontSize: 18.0,
              letterSpacing: 0.3,
              fontWeight: FontWeight.w400,
            ),
          ),
          if (title.isNotEmpty) ...[
            const SizedBox(height: 6.0),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.bodyMedium.override(
                fontFamily: 'JOST',
                color: const Color(0xFFD4A8F7),
                fontSize: 14.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
          const SizedBox(height: 16.0),
          if (cardImage.isNotEmpty)
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14.0),
                child: Image.network(
                  cardImage,
                  width: 150.0,
                  height: 230.0,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 150.0,
                    height: 230.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.0),
                      gradient: LinearGradient(
                        colors: [theme.customColor2, theme.customColor6],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (advice.isNotEmpty) ...[
            const SizedBox(height: 16.0),
            Text(
              advice,
              textAlign: TextAlign.center,
              style: theme.bodyMedium.override(
                fontFamily: 'JOST',
                color: theme.secondaryBackground.withValues(alpha: 0.92),
                fontSize: 14.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w300,
                lineHeight: 1.45,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
