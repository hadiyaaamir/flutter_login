part of 'user_repository.dart';

class UserRepositoryFirebase extends UserRepository {
  User? _user;
  // final firebase_auth.FirebaseAuth _firebaseAuth =
  //     firebase_auth.FirebaseAuth.instance;

  final usersCollection = FirebaseFirestore.instance.collection("Users");

  Future<User?> getUser({String? userId, String? email}) async {
    if (_user != null) return _user;

    if (userId != null) {
      await usersCollection.doc(userId).get().then((snapshot) async {
        if (snapshot.exists) {
          _user = User.fromJson(snapshot.data()!);
        } else if (email != null) {
          _user = User.empty.copyWith(email: email);
        }
        // await createUser(userId: userId, email: email);
      });
    }
    return _user;
  }

  Future<void> createUser({required String userId, required User user}) async {
    await usersCollection
        .doc(userId)
        .set(user.toJson())
        .then((_) => _user = user);
  }

  @override
  Future<void> updateUser({required String userId, required User user}) async {
    // User updatedUser = user.copyWith(email: email);
    await usersCollection
        .doc(userId)
        .update(user.toJson())
        .then((value) => _user = user);
  }

  void refreshUser() => _user = null;
}
