import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CashBalanceRecord extends FirestoreRecord {
  CashBalanceRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  // "amount" field.
  double? _amount;
  double get amount => _amount ?? 0.0;
  bool hasAmount() => _amount != null;

  void _initializeFields() {
    _user = snapshotData['user'] as DocumentReference?;
    _amount = castToType<double>(snapshotData['amount']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('cashBalance');

  static Stream<CashBalanceRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CashBalanceRecord.fromSnapshot(s));

  static Future<CashBalanceRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CashBalanceRecord.fromSnapshot(s));

  static CashBalanceRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CashBalanceRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CashBalanceRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CashBalanceRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CashBalanceRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CashBalanceRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCashBalanceRecordData({
  DocumentReference? user,
  double? amount,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user': user,
      'amount': amount,
    }.withoutNulls,
  );

  return firestoreData;
}

class CashBalanceRecordDocumentEquality implements Equality<CashBalanceRecord> {
  const CashBalanceRecordDocumentEquality();

  @override
  bool equals(CashBalanceRecord? e1, CashBalanceRecord? e2) {
    return e1?.user == e2?.user && e1?.amount == e2?.amount;
  }

  @override
  int hash(CashBalanceRecord? e) =>
      const ListEquality().hash([e?.user, e?.amount]);

  @override
  bool isValidKey(Object? o) => o is CashBalanceRecord;
}
