part of 'user_repository.dart';

class UserRepositoryFirebase extends UserRepository {
  User? _user;
  final firebase_auth.FirebaseAuth _firebaseAuth =
      firebase_auth.FirebaseAuth.instance;

  final usersCollection = FirebaseFirestore.instance.collection("Users");

  Future<User?> getUser() async {
    // if (_user != null) return _user;

    final String? email = _firebaseAuth.currentUser?.email;
    final String? userId = _firebaseAuth.currentUser?.uid;

    if (email != null) {
      await usersCollection.doc(userId).get().then((snapshot) async {
        if (snapshot.exists) {
          _user = User.fromJson(snapshot.data()!);
        } else if (userId != null) {
          await CreateUser(userId: userId, email: email);
        }
      });
      return _user;
    }

    return _user = null;
  }

  Future<void> CreateUser({
    required String userId,
    required String email,
  }) async {
    User user = User.empty.copyWith(
      email: email,
    );

    await usersCollection.doc(userId).set(user.toJson()).then((_) {
      _user = user;
    });
  }
}
