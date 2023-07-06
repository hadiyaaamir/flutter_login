part of 'signup_bloc.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

final class SignupEmailChanged extends SignupEvent {
  const SignupEmailChanged(this.email);
  final String email;

  @override
  List<Object> get props => [email];
}

final class SignupPasswordChanged extends SignupEvent {
  const SignupPasswordChanged(this.password);
  final String password;

  @override
  List<Object> get props => [password];
}

final class ConfirmedPasswordChanged extends SignupEvent {
  const ConfirmedPasswordChanged(this.confirmedPassword);
  final String confirmedPassword;

  @override
  List<Object> get props => [confirmedPassword];
}

final class SignupSubmitted extends SignupEvent {
  const SignupSubmitted();
}
