import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_cc/model/user.dart';

class UserService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<User?> getUser({required String emailAddress}) async {
    final users =
        firestore.collection('/users').where('email', isEqualTo: emailAddress);

    final snapshot = await users.get()
      ..docs;

    if (snapshot.docs.isEmpty) {
      return null;
    }

    return User.fromSnapshot(snapshot.docs.first, snapshot.docs.first.id);
  }

  Future<void> registerUser({required User newUser}) async {
    var user = await getUser(emailAddress: newUser.email);
    if (user == null) {
      final record = await firestore.collection('/users').add(newUser.toJson());
      final createdUser = await record.get()
        ..data();
      user = User.fromSnapshot(createdUser, createdUser.id);
    }

    /// store user locally for session
    const FlutterSecureStorage().write(key: 'user_id', value: user.id);
  }
}
