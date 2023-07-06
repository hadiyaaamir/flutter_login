import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

part 'authentication_hardcoded.dart';
part 'authentication_firebase.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

abstract class AuthenticationRepository {
  Stream<AuthenticationStatus> get status;

  Future<void> logIn({required String username, required String password});
  void logOut();
  void dispose();
}
