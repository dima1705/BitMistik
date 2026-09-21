import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class HistoryCashBalanceRecord extends FirestoreRecord {
  HistoryCashBalanceRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "time" field.
  DateTime? _time;
  DateTime? get time => _time;
  bool hasTime() => _time != null;

  // "amount" field.
  double? _amount;
  double get amount => _amount ?? 0.0;
  bool hasAmount() => _amount != null;

  // "cashBalance" field.
  DocumentReference? _cashBalance;
  DocumentReference? get cashBalance => _cashBalance;
  bool hasCashBalance() => _cashBalance != null;

  // "payment_type" field.
  String? _paymentType;
  String get paymentType => _paymentType ?? '';
  bool hasPaymentType() => _paymentType != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  void _initializeFields() {
    _time = snapshotData['time'] as DateTime?;
    _amount = castToType<double>(snapshotData['amount']);
    _cashBalance = snapshotData['cashBalance'] as DocumentReference?;
    _paymentType = snapshotData['payment_type'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('historyCashBalance');

  static Stream<HistoryCashBalanceRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => HistoryCashBalanceRecord.fromSnapshot(s));

  static Future<HistoryCashBalanceRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => HistoryCashBalanceRecord.fromSnapshot(s));

  static HistoryCashBalanceRecord fromSnapshot(DocumentSnapshot snapshot) =>
      HistoryCashBalanceRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static HistoryCashBalanceRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      HistoryCashBalanceRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'HistoryCashBalanceRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is HistoryCashBalanceRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createHistoryCashBalanceRecordData({
  DateTime? time,
  double? amount,
  DocumentReference? cashBalance,
  String? paymentType,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'time': time,
      'amount': amount,
      'cashBalance': cashBalance,
      'payment_type': paymentType,
      'created_at': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class HistoryCashBalanceRecordDocumentEquality
    implements Equality<HistoryCashBalanceRecord> {
  const HistoryCashBalanceRecordDocumentEquality();

  @override
  bool equals(HistoryCashBalanceRecord? e1, HistoryCashBalanceRecord? e2) {
    return e1?.time == e2?.time &&
        e1?.amount == e2?.amount &&
        e1?.cashBalance == e2?.cashBalance &&
        e1?.paymentType == e2?.paymentType &&
        e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(HistoryCashBalanceRecord? e) => const ListEquality()
      .hash([e?.time, e?.amount, e?.cashBalance, e?.paymentType, e?.createdAt]);

  @override
  bool isValidKey(Object? o) => o is HistoryCashBalanceRecord;
}
