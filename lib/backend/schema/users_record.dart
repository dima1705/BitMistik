import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "adminTrue" field.
  bool? _adminTrue;
  bool get adminTrue => _adminTrue ?? false;
  bool hasAdminTrue() => _adminTrue != null;

  // "adminFalse" field.
  bool? _adminFalse;
  bool get adminFalse => _adminFalse ?? false;
  bool hasAdminFalse() => _adminFalse != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "diary" field.
  List<DocumentReference>? _diary;
  List<DocumentReference> get diary => _diary ?? const [];
  bool hasDiary() => _diary != null;

  // "user_questionnaire" field.
  DocumentReference? _userQuestionnaire;
  DocumentReference? get userQuestionnaire => _userQuestionnaire;
  bool hasUserQuestionnaire() => _userQuestionnaire != null;

  // "balance" field.
  double? _balance;
  double get balance => _balance ?? 0.0;
  bool hasBalance() => _balance != null;

  // "fotuneTelling" field.
  List<DocumentReference>? _fotuneTelling;
  List<DocumentReference> get fotuneTelling => _fotuneTelling ?? const [];
  bool hasFotuneTelling() => _fotuneTelling != null;

  // "subscriptions" field.
  DocumentReference? _subscriptions;
  DocumentReference? get subscriptions => _subscriptions;
  bool hasSubscriptions() => _subscriptions != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _adminTrue = snapshotData['adminTrue'] as bool?;
    _adminFalse = snapshotData['adminFalse'] as bool?;
    _status = snapshotData['status'] as String?;
    _diary = getDataList(snapshotData['diary']);
    _userQuestionnaire =
        snapshotData['user_questionnaire'] as DocumentReference?;
    _balance = castToType<double>(snapshotData['balance']);
    _fotuneTelling = getDataList(snapshotData['fotuneTelling']);
    _subscriptions = snapshotData['subscriptions'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  bool? adminTrue,
  bool? adminFalse,
  String? status,
  DocumentReference? userQuestionnaire,
  double? balance,
  DocumentReference? subscriptions,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'adminTrue': adminTrue,
      'adminFalse': adminFalse,
      'status': status,
      'user_questionnaire': userQuestionnaire,
      'balance': balance,
      'subscriptions': subscriptions,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.adminTrue == e2?.adminTrue &&
        e1?.adminFalse == e2?.adminFalse &&
        e1?.status == e2?.status &&
        listEquality.equals(e1?.diary, e2?.diary) &&
        e1?.userQuestionnaire == e2?.userQuestionnaire &&
        e1?.balance == e2?.balance &&
        listEquality.equals(e1?.fotuneTelling, e2?.fotuneTelling) &&
        e1?.subscriptions == e2?.subscriptions;
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.adminTrue,
        e?.adminFalse,
        e?.status,
        e?.diary,
        e?.userQuestionnaire,
        e?.balance,
        e?.fotuneTelling,
        e?.subscriptions
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
