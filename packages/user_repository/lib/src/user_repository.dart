import 'package:user_repository/src/models/models.dart';
import 'package:uuid/uuid.dart';

class UserRepository {
  User? _user;

  Future<User?> getUser() async {
    if (_user != null) return _user;

    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = User(
        id: const Uuid().v4(),
        firstName: 'Hadiya',
        lastName: 'Aamir',
        email: 'h.aamir@gmail.com',
        designation: 'Intern',
      ),
    );
  }
}
