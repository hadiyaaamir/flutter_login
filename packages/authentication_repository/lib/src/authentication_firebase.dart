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

  Future<void> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((_) => _controller.add(AuthenticationStatus.authenticated));
    } on firebase_auth.FirebaseAuthException catch (e) {
      _controller.add(AuthenticationStatus.unauthenticated);

      // throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
      print(e);
    } catch (_) {
      _controller.add(AuthenticationStatus.unauthenticated);

      // throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<void> logIn({required String email, required String password}) async {
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then(
        (value) {
          _controller.add(AuthenticationStatus.authenticated);
        },
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      _controller.add(AuthenticationStatus.unauthenticated);

      // throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
      print(e);
    } catch (e) {
      _controller.add(AuthenticationStatus.unauthenticated);
      print(e);
    }
  }

  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
      ]).then((_) => _controller.add(AuthenticationStatus.unauthenticated));
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() => _controller.close();

  @override
  firebase_auth.User? get currentAuthUser => _firebaseAuth.currentUser ?? null;
}
