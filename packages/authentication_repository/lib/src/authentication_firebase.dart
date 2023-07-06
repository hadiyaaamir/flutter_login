part of 'authentication_repository.dart';

class AuthenticationRepositoryFirebase extends AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final firebase_auth.FirebaseAuth _firebaseAuth =
      firebase_auth.FirebaseAuth.instance;

  @override
  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  @override
  void dispose() => _controller.close();

  @override
  Future<void> logIn(
      {required String username, required String password}) async {
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(
            email: username,
            password: password,
          )
          .then(
              (_) => () => _controller.add(AuthenticationStatus.authenticated));
    } catch (e) {
      () => _controller.add(AuthenticationStatus.unauthenticated);
      print(e);
    }
  }

  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
      ]).then(
          (_) => () => _controller.add(AuthenticationStatus.unauthenticated));
    } catch (e) {
      print(e);
    }
  }
}
