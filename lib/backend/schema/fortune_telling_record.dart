import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FortuneTellingRecord extends FirestoreRecord {
  FortuneTellingRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "responseFromGPT" field.
  String? _responseFromGPT;
  String get responseFromGPT => _responseFromGPT ?? '';
  bool hasResponseFromGPT() => _responseFromGPT != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "answer" field.
  String? _answer;
  String get answer => _answer ?? '';
  bool hasAnswer() => _answer != null;

  // "user_id" field.
  DocumentReference? _userId;
  DocumentReference? get userId => _userId;
  bool hasUserId() => _userId != null;

  // "cards" field.
  List<CardStruct>? _cards;
  List<CardStruct> get cards => _cards ?? const [];
  bool hasCards() => _cards != null;

  // "spreadType" field.
  String? _spreadType;
  String get spreadType => _spreadType ?? '';
  bool hasSpreadType() => _spreadType != null;

  void _initializeFields() {
    _responseFromGPT = snapshotData['responseFromGPT'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _answer = snapshotData['answer'] as String?;
    _userId = snapshotData['user_id'] as DocumentReference?;
    _cards = getStructList(
      snapshotData['cards'],
      CardStruct.fromMap,
    );
    _spreadType = snapshotData['spreadType'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('fortuneTelling');

  static Stream<FortuneTellingRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => FortuneTellingRecord.fromSnapshot(s));

  static Future<FortuneTellingRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => FortuneTellingRecord.fromSnapshot(s));

  static FortuneTellingRecord fromSnapshot(DocumentSnapshot snapshot) =>
      FortuneTellingRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static FortuneTellingRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      FortuneTellingRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'FortuneTellingRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is FortuneTellingRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createFortuneTellingRecordData({
  String? responseFromGPT,
  DateTime? createdAt,
  String? answer,
  DocumentReference? userId,
  String? spreadType,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'responseFromGPT': responseFromGPT,
      'created_at': createdAt,
      'answer': answer,
      'user_id': userId,
      'spreadType': spreadType,
    }.withoutNulls,
  );

  return firestoreData;
}

class FortuneTellingRecordDocumentEquality
    implements Equality<FortuneTellingRecord> {
  const FortuneTellingRecordDocumentEquality();

  @override
  bool equals(FortuneTellingRecord? e1, FortuneTellingRecord? e2) {
    const listEquality = ListEquality();
    return e1?.responseFromGPT == e2?.responseFromGPT &&
        e1?.createdAt == e2?.createdAt &&
        e1?.answer == e2?.answer &&
        e1?.userId == e2?.userId &&
        listEquality.equals(e1?.cards, e2?.cards) &&
        e1?.spreadType == e2?.spreadType;
  }

  @override
  int hash(FortuneTellingRecord? e) => const ListEquality().hash([
        e?.responseFromGPT,
        e?.createdAt,
        e?.answer,
        e?.userId,
        e?.cards,
        e?.spreadType
      ]);

  @override
  bool isValidKey(Object? o) => o is FortuneTellingRecord;
}
