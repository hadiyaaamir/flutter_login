part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user = AuthUser.empty,
  });

  final AuthenticationStatus status;
  final AuthUser user;

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(AuthUser user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  @override
  List<Object> get props => [status, user];
}
