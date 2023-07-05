import 'dart:async';

part 'authentication_hardcoded.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

abstract class AuthenticationRepository {
  Stream<AuthenticationStatus> get status;
  Future<void> logIn({required String username, required String password});
  void logOut();
  void dispose();
}
