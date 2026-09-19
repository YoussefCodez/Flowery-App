import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String photo;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String gender;
  const UserEntity({
    required this.photo,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.gender,
  });

  @override
  List<Object?> get props => [photo, firstName, lastName, phone, email, gender];
}
