part of 'user_repository.dart';

class UserRepositoryFirebase extends UserRepository {
  User? _user;
  final firebase_auth.FirebaseAuth _firebaseAuth =
      firebase_auth.FirebaseAuth.instance;

  final usersCollection = FirebaseFirestore.instance.collection("Users");

  Future<User?> getUser() async {
    if (_user != null) return _user;

    final String? email = _firebaseAuth.currentUser?.email;

    if (email != null) {
      await usersCollection
          .where('email', isEqualTo: email)
          .get()
          .then((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          _user = User.fromJson(snapshot.docs.first.data());
        }
      }).then((_) {
        return _user;
      });
    }

    return _user = null;
  }
}
