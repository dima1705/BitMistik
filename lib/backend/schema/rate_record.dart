import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RateRecord extends FirestoreRecord {
  RateRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "exchangeRate" field.
  double? _exchangeRate;
  double get exchangeRate => _exchangeRate ?? 0.0;
  bool hasExchangeRate() => _exchangeRate != null;

  void _initializeFields() {
    _exchangeRate = castToType<double>(snapshotData['exchangeRate']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('rate');

  static Stream<RateRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RateRecord.fromSnapshot(s));

  static Future<RateRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => RateRecord.fromSnapshot(s));

  static RateRecord fromSnapshot(DocumentSnapshot snapshot) => RateRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RateRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RateRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RateRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RateRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRateRecordData({
  double? exchangeRate,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'exchangeRate': exchangeRate,
    }.withoutNulls,
  );

  return firestoreData;
}

class RateRecordDocumentEquality implements Equality<RateRecord> {
  const RateRecordDocumentEquality();

  @override
  bool equals(RateRecord? e1, RateRecord? e2) {
    return e1?.exchangeRate == e2?.exchangeRate;
  }

  @override
  int hash(RateRecord? e) => const ListEquality().hash([e?.exchangeRate]);

  @override
  bool isValidKey(Object? o) => o is RateRecord;
}
