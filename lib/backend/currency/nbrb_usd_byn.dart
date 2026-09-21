import 'dart:convert';

import 'package:http/http.dart' as http;

/// Курс USD → BYN по официальному API Национального банка РБ.
class NbrbUsdBynRate {
  NbrbUsdBynRate._();

  static const _endpoint =
      'https://www.nbrb.by/api/exrates/rates/USD?parammode=2';

  static double? _cachedRate;
  static DateTime? _cachedAt;

  /// Официальный курс: сколько BYN за 1 USD.
  static Future<double> fetchUsdToByn({
    Duration cacheFor = const Duration(minutes: 30),
  }) async {
    final now = DateTime.now();
    if (_cachedRate != null &&
        _cachedAt != null &&
        now.difference(_cachedAt!) < cacheFor) {
      return _cachedRate!;
    }

    final response = await http
        .get(Uri.parse(_endpoint))
        .timeout(const Duration(seconds: 12));
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        'Не удалось получить курс Нацбанка (HTTP ${response.statusCode}).',
      );
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! Map) {
      throw Exception('Некорректный ответ курса Нацбанка.');
    }

    final official = decoded['Cur_OfficialRate'];
    final scaleRaw = decoded['Cur_Scale'];
    final officialRate = official is num
        ? official.toDouble()
        : double.tryParse(official?.toString() ?? '');
    final scale = scaleRaw is num
        ? scaleRaw.toDouble()
        : double.tryParse(scaleRaw?.toString() ?? '') ?? 1.0;

    if (officialRate == null || officialRate <= 0 || scale <= 0) {
      throw Exception('Курс USD/BYN Нацбанка недоступен.');
    }

    final bynPerUsd = officialRate / scale;
    _cachedRate = bynPerUsd;
    _cachedAt = now;
    return bynPerUsd;
  }

  /// Округление суммы оплаты в BYN до копеек.
  static double usdToByn(double usd, double bynPerUsd) {
    final byn = usd * bynPerUsd;
    return (byn * 100).round() / 100.0;
  }
}
