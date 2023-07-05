import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.designation,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String designation;

  @override
  List<Object?> get props => [id];

  static const empty = User(
    id: '-',
    firstName: '',
    lastName: '',
    email: '',
    designation: '',
  );
}
