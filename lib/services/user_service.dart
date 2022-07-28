import 'package:cloud_firestore/cloud_firestore.dart';
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
      await firestore.collection('/users').add(newUser.toJson());
    }
  }
}
