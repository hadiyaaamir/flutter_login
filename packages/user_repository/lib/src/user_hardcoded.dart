part of 'user_repository.dart';

class UserRepositoryHardcoded extends UserRepository {
  User? _user;

  Future<User?> getUser() async {
    if (_user != null) return _user;

    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = User(
        // id: const Uuid().v4(),
        firstName: 'Hadiya',
        lastName: 'Aamir',
        email: 'h.aamir@gmail.com',
        designation: 'Intern',
      ),
    );
  }

  @override
  Future<void> updateUser(User user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  void refreshUser() {
    _user = null;
  }
}
