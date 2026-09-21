import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CardInfoRecord extends FirestoreRecord {
  CardInfoRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "cardDescription" field.
  String? _cardDescription;
  String get cardDescription => _cardDescription ?? '';
  bool hasCardDescription() => _cardDescription != null;

  // "cardImage" field.
  String? _cardImage;
  String get cardImage => _cardImage ?? '';
  bool hasCardImage() => _cardImage != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "cardImageBack" field.
  String? _cardImageBack;
  String get cardImageBack => _cardImageBack ?? '';
  bool hasCardImageBack() => _cardImageBack != null;

  void _initializeFields() {
    _cardDescription = snapshotData['cardDescription'] as String?;
    _cardImage = snapshotData['cardImage'] as String?;
    _title = snapshotData['title'] as String?;
    _cardImageBack = snapshotData['cardImageBack'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('cardInfo');

  static Stream<CardInfoRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CardInfoRecord.fromSnapshot(s));

  static Future<CardInfoRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CardInfoRecord.fromSnapshot(s));

  static CardInfoRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CardInfoRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CardInfoRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CardInfoRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CardInfoRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CardInfoRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCardInfoRecordData({
  String? cardDescription,
  String? cardImage,
  String? title,
  String? cardImageBack,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'cardDescription': cardDescription,
      'cardImage': cardImage,
      'title': title,
      'cardImageBack': cardImageBack,
    }.withoutNulls,
  );

  return firestoreData;
}

class CardInfoRecordDocumentEquality implements Equality<CardInfoRecord> {
  const CardInfoRecordDocumentEquality();

  @override
  bool equals(CardInfoRecord? e1, CardInfoRecord? e2) {
    return e1?.cardDescription == e2?.cardDescription &&
        e1?.cardImage == e2?.cardImage &&
        e1?.title == e2?.title &&
        e1?.cardImageBack == e2?.cardImageBack;
  }

  @override
  int hash(CardInfoRecord? e) => const ListEquality()
      .hash([e?.cardDescription, e?.cardImage, e?.title, e?.cardImageBack]);

  @override
  bool isValidKey(Object? o) => o is CardInfoRecord;
}
