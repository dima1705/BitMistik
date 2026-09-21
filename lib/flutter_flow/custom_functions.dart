import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

String returnProfileGreeting(DateTime timestamp) {
  // return "morning" if it is morning, "afternoon" if afternoon and "night" if it is night
  var hour = timestamp.hour;
  if (hour >= 0 && hour < 12) {
    return "Good morning,";
  } else if (hour >= 12 && hour < 17) {
    return "Good afternoon,";
  } else {
    return "Goodnight,";
  }
}

List<DateTime> dateRangeForDay(DateTime selectedDate) {
  final start =
      DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
  final end = start.add(Duration(days: 1));
  return [start, end];
}

double? convertToBitWithValidation(
  double? moneyAmount,
  double? rate,
  double? currentBalance,
) {
  const double minAmount = 1.0; // минимальная сумма пополнения ($)

  if (moneyAmount == null || moneyAmount < minAmount) {
    throw Exception('Минимальная сумма пополнения — 1\$');
  }

  if (rate == null || rate <= 0) {
    throw Exception('Неверный курс конвертации.');
  }

  // Количество кристаллов — целое число, поэтому floor возвращает int
  final int crystals = (moneyAmount / rate).floor();

  final double safeBalance = currentBalance ?? 0;

  // Приводим crystals к double для сложения с safeBalance
  return safeBalance + crystals.toDouble();
}

bool? stringInList(
  String? cardId,
  List<String>? cardsList,
) {
  if (cardsList == null) return false;
  return cardsList.contains(cardId);
}

bool? hasAdviceToday(List<DiaryRecord>? recordsDiary) {
  if (recordsDiary == null) return false;

  final today = DateTime.now();

  for (final record in recordsDiary) {
    final created = record.createdAt;
    final cardImage = record.cardImageDay;

    if (created != null &&
        created.year == today.year &&
        created.month == today.month &&
        created.day == today.day &&
        cardImage != null &&
        cardImage.trim().isNotEmpty) {
      return true;
    }
  }
  return false;
}

List<DateTime>? checkTodayRecords() {
  final now = DateTime.now();
  final startOfToday = DateTime(now.year, now.month, now.day);
  final startOfTomorrow = startOfToday.add(Duration(days: 1));

  return [startOfToday, startOfTomorrow];
}
