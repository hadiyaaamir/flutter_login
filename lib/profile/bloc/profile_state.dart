part of 'profile_bloc.dart';

final class ProfileState extends Equatable {
  const ProfileState({
    this.status = FormzSubmissionStatus.initial,
    this.firstName = const Name.pure(),
    this.lastName = const Name.pure(),
    this.designation = const Designation.pure(),
    this.isValid = false,
  });

  final FormzSubmissionStatus status;
  final Name firstName;
  final Name lastName;
  final Designation designation;
  final bool isValid;

  ProfileState copyWith({
    FormzSubmissionStatus? status,
    Name? firstName,
    Name? lastName,
    Designation? designation,
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
  List<Object> get props => [firstName, lastName, designation];
}
