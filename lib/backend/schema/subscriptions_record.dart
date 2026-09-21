import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SubscriptionsRecord extends FirestoreRecord {
  SubscriptionsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "start_date" field.
  DateTime? _startDate;
  DateTime? get startDate => _startDate;
  bool hasStartDate() => _startDate != null;

  // "is_active" field.
  bool? _isActive;
  bool get isActive => _isActive ?? false;
  bool hasIsActive() => _isActive != null;

  // "tariff_id" field.
  DocumentReference? _tariffId;
  DocumentReference? get tariffId => _tariffId;
  bool hasTariffId() => _tariffId != null;

  // "user_id" field.
  DocumentReference? _userId;
  DocumentReference? get userId => _userId;
  bool hasUserId() => _userId != null;

  // "answerAiLeft" field.
  int? _answerAiLeft;
  int get answerAiLeft => _answerAiLeft ?? 0;
  bool hasAnswerAiLeft() => _answerAiLeft != null;

  void _initializeFields() {
    _startDate = snapshotData['start_date'] as DateTime?;
    _isActive = snapshotData['is_active'] as bool?;
    _tariffId = snapshotData['tariff_id'] as DocumentReference?;
    _userId = snapshotData['user_id'] as DocumentReference?;
    _answerAiLeft = castToType<int>(snapshotData['answerAiLeft']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('subscriptions');

  static Stream<SubscriptionsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SubscriptionsRecord.fromSnapshot(s));

  static Future<SubscriptionsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SubscriptionsRecord.fromSnapshot(s));

  static SubscriptionsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SubscriptionsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SubscriptionsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SubscriptionsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SubscriptionsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SubscriptionsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSubscriptionsRecordData({
  DateTime? startDate,
  bool? isActive,
  DocumentReference? tariffId,
  DocumentReference? userId,
  int? answerAiLeft,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'start_date': startDate,
      'is_active': isActive,
      'tariff_id': tariffId,
      'user_id': userId,
      'answerAiLeft': answerAiLeft,
    }.withoutNulls,
  );

  return firestoreData;
}

class SubscriptionsRecordDocumentEquality
    implements Equality<SubscriptionsRecord> {
  const SubscriptionsRecordDocumentEquality();

  @override
  bool equals(SubscriptionsRecord? e1, SubscriptionsRecord? e2) {
    return e1?.startDate == e2?.startDate &&
        e1?.isActive == e2?.isActive &&
        e1?.tariffId == e2?.tariffId &&
        e1?.userId == e2?.userId &&
        e1?.answerAiLeft == e2?.answerAiLeft;
  }

  @override
  int hash(SubscriptionsRecord? e) => const ListEquality().hash(
      [e?.startDate, e?.isActive, e?.tariffId, e?.userId, e?.answerAiLeft]);

  @override
  bool isValidKey(Object? o) => o is SubscriptionsRecord;
}
