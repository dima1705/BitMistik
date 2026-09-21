import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'd_a_m_dnevnik1_istorya_vse5_model.dart';
export 'd_a_m_dnevnik1_istorya_vse5_model.dart';

class DAMDnevnik1IstoryaVse5Widget extends StatefulWidget {
  const DAMDnevnik1IstoryaVse5Widget({super.key});

  static String routeName = 'DA_M_Dnevnik_1_Istorya_vse_5';
  static String routePath = 'Dnevnik-Istorya';

  @override
  State<DAMDnevnik1IstoryaVse5Widget> createState() =>
      _DAMDnevnik1IstoryaVse5WidgetState();
}

class _DAMDnevnik1IstoryaVse5WidgetState
    extends State<DAMDnevnik1IstoryaVse5Widget> {
  late DAMDnevnik1IstoryaVse5Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DAMDnevnik1IstoryaVse5Model());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'DA_M_Dnevnik_1_Istorya_vse_5'});
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('D_A_M_DNEVNIK_1_ISTORYA_VSE_5_DA_M_Dnevn');
      logFirebaseEvent('DA_M_Dnevnik_1_Istorya_vse_5_update_page');
      _model.day = getCurrentTimestamp;
      _model.calendarSelectedDay ??= DateTimeRange(
        start: DateTime.now().startOfDay,
        end: DateTime.now().endOfDay,
      );
      safeSetState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  DateTime get _selectedDay =>
      _model.calendarSelectedDay?.start ?? _model.day ?? DateTime.now();

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  String _dayLabel(BuildContext context) {
    final day = _selectedDay;
    final now = DateTime.now();
    final formatted = dateTimeFormat(
      'EEEE, d MMMM',
      day,
      locale: FFLocalizations.of(context).languageCode,
    );
    if (_isSameDay(day, now)) {
      return 'Сегодня · $formatted';
    }
    if (_isSameDay(day, now.subtract(const Duration(days: 1)))) {
      return 'Вчера · $formatted';
    }
    return formatted;
  }

  Future<void> _openCreate() async {
    logFirebaseEvent('D_A_M_DNEVNIK_1_ISTORYA_VSE_5_add_ICN_ON');
    logFirebaseEvent('IconButton_navigate_to');
    context.pushNamed(Dnevnik3CreateZapisKnopka7Widget.routeName);
  }

  Future<void> _openEntry(DiaryRecord record) async {
    logFirebaseEvent('D_A_M_DNEVNIK_1_ISTORYA_VSE_5_Container_');
    logFirebaseEvent('Container_navigate_to');
    context.pushNamed(
      Dnevnik2OdnaZapis6Widget.routeName,
      queryParameters: {
        'diaryDoc': serializeParam(
          record,
          ParamType.Document,
        ),
      }.withoutNulls,
      extra: <String, dynamic>{
        'diaryDoc': record,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final dayRange = functions.dateRangeForDay(_selectedDay);
    final rangeStart = dayRange.first;
    final rangeEnd = dayRange.last;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: theme.primaryText,
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
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _Header(
                      onAdd: _openCreate,
                    ),
                    const SizedBox(height: 18.0),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(bottom: 100.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _CalendarPanel(
                              initialDate: getCurrentTimestamp,
                              dayLabel: _dayLabel(context),
                              onChange: (DateTimeRange? newSelectedDate) async {
                                if (_model.calendarSelectedDay ==
                                    newSelectedDate) {
                                  return;
                                }
                                _model.calendarSelectedDay = newSelectedDate;
                                logFirebaseEvent(
                                    'D_A_M_DNEVNIK_1_ISTORYA_VSE_5_Calendar_4');
                                logFirebaseEvent(
                                    'Calendar_update_page_state');
                                _model.day =
                                    _model.calendarSelectedDay?.start;
                                safeSetState(() {});
                              },
                            ),
                            const SizedBox(height: 28.0),
                            Text(
                              'Записи дня',
                              style: theme.titleMedium.override(
                                fontFamily: 'JOST',
                                color: theme.secondaryBackground,
                                fontSize: 18.0,
                                letterSpacing: 0.4,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 6.0),
                            Text(
                              'Состояния, мысли и советы за выбранную дату',
                              style: theme.bodyMedium.override(
                                fontFamily: 'JOST',
                                color: theme.secondaryBackground
                                    .withValues(alpha: 0.65),
                                fontSize: 13.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            StreamBuilder<List<DiaryRecord>>(
                              stream: queryDiaryRecord(
                                queryBuilder: (diaryRecord) => diaryRecord
                                    .where(
                                      'user',
                                      isEqualTo: currentUserReference,
                                    )
                                    .where(
                                      'created_at',
                                      isGreaterThanOrEqualTo: rangeStart,
                                    )
                                    .where(
                                      'created_at',
                                      isLessThan: rangeEnd,
                                    )
                                    .orderBy('created_at', descending: true),
                              ),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return _EmptyHint(
                                    title: 'Не удалось загрузить',
                                    subtitle:
                                        'Проверьте соединение и откройте дневник снова.',
                                  );
                                }
                                if (!snapshot.hasData) {
                                  return const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 36.0),
                                    child: Center(
                                      child: SizedBox(
                                        width: 36.0,
                                        height: 36.0,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.4,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            Color(0xFFE5E5E5),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                final records = snapshot.data!;
                                if (records.isEmpty) {
                                  return _EmptyHint(
                                    title: 'День ещё пуст',
                                    subtitle:
                                        'Запишите состояние или вытяните совет дня — нажмите +',
                                    actionLabel: 'Новая запись',
                                    onAction: _openCreate,
                                  );
                                }

                                return Column(
                                  children: [
                                    for (var i = 0; i < records.length; i++) ...[
                                      if (i > 0) const SizedBox(height: 12.0),
                                      _DiaryEntryTile(
                                        record: records[i],
                                        onTap: () => _openEntry(records[i]),
                                      ),
                                    ],
                                  ],
                                );
                              },
                            ),
                          ],
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

class _Header extends StatelessWidget {
  const _Header({required this.onAdd});

  final Future<void> Function() onAdd;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Мой дневник',
                style: theme.headlineMedium.override(
                  fontFamily: 'JOST',
                  color: theme.secondaryBackground,
                  fontSize: 28.0,
                  letterSpacing: 0.2,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                'Осознанность день за днём',
                style: theme.bodyMedium.override(
                  fontFamily: 'JOST',
                  color: theme.secondaryBackground.withValues(alpha: 0.7),
                  fontSize: 13.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
        Material(
          color: Colors.transparent,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onAdd,
            child: Ink(
              width: 48.0,
              height: 48.0,
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
                size: 26.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CalendarPanel extends StatelessWidget {
  const _CalendarPanel({
    required this.initialDate,
    required this.dayLabel,
    required this.onChange,
  });

  final DateTime initialDate;
  final String dayLabel;
  final Future Function(DateTimeRange?) onChange;

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
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 14.0, 12.0, 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                dayLabel,
                style: theme.bodyMedium.override(
                  fontFamily: 'JOST',
                  color: theme.secondaryBackground.withValues(alpha: 0.85),
                  fontSize: 13.0,
                  letterSpacing: 0.2,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            FlutterFlowCalendar(
              color: theme.primary,
              iconColor: theme.secondaryBackground,
              weekFormat: true,
              weekStartsMonday: true,
              initialDate: initialDate,
              onChange: onChange,
              titleStyle: theme.titleLarge.override(
                fontFamily: 'JOST',
                color: theme.secondaryBackground,
                letterSpacing: 0.0,
              ),
              dayOfWeekStyle: theme.bodyLarge.override(
                fontFamily: 'JOST',
                color: theme.secondaryBackground.withValues(alpha: 0.75),
                letterSpacing: 0.0,
              ),
              dateStyle: theme.bodyMedium.override(
                fontFamily: 'JOST',
                color: theme.secondaryBackground,
                letterSpacing: 0.0,
              ),
              selectedDateStyle: theme.titleSmall.override(
                fontFamily: 'JOST',
                color: theme.secondaryBackground,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w600,
              ),
              inactiveDateStyle: theme.labelMedium.override(
                fontFamily: 'JOST',
                color: theme.info.withValues(alpha: 0.45),
                letterSpacing: 0.0,
              ),
              locale: FFLocalizations.of(context).languageCode,
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyHint extends StatelessWidget {
  const _EmptyHint({
    required this.title,
    required this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String subtitle;
  final String? actionLabel;
  final Future<void> Function()? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 28.0),
      child: Column(
        children: [
          Container(
            width: 64.0,
            height: 64.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.customColor5,
              border: Border.all(
                color: theme.customColor3.withValues(alpha: 0.7),
                width: 0.8,
              ),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.auto_stories_outlined,
              color: theme.secondaryBackground.withValues(alpha: 0.85),
              size: 28.0,
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.titleMedium.override(
              fontFamily: 'JOST',
              color: theme.secondaryBackground,
              fontSize: 18.0,
              letterSpacing: 0.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: theme.bodyMedium.override(
              fontFamily: 'JOST',
              color: theme.secondaryBackground.withValues(alpha: 0.7),
              fontSize: 14.0,
              letterSpacing: 0.0,
              fontWeight: FontWeight.w300,
            ),
          ),
          if (actionLabel != null && onAction != null) ...[
            const SizedBox(height: 20.0),
            TextButton(
              onPressed: onAction,
              style: TextButton.styleFrom(
                foregroundColor: theme.secondaryBackground,
                backgroundColor: theme.customColor3.withValues(alpha: 0.55),
                padding: const EdgeInsets.symmetric(
                  horizontal: 22.0,
                  vertical: 12.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.0),
                  side: BorderSide(
                    color: theme.tertiary.withValues(alpha: 0.6),
                  ),
                ),
              ),
              child: Text(
                actionLabel!,
                style: theme.bodyMedium.override(
                  fontFamily: 'JOST',
                  color: theme.secondaryBackground,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _DiaryEntryTile extends StatelessWidget {
  const _DiaryEntryTile({
    required this.record,
    required this.onTap,
  });

  final DiaryRecord record;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final preview = record.answ1res.isNotEmpty
        ? record.answ1res
        : record.answ2res.isNotEmpty
            ? record.answ2res
            : record.answ3res.isNotEmpty
                ? record.answ3res
                : record.adviceDay.isNotEmpty
                    ? record.adviceDay
                    : 'Без текста';
    final hasCard =
        record.cardImageDay.trim().isNotEmpty || record.adviceDay.isNotEmpty;
    final timeLabel = record.createdAt != null
        ? dateTimeFormat(
            'Hm',
            record.createdAt,
            locale: FFLocalizations.of(context).languageCode,
          )
        : '';
    final title = record.title.trim().isNotEmpty
        ? record.title.trim()
        : (hasCard ? 'Совет дня' : 'Запись');

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20.0),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: theme.customColor5,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: theme.customColor3.withValues(alpha: 0.8),
              width: 0.8,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 14.0, 14.0, 14.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.titleSmall.override(
                                fontFamily: 'JOST',
                                color: theme.secondaryBackground,
                                fontSize: 15.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          if (timeLabel.isNotEmpty)
                            Text(
                              timeLabel,
                              style: theme.labelMedium.override(
                                fontFamily: 'JOST',
                                color: theme.secondaryBackground
                                    .withValues(alpha: 0.55),
                                fontSize: 12.0,
                                letterSpacing: 0.0,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        preview,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: theme.bodyMedium.override(
                          fontFamily: 'JOST',
                          color: theme.secondaryBackground
                              .withValues(alpha: 0.88),
                          fontSize: 13.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w300,
                          lineHeight: 1.35,
                        ),
                      ),
                      if (hasCard) ...[
                        const SizedBox(height: 10.0),
                        Text(
                          'есть совет дня',
                          style: theme.labelSmall.override(
                            fontFamily: 'JOST',
                            color: theme.customColor7.withValues(alpha: 0.9),
                            fontSize: 11.0,
                            letterSpacing: 0.4,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (record.cardImageDay.trim().isNotEmpty) ...[
                  const SizedBox(width: 12.0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      record.cardImageDay,
                      width: 58.0,
                      height: 86.0,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 58.0,
                        height: 86.0,
                        color: theme.customColor6,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
