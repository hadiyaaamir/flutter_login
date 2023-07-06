import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_repository/src/models/models.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

part 'user_hardcoded.dart';
part 'user_firebase.dart';

abstract class UserRepository {
  Future<User?> getUser();
}
