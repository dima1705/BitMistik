import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DiaryRecord extends FirestoreRecord {
  DiaryRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "Title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "note" field.
  String? _note;
  String get note => _note ?? '';
  bool hasNote() => _note != null;

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "answ1res" field.
  String? _answ1res;
  String get answ1res => _answ1res ?? '';
  bool hasAnsw1res() => _answ1res != null;

  // "answ2res" field.
  String? _answ2res;
  String get answ2res => _answ2res ?? '';
  bool hasAnsw2res() => _answ2res != null;

  // "answ3res" field.
  String? _answ3res;
  String get answ3res => _answ3res ?? '';
  bool hasAnsw3res() => _answ3res != null;

  // "cardImageDay" field.
  String? _cardImageDay;
  String get cardImageDay => _cardImageDay ?? '';
  bool hasCardImageDay() => _cardImageDay != null;

  // "adviceDay" field.
  String? _adviceDay;
  String get adviceDay => _adviceDay ?? '';
  bool hasAdviceDay() => _adviceDay != null;

  void _initializeFields() {
    _title = snapshotData['Title'] as String?;
    _note = snapshotData['note'] as String?;
    _user = snapshotData['user'] as DocumentReference?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _answ1res = snapshotData['answ1res'] as String?;
    _answ2res = snapshotData['answ2res'] as String?;
    _answ3res = snapshotData['answ3res'] as String?;
    _cardImageDay = snapshotData['cardImageDay'] as String?;
    _adviceDay = snapshotData['adviceDay'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('diary');

  static Stream<DiaryRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DiaryRecord.fromSnapshot(s));

  static Future<DiaryRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DiaryRecord.fromSnapshot(s));

  static DiaryRecord fromSnapshot(DocumentSnapshot snapshot) => DiaryRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DiaryRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DiaryRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DiaryRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DiaryRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDiaryRecordData({
  String? title,
  String? note,
  DocumentReference? user,
  DateTime? createdAt,
  String? answ1res,
  String? answ2res,
  String? answ3res,
  String? cardImageDay,
  String? adviceDay,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'Title': title,
      'note': note,
      'user': user,
      'created_at': createdAt,
      'answ1res': answ1res,
      'answ2res': answ2res,
      'answ3res': answ3res,
      'cardImageDay': cardImageDay,
      'adviceDay': adviceDay,
    }.withoutNulls,
  );

  return firestoreData;
}

class DiaryRecordDocumentEquality implements Equality<DiaryRecord> {
  const DiaryRecordDocumentEquality();

  @override
  bool equals(DiaryRecord? e1, DiaryRecord? e2) {
    return e1?.title == e2?.title &&
        e1?.note == e2?.note &&
        e1?.user == e2?.user &&
        e1?.createdAt == e2?.createdAt &&
        e1?.answ1res == e2?.answ1res &&
        e1?.answ2res == e2?.answ2res &&
        e1?.answ3res == e2?.answ3res &&
        e1?.cardImageDay == e2?.cardImageDay &&
        e1?.adviceDay == e2?.adviceDay;
  }

  @override
  int hash(DiaryRecord? e) => const ListEquality().hash([
        e?.title,
        e?.note,
        e?.user,
        e?.createdAt,
        e?.answ1res,
        e?.answ2res,
        e?.answ3res,
        e?.cardImageDay,
        e?.adviceDay
      ]);

  @override
  bool isValidKey(Object? o) => o is DiaryRecord;
}
