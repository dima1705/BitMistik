import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PaymentsRecord extends FirestoreRecord {
  PaymentsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "transfer_amount" field.
  double? _transferAmount;
  double get transferAmount => _transferAmount ?? 0.0;
  bool hasTransferAmount() => _transferAmount != null;

  // "transfer_type" field.
  String? _transferType;
  String get transferType => _transferType ?? '';
  bool hasTransferType() => _transferType != null;

  // "balance" field.
  double? _balance;
  double get balance => _balance ?? 0.0;
  bool hasBalance() => _balance != null;

  // "converted" field.
  double? _converted;
  double get converted => _converted ?? 0.0;
  bool hasConverted() => _converted != null;

  // "rate" field.
  double? _rate;
  double get rate => _rate ?? 0.0;
  bool hasRate() => _rate != null;

  void _initializeFields() {
    _user = snapshotData['user'] as DocumentReference?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _transferAmount = castToType<double>(snapshotData['transfer_amount']);
    _transferType = snapshotData['transfer_type'] as String?;
    _balance = castToType<double>(snapshotData['balance']);
    _converted = castToType<double>(snapshotData['converted']);
    _rate = castToType<double>(snapshotData['rate']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('payments');

  static Stream<PaymentsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PaymentsRecord.fromSnapshot(s));

  static Future<PaymentsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PaymentsRecord.fromSnapshot(s));

  static PaymentsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PaymentsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PaymentsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PaymentsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PaymentsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PaymentsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPaymentsRecordData({
  DocumentReference? user,
  DateTime? createdAt,
  double? transferAmount,
  String? transferType,
  double? balance,
  double? converted,
  double? rate,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user': user,
      'created_at': createdAt,
      'transfer_amount': transferAmount,
      'transfer_type': transferType,
      'balance': balance,
      'converted': converted,
      'rate': rate,
    }.withoutNulls,
  );

  return firestoreData;
}

class PaymentsRecordDocumentEquality implements Equality<PaymentsRecord> {
  const PaymentsRecordDocumentEquality();

  @override
  bool equals(PaymentsRecord? e1, PaymentsRecord? e2) {
    return e1?.user == e2?.user &&
        e1?.createdAt == e2?.createdAt &&
        e1?.transferAmount == e2?.transferAmount &&
        e1?.transferType == e2?.transferType &&
        e1?.balance == e2?.balance &&
        e1?.converted == e2?.converted &&
        e1?.rate == e2?.rate;
  }

  @override
  int hash(PaymentsRecord? e) => const ListEquality().hash([
        e?.user,
        e?.createdAt,
        e?.transferAmount,
        e?.transferType,
        e?.balance,
        e?.converted,
        e?.rate
      ]);

  @override
  bool isValidKey(Object? o) => o is PaymentsRecord;
}
