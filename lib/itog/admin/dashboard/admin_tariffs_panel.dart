import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/itog/admin/custom_add_tariff/custom_add_tariff_widget.dart';
import '/itog/admin/delete_tarif_window/delete_tarif_window_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// Экономика: старт 7 bit, гадание = 3 bit.
/// Тарифы — пакеты bit за USD (минимум пополнения $1).
const defaultTariffs = [
  {
    'id': 'starter',
    'tariffType': 'Старт',
    'description':
        'После бесплатных 7 bit — ещё 4 гадания. Удобный вход за минимальную сумму.',
    'price': 1,
    'bits': 12, // 4 гадания × 3 bit
  },
  {
    'id': 'standard',
    'tariffType': 'Стандарт',
    'description':
        '15 гаданий со скидкой ~25% к цене за bit. Оптимальный ежедневный пакет.',
    'price': 3,
    'bits': 45, // 15 гаданий
  },
  {
    'id': 'premium',
    'tariffType': 'Премиум',
    'description':
        '40 гаданий и лучшая цена за bit. Для регулярной практики с Таро.',
    'price': 7,
    'bits': 120, // 40 гаданий
  },
];

/// Создаёт или обновляет 3 базовых тарифа (цена / bit).
Future<void> ensureDefaultTariffs() async {
  for (final tariff in defaultTariffs) {
    final ref = TariffRecord.collection.doc(tariff['id'] as String);
    await ref.set(
      createTariffRecordData(
        tariffType: tariff['tariffType'] as String,
        description: tariff['description'] as String,
        price: tariff['price'] as int,
        countAiResponce: tariff['bits'] as int,
        isActive: true,
      ),
      SetOptions(merge: true),
    );
  }
}

int readingsFromBits(int bits) => bits <= 0 ? 0 : bits ~/ 3;

class AdminTariffsPanel extends StatefulWidget {
  const AdminTariffsPanel({super.key});

  @override
  State<AdminTariffsPanel> createState() => _AdminTariffsPanelState();
}

class _AdminTariffsPanelState extends State<AdminTariffsPanel> {
  @override
  void initState() {
    super.initState();
    ensureDefaultTariffs();
  }

  Future<void> _openEditor({TariffRecord? tariff}) async {
    await showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.55),
      builder: (dialogContext) {
        return Dialog(
          elevation: 0,
          insetPadding: const EdgeInsets.symmetric(horizontal: 18.0),
          backgroundColor: Colors.transparent,
          child: CustomAddTariffWidget(tarif: tariff),
        );
      },
    );
  }

  Future<void> _openDelete(TariffRecord tariff) async {
    await showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          elevation: 0,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          backgroundColor: Colors.transparent,
          child: DeleteTarifWindowWidget(tarif: tariff),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 16.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0x940C0627),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: theme.customColor3.withValues(alpha: 0.35)),
        ),
        child: StreamBuilder<List<TariffRecord>>(
          stream: queryTariffRecord(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(theme.primary),
                ),
              );
            }

            final tariffs = List<TariffRecord>.from(snapshot.data!)
              ..sort((a, b) {
                final priceCmp = a.price.compareTo(b.price);
                if (priceCmp != 0) {
                  return priceCmp;
                }
                return a.tariffType.compareTo(b.tariffType);
              });

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 14.0, 4.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Тарифы',
                              style: theme.titleMedium.override(
                                fontFamily: 'JOST',
                                color: theme.secondaryBackground,
                                fontSize: 22.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              '3 bit / гадание · от \$1 · ${tariffs.length}',
                              style: theme.bodySmall.override(
                                fontFamily: 'JOST',
                                color: theme.secondaryBackground
                                    .withValues(alpha: 0.7),
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => _openEditor(),
                          borderRadius: BorderRadius.circular(24.0),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFBA3AE7), Color(0xFF6822B9)],
                                begin: AlignmentDirectional(-1.0, 1.0),
                                end: AlignmentDirectional(1.0, -1.0),
                              ),
                              borderRadius: BorderRadius.circular(24.0),
                              border: Border.all(
                                color: const Color(0xB5ACA7E1),
                                width: 1.2,
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 14.0,
                                vertical: 10.0,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.add_rounded,
                                    color: Colors.white,
                                    size: 22.0,
                                  ),
                                  SizedBox(width: 4.0),
                                  Text(
                                    'Добавить',
                                    style: TextStyle(
                                      fontFamily: 'JOST',
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: tariffs.isEmpty
                      ? Center(
                          child: Text(
                            'Тарифов пока нет',
                            style: theme.bodyMedium.override(
                              fontFamily: 'JOST',
                              color: theme.secondaryBackground,
                              letterSpacing: 0.0,
                            ),
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                          itemCount: tariffs.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12.0),
                          itemBuilder: (context, index) {
                            final tariff = tariffs[index];
                            return _AdminTariffCard(
                              tariff: tariff,
                              rank: index + 1,
                              isLargest: index == tariffs.length - 1 &&
                                  tariffs.length > 1,
                              onEdit: () => _openEditor(tariff: tariff),
                              onDelete: () => _openDelete(tariff),
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _AdminTariffCard extends StatelessWidget {
  const _AdminTariffCard({
    required this.tariff,
    required this.rank,
    required this.isLargest,
    required this.onEdit,
    required this.onDelete,
  });

  final TariffRecord tariff;
  final int rank;
  final bool isLargest;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final title = tariff.tariffType.trim().isEmpty
        ? 'Тариф $rank'
        : tariff.tariffType.trim();
    final description = tariff.description.trim();
    final bits = tariff.countAiResponce;
    final readings = readingsFromBits(bits);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isLargest
              ? [theme.customColor3, theme.customColor6]
              : [
                  theme.customColor5,
                  theme.customColor4.withValues(alpha: 0.94),
                ],
          begin: const AlignmentDirectional(-1.0, 1.0),
          end: const AlignmentDirectional(1.0, -1.0),
        ),
        borderRadius: BorderRadius.circular(22.0),
        border: Border.all(
          color: isLargest
              ? const Color(0xFFFFE183).withValues(alpha: 0.7)
              : theme.customColor3.withValues(alpha: 0.55),
          width: isLargest ? 1.3 : 0.8,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18.0, 16.0, 14.0, 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 28.0,
                  height: 28.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    '$rank',
                    style: theme.bodyMedium.override(
                      fontFamily: 'JOST',
                      color: const Color(0xFFFFE183),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.0,
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    title,
                    style: theme.titleMedium.override(
                      fontFamily: 'JOST',
                      color: theme.secondaryBackground,
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  '${tariff.price}\$',
                  style: theme.headlineSmall.override(
                    fontFamily: 'JOST',
                    color: const Color(0xFFFFE183),
                    fontSize: 24.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            if (description.isNotEmpty) ...[
              const SizedBox(height: 8.0),
              Text(
                description,
                style: theme.bodyMedium.override(
                  fontFamily: 'JOST',
                  color: theme.secondaryBackground.withValues(alpha: 0.78),
                  fontSize: 13.5,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
            const SizedBox(height: 14.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                _Chip(text: '$bits bit'),
                _Chip(
                  text: readings == 1 ? '~1 гадание' : '~$readings гаданий',
                ),
                _Chip(
                  text: tariff.isActive ? 'активен' : 'скрыт',
                  muted: !tariff.isActive,
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              children: [
                const Spacer(),
                _RoundAction(
                  icon: Icons.edit_outlined,
                  onTap: onEdit,
                ),
                const SizedBox(width: 6.0),
                _RoundAction(
                  icon: tariff.isActive
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  onTap: () async {
                    await tariff.reference.update(
                      createTariffRecordData(isActive: !tariff.isActive),
                    );
                  },
                ),
                const SizedBox(width: 6.0),
                _RoundAction(
                  icon: Icons.delete_outline_rounded,
                  danger: true,
                  onTap: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.text, this.muted = false});

  final String text;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        text,
        style: theme.bodySmall.override(
          fontFamily: 'JOST',
          color:
              theme.secondaryBackground.withValues(alpha: muted ? 0.55 : 0.9),
          fontSize: 12.0,
          letterSpacing: 0.0,
        ),
      ),
    );
  }
}

class _RoundAction extends StatelessWidget {
  const _RoundAction({
    required this.icon,
    required this.onTap,
    this.danger = false,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        width: 34.0,
        height: 34.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Icon(
          icon,
          size: 15.0,
          color: danger ? theme.error : theme.secondaryBackground,
        ),
      ),
    );
  }
}
