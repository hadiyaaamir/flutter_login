part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

final class ProfileFirstNameChanged extends ProfileEvent {
  const ProfileFirstNameChanged(this.firstName);
  final String firstName;

  @override
  List<Object> get props => [firstName];
}

final class ProfileLastNameChanged extends ProfileEvent {
  const ProfileLastNameChanged(this.lastName);
  final String lastName;

  @override
  List<Object> get props => [lastName];
}

final class ProfileDesignationChanged extends ProfileEvent {
  const ProfileDesignationChanged(this.designation);
  final String designation;

  @override
  List<Object> get props => [designation];
}

final class ProfileSubmitted extends ProfileEvent {
  const ProfileSubmitted();
}
