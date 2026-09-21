import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserQuestionnaireRecord extends FirestoreRecord {
  UserQuestionnaireRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "sex" field.
  String? _sex;
  String get sex => _sex ?? '';
  bool hasSex() => _sex != null;

  // "country" field.
  String? _country;
  String get country => _country ?? '';
  bool hasCountry() => _country != null;

  // "favColor" field.
  String? _favColor;
  String get favColor => _favColor ?? '';
  bool hasFavColor() => _favColor != null;

  // "favFilm" field.
  String? _favFilm;
  String get favFilm => _favFilm ?? '';
  bool hasFavFilm() => _favFilm != null;

  // "favBook" field.
  String? _favBook;
  String get favBook => _favBook ?? '';
  bool hasFavBook() => _favBook != null;

  // "hooby" field.
  String? _hooby;
  String get hooby => _hooby ?? '';
  bool hasHooby() => _hooby != null;

  // "profession" field.
  String? _profession;
  String get profession => _profession ?? '';
  bool hasProfession() => _profession != null;

  // "maritalStatus" field.
  String? _maritalStatus;
  String get maritalStatus => _maritalStatus ?? '';
  bool hasMaritalStatus() => _maritalStatus != null;

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  // "age" field.
  String? _age;
  String get age => _age ?? '';
  bool hasAge() => _age != null;

  // "instagram" field.
  String? _instagram;
  String get instagram => _instagram ?? '';
  bool hasInstagram() => _instagram != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  void _initializeFields() {
    _sex = snapshotData['sex'] as String?;
    _country = snapshotData['country'] as String?;
    _favColor = snapshotData['favColor'] as String?;
    _favFilm = snapshotData['favFilm'] as String?;
    _favBook = snapshotData['favBook'] as String?;
    _hooby = snapshotData['hooby'] as String?;
    _profession = snapshotData['profession'] as String?;
    _maritalStatus = snapshotData['maritalStatus'] as String?;
    _user = snapshotData['user'] as DocumentReference?;
    _age = snapshotData['age'] as String?;
    _instagram = snapshotData['instagram'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('user_questionnaire');

  static Stream<UserQuestionnaireRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UserQuestionnaireRecord.fromSnapshot(s));

  static Future<UserQuestionnaireRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => UserQuestionnaireRecord.fromSnapshot(s));

  static UserQuestionnaireRecord fromSnapshot(DocumentSnapshot snapshot) =>
      UserQuestionnaireRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UserQuestionnaireRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UserQuestionnaireRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UserQuestionnaireRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UserQuestionnaireRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUserQuestionnaireRecordData({
  String? sex,
  String? country,
  String? favColor,
  String? favFilm,
  String? favBook,
  String? hooby,
  String? profession,
  String? maritalStatus,
  DocumentReference? user,
  String? age,
  String? instagram,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'sex': sex,
      'country': country,
      'favColor': favColor,
      'favFilm': favFilm,
      'favBook': favBook,
      'hooby': hooby,
      'profession': profession,
      'maritalStatus': maritalStatus,
      'user': user,
      'age': age,
      'instagram': instagram,
      'created_at': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class UserQuestionnaireRecordDocumentEquality
    implements Equality<UserQuestionnaireRecord> {
  const UserQuestionnaireRecordDocumentEquality();

  @override
  bool equals(UserQuestionnaireRecord? e1, UserQuestionnaireRecord? e2) {
    return e1?.sex == e2?.sex &&
        e1?.country == e2?.country &&
        e1?.favColor == e2?.favColor &&
        e1?.favFilm == e2?.favFilm &&
        e1?.favBook == e2?.favBook &&
        e1?.hooby == e2?.hooby &&
        e1?.profession == e2?.profession &&
        e1?.maritalStatus == e2?.maritalStatus &&
        e1?.user == e2?.user &&
        e1?.age == e2?.age &&
        e1?.instagram == e2?.instagram &&
        e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(UserQuestionnaireRecord? e) => const ListEquality().hash([
        e?.sex,
        e?.country,
        e?.favColor,
        e?.favFilm,
        e?.favBook,
        e?.hooby,
        e?.profession,
        e?.maritalStatus,
        e?.user,
        e?.age,
        e?.instagram,
        e?.createdAt
      ]);

  @override
  bool isValidKey(Object? o) => o is UserQuestionnaireRecord;
}
