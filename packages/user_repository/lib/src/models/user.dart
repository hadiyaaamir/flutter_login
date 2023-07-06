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
  List<Object?> get props => [id, firstName, lastName, email, designation];

  static const empty = User(
    id: '-',
    firstName: '',
    lastName: '',
    email: '',
    designation: '',
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['designation'] = designation;
    return data;
  }

  static User fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      designation: json['designation'],
    );
  }
}
