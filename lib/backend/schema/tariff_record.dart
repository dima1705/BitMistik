import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TariffRecord extends FirestoreRecord {
  TariffRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "tariffType" field.
  String? _tariffType;
  String get tariffType => _tariffType ?? '';
  bool hasTariffType() => _tariffType != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "price" field.
  int? _price;
  int get price => _price ?? 0;
  bool hasPrice() => _price != null;

  // "countAiResponce" field.
  int? _countAiResponce;
  int get countAiResponce => _countAiResponce ?? 0;
  bool hasCountAiResponce() => _countAiResponce != null;

  // "is_active" field.
  bool? _isActive;
  bool get isActive => _isActive ?? false;
  bool hasIsActive() => _isActive != null;

  void _initializeFields() {
    _tariffType = snapshotData['tariffType'] as String?;
    _description = snapshotData['description'] as String?;
    _price = _asInt(snapshotData['price']);
    _countAiResponce = _asInt(snapshotData['countAiResponce']);
    _isActive = snapshotData['is_active'] as bool?;
  }

  static int? _asInt(dynamic value) {
    if (value == null) {
      return null;
    }
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.round();
    }
    if (value is String) {
      return int.tryParse(value) ?? double.tryParse(value)?.round();
    }
    return castToType<int>(value);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('tariff');

  static Stream<TariffRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TariffRecord.fromSnapshot(s));

  static Future<TariffRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TariffRecord.fromSnapshot(s));

  static TariffRecord fromSnapshot(DocumentSnapshot snapshot) => TariffRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TariffRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TariffRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TariffRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TariffRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTariffRecordData({
  String? tariffType,
  String? description,
  int? price,
  int? countAiResponce,
  bool? isActive,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'tariffType': tariffType,
      'description': description,
      'price': price,
      'countAiResponce': countAiResponce,
      'is_active': isActive,
    }.withoutNulls,
  );

  return firestoreData;
}

class TariffRecordDocumentEquality implements Equality<TariffRecord> {
  const TariffRecordDocumentEquality();

  @override
  bool equals(TariffRecord? e1, TariffRecord? e2) {
    return e1?.tariffType == e2?.tariffType &&
        e1?.description == e2?.description &&
        e1?.price == e2?.price &&
        e1?.countAiResponce == e2?.countAiResponce &&
        e1?.isActive == e2?.isActive;
  }

  @override
  int hash(TariffRecord? e) => const ListEquality().hash([
        e?.tariffType,
        e?.description,
        e?.price,
        e?.countAiResponce,
        e?.isActive
      ]);

  @override
  bool isValidKey(Object? o) => o is TariffRecord;
}
