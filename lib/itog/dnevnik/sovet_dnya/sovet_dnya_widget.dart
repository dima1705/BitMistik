import 'dart:math' as math;

import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_swipeable_stack.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/itog/dnevnik/card_advice/card_advice_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'sovet_dnya_model.dart';
export 'sovet_dnya_model.dart';

class SovetDnyaWidget extends StatefulWidget {
  const SovetDnyaWidget({
    super.key,
    this.ans1,
    this.ans2,
    this.ans3,
    this.randomCard,
  });

  final String? ans1;
  final String? ans2;
  final String? ans3;

  /// Legacy API payload; ignored when Firestore cards are available.
  final dynamic randomCard;

  @override
  State<SovetDnyaWidget> createState() => _SovetDnyaWidgetState();
}

class _SovetDnyaWidgetState extends State<SovetDnyaWidget> {
  late SovetDnyaModel _model;

  /// Same card back as гадание — known-good Storage URL.
  static const _cardBackUrl =
      'https://firebasestorage.googleapis.com/v0/b/bitmystic-1.firebasestorage.app/o/Cards%2Fcards%20(2).png?alt=media&token=62cef944-b4f0-4cf2-afaa-2a3d82c840d7';

  List<_AdviceCard> _cards = const [];
  bool _loadingCards = true;
  String? _cardsError;

  /// Sync lock — set before any await / setState so double picks cannot pass.
  bool _selectionLocked = false;
  bool _claimedToday = false;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SovetDnyaModel());
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _loadCards();
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  Future<void> _precacheCardBack() async {
    if (!mounted) {
      return;
    }
    try {
      await precacheImage(
        CachedNetworkImageProvider(_cardBackUrl),
        context,
      );
    } catch (_) {
      // Still show stack; CachedNetworkImage will retry.
    }
  }

  Future<void> _loadCards() async {
    try {
      final fromFirestore = await queryCardInfoRecordOnce();
      final prepared = fromFirestore
          .where(
            (c) =>
                c.title.trim().isNotEmpty && c.cardImage.trim().isNotEmpty,
          )
          .map(
            (c) => _AdviceCard(
              title: c.title.trim(),
              image: c.cardImage.trim(),
            ),
          )
          .toList();

      prepared.shuffle(math.Random());

      if (prepared.isNotEmpty) {
        await _precacheCardBack();
        if (!mounted) {
          return;
        }
        setState(() {
          _cards = prepared.take(12).toList();
          _loadingCards = false;
        });
        return;
      }

      // Fallback: legacy API payload if Firestore is empty.
      final apiCards = (getJsonField(
            widget.randomCard,
            r'$.cards',
            true,
          ) as List?) ??
          const [];
      final mapped = <_AdviceCard>[];
      for (final raw in apiCards) {
        final title = '${getJsonField(raw, r'$.title') ?? ''}';
        final image = '${getJsonField(raw, r'$.cardImage') ?? ''}';
        if (title.isEmpty || image.isEmpty) {
          continue;
        }
        mapped.add(_AdviceCard(title: title, image: image));
      }
      mapped.shuffle(math.Random());

      if (mapped.isNotEmpty) {
        await _precacheCardBack();
      }

      if (!mounted) {
        return;
      }
      setState(() {
        _cards = mapped;
        _loadingCards = false;
        if (mapped.isEmpty) {
          _cardsError = 'Не удалось загрузить карты.';
        }
      });
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _loadingCards = false;
        _cardsError = 'Ошибка загрузки карт.';
      });
    }
  }

  Future<DiaryRecord?> _findAdviceToday() async {
    final userRef = currentUserReference;
    if (userRef == null) {
      return null;
    }
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final end = start.add(const Duration(days: 1));
    final todayDocs = await queryDiaryRecordOnce(
      queryBuilder: (q) => q
          .where('user', isEqualTo: userRef)
          .where('created_at', isGreaterThanOrEqualTo: start)
          .where('created_at', isLessThan: end),
    );
    for (final doc in todayDocs) {
      if (doc.cardImageDay.trim().isNotEmpty) {
        return doc;
      }
    }
    return null;
  }

  Future<({String advice, DiaryRecord diary})> _resolveAdvice(
    _AdviceCard card,
  ) async {
    final existing = await _findAdviceToday();
    if (existing != null) {
      _model.diary = existing;
      return (
        advice: existing.adviceDay.trim().isNotEmpty
            ? existing.adviceDay
            : 'Совет уже получен сегодня.',
        diary: existing,
      );
    }

    final diaryRecordReference = DiaryRecord.collection.doc();
    final baseData = createDiaryRecordData(
      note: widget.ans2,
      user: currentUserReference,
      answ1res: widget.ans1,
      answ2res: widget.ans2,
      answ3res: widget.ans3,
      cardImageDay: card.image,
      title: card.title,
      adviceDay: '',
    );
    await diaryRecordReference.set({
      ...baseData,
      ...mapToFirestore({
        'created_at': FieldValue.serverTimestamp(),
      }),
    });
    _claimedToday = true;

    String advice = 'Совет временно недоступен. Попробуйте позже.';
    try {
      final aiResp = await OpenAPIAIGroup.getTarrotAdviceCall.call(
        card: card.title,
      );
      advice = OpenAPIAIGroup.getTarrotAdviceCall.massageAdvice(
            aiResp.jsonBody ?? '',
          ) ??
          advice;
    } catch (_) {
      // Keep fallback; today's slot is already claimed.
    }

    await diaryRecordReference.update(
      createDiaryRecordData(adviceDay: advice),
    );

    final diary = DiaryRecord.getDocumentFromData({
      ...baseData,
      ...createDiaryRecordData(adviceDay: advice),
      ...mapToFirestore({
        'created_at': DateTime.now(),
      }),
    }, diaryRecordReference);

    _model.diary = diary;
    return (advice: advice, diary: diary);
  }

  void _selectByIndex(int index) {
    if (_selectionLocked || _claimedToday) {
      return;
    }
    if (index < 0 || index >= _cards.length) {
      return;
    }
    _onCardSelected(_cards[index]);
  }

  Future<void> _onCardSelected(_AdviceCard card) async {
    if (_selectionLocked || _claimedToday) {
      return;
    }
    _selectionLocked = true;

    logFirebaseEvent('SOVET_DNYA_COMP_Image_id2fwxp7_ON_TAP');

    if (mounted) {
      setState(() {
        _cards = const [];
      });
    }

    final future = _resolveAdvice(card);

    if (!mounted) {
      return;
    }

    final dialogResult = await showDialog<AdviceDialogResult>(
      barrierDismissible: false,
      useRootNavigator: true,
      context: context,
      builder: (dialogContext) {
        return Dialog(
          elevation: 0,
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          alignment: const AlignmentDirectional(0.0, 0.0)
              .resolve(Directionality.of(context)),
          child: CardAdviceWidget(
            title: card.title,
            image: card.image,
            loadFuture: future,
          ),
        );
      },
    );

    // Dialog closed — always dismiss this bottom sheet so loader cannot stick.
    if (!mounted) {
      return;
    }
    final result = dialogResult ??
        AdviceDialogResult(
          diary: _model.diary,
          openDiary: false,
        );
    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return PopScope(
      canPop: !_selectionLocked,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: theme.customColor5,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
          border: Border.all(
            color: theme.customColor3,
            width: 0.8,
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(24.0, 12.0, 24.0, 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60.0,
                height: 2.0,
                decoration: BoxDecoration(
                  color: theme.secondaryBackground,
                ),
              ),
              if (!_selectionLocked)
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).maybePop(false),
                    icon: Icon(
                      Icons.close_rounded,
                      color: theme.secondaryBackground,
                    ),
                  ),
                ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 10.0),
                child: Text(
                  _selectionLocked
                      ? '✨ Карта выбрана ✨'
                      : '✨ Выберите Карту ✨',
                  textAlign: TextAlign.center,
                  style: theme.titleMedium.override(
                    fontFamily: 'JOST',
                    color: const Color(0xFFE5E5E5),
                    fontSize: 22.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(
                height: 360.0,
                child: _buildStack(theme),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStack(FlutterFlowTheme theme) {
    if (_selectionLocked) {
      return const Center(
        child: Text(
          'Открываем карту…',
          style: TextStyle(
            fontFamily: 'JOST',
            color: Color(0xFFE5E5E5),
            fontSize: 16.0,
          ),
        ),
      );
    }

    if (_loadingCards) {
      return Center(
        child: SizedBox(
          width: 36.0,
          height: 36.0,
          child: CircularProgressIndicator(
            strokeWidth: 2.4,
            valueColor: AlwaysStoppedAnimation<Color>(
              theme.secondaryBackground,
            ),
          ),
        ),
      );
    }

    if (_cardsError != null || _cards.isEmpty) {
      return Center(
        child: Text(
          _cardsError ?? 'Карты не найдены',
          textAlign: TextAlign.center,
          style: theme.bodyMedium.override(
            fontFamily: 'JOST',
            color: theme.secondaryBackground,
            letterSpacing: 0.0,
          ),
        ),
      );
    }

    return FlutterFlowSwipeableStack(
      // Any swipe direction selects that card (same as tap).
      onSwipeFn: _selectByIndex,
      onLeftSwipe: (_) {},
      onRightSwipe: (_) {},
      onUpSwipe: (_) {},
      onDownSwipe: (_) {},
      itemBuilder: (context, index) {
        final card = _cards[index];
        return Align(
          alignment: Alignment.center,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _onCardSelected(card),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: _cardBackUrl,
                width: 260.0,
                height: double.infinity,
                fit: BoxFit.cover,
                fadeInDuration: Duration.zero,
                fadeOutDuration: Duration.zero,
                placeholder: (_, __) => const ColoredBox(
                  color: Color(0xFF1A1630),
                ),
                errorWidget: (_, __, ___) => Image.network(
                  _cardBackUrl,
                  width: 260.0,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
      itemCount: _cards.length,
      controller: _model.swipeableStackController,
      loop: false,
      cardDisplayCount: _cards.length.clamp(1, 5),
      scale: 0.92,
      cardPadding: EdgeInsets.zero,
      backCardOffset: const Offset(0.0, 18.0),
    );
  }
}

class _AdviceCard {
  const _AdviceCard({
    required this.title,
    required this.image,
  });

  final String title;
  final String image;
}
