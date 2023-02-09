import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:layover/model/user_model.dart';
import '/respositories/repositories.dart';

class DatabaseRepository extends BaseDatabaseRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<User> getUser(String userId) {
    print('Getting user images from DB');
    return _firebaseFirestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snap) => User.fromSnapshot(snap));
  }

  @override
  Stream<List<User>> getUsers(
      String userId, String gender, String prebio, String location) {
    return _firebaseFirestore
        .collection('users')
        .where(
          'gender',
          isNotEqualTo: gender,
        )
        .where(
          'location',
          isEqualTo: location,
        )
        .snapshots()
        .map((snap) {
      return snap.docs.map((doc) => User.fromSnapshot(doc)).toList();
    });
  }

  @override
  Stream<List<User>> getUsersChat(String userId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('messages')
        .snapshots();
    return _firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('messages')
        .snapshots()
        .map((snap) {
      return snap.docs.map((doc) => User.fromSnapshot(doc)).toList();
    });
  }

  @override
  Future<void> createUser(User user) async {
    await _firebaseFirestore.collection('users').doc(user.id).set(user.toMap());
  }

  @override
  Future<void> createChat(User user) async {
    await _firebaseFirestore
        .collection('messages')
        .doc(user.id)
        .collection('${user.id}')
        .doc(DateTime.now().millisecondsSinceEpoch.toString())
        .set(user.toMap());
  }

  @override
  Future<void> updateUser(User user) async {
    return _firebaseFirestore
        .collection('users')
        .doc(user.id)
        .update(user.toMap())
        .then(
          (value) => print('User document updated.'),
        );
  }

  @override
  Future<void> updateUserPictures(User user, String imageName) async {
    String downloadUrl =
        await StorageRepository().getDownloadURL(user, imageName);

    return _firebaseFirestore.collection('users').doc(user.id).update({
      'imageUrls': FieldValue.arrayUnion([downloadUrl])
    });
  }
}
