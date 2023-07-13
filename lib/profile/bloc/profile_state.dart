part of 'profile_bloc.dart';

final class ProfileState extends Equatable {
  const ProfileState({
    this.status = FormzSubmissionStatus.initial,
    this.firstName = const StringInput.pure(),
    this.lastName = const StringInput.pure(),
    this.designation = const StringInput.pure(),
    this.isValid = false,
  });

  final FormzSubmissionStatus status;
  final StringInput firstName;
  final StringInput lastName;
  final StringInput designation;
  final bool isValid;

  ProfileState copyWith({
    FormzSubmissionStatus? status,
    StringInput? firstName,
    StringInput? lastName,
    StringInput? designation,
    bool? isValid,
  }) {
    return ProfileState(
      status: status ?? this.status,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      designation: designation ?? this.designation,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [status, firstName, lastName, designation];
}
