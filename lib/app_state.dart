import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  List<String> _cards = [];
  List<String> get cards => _cards;
  set cards(List<String> value) {
    _cards = value;
  }

  void addToCards(String value) {
    cards.add(value);
  }

  void removeFromCards(String value) {
    cards.remove(value);
  }

  void removeAtIndexFromCards(int index) {
    cards.removeAt(index);
  }

  void updateCardsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    cards[index] = updateFn(_cards[index]);
  }

  void insertAtIndexInCards(int index, String value) {
    cards.insert(index, value);
  }

  String _questionnaire = '';
  String get questionnaire => _questionnaire;
  set questionnaire(String value) {
    _questionnaire = value;
  }

  dynamic _userQ = jsonDecode('{\"title\":\"hello\"}');
  dynamic get userQ => _userQ;
  set userQ(dynamic value) {
    _userQ = value;
  }

  List<String> _cardsId = [];
  List<String> get cardsId => _cardsId;
  set cardsId(List<String> value) {
    _cardsId = value;
  }

  void addToCardsId(String value) {
    cardsId.add(value);
  }

  void removeFromCardsId(String value) {
    cardsId.remove(value);
  }

  void removeAtIndexFromCardsId(int index) {
    cardsId.removeAt(index);
  }

  void updateCardsIdAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    cardsId[index] = updateFn(_cardsId[index]);
  }

  void insertAtIndexInCardsId(int index, String value) {
    cardsId.insert(index, value);
  }

  List<String> _cardImage = [];
  List<String> get cardImage => _cardImage;
  set cardImage(List<String> value) {
    _cardImage = value;
  }

  void addToCardImage(String value) {
    cardImage.add(value);
  }

  void removeFromCardImage(String value) {
    cardImage.remove(value);
  }

  void removeAtIndexFromCardImage(int index) {
    cardImage.removeAt(index);
  }

  void updateCardImageAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    cardImage[index] = updateFn(_cardImage[index]);
  }

  void insertAtIndexInCardImage(int index, String value) {
    cardImage.insert(index, value);
  }

  List<String> _cardTitle = [];
  List<String> get cardTitle => _cardTitle;
  set cardTitle(List<String> value) {
    _cardTitle = value;
  }

  void addToCardTitle(String value) {
    cardTitle.add(value);
  }

  void removeFromCardTitle(String value) {
    cardTitle.remove(value);
  }

  void removeAtIndexFromCardTitle(int index) {
    cardTitle.removeAt(index);
  }

  void updateCardTitleAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    cardTitle[index] = updateFn(_cardTitle[index]);
  }

  void insertAtIndexInCardTitle(int index, String value) {
    cardTitle.insert(index, value);
  }

  List<CardStruct> _cardInfo = [];
  List<CardStruct> get cardInfo => _cardInfo;
  set cardInfo(List<CardStruct> value) {
    _cardInfo = value;
  }

  void addToCardInfo(CardStruct value) {
    cardInfo.add(value);
  }

  void removeFromCardInfo(CardStruct value) {
    cardInfo.remove(value);
  }

  void removeAtIndexFromCardInfo(int index) {
    cardInfo.removeAt(index);
  }

  void updateCardInfoAtIndex(
    int index,
    CardStruct Function(CardStruct) updateFn,
  ) {
    cardInfo[index] = updateFn(_cardInfo[index]);
  }

  void insertAtIndexInCardInfo(int index, CardStruct value) {
    cardInfo.insert(index, value);
  }

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
  }
}
