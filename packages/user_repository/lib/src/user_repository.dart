import 'package:user_repository/src/models/models.dart';
import 'package:uuid/uuid.dart';

part 'user_hardcoded.dart';

abstract class UserRepository {
  Future<User?> getUser();
}
