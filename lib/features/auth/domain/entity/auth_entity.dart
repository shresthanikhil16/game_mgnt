import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String username; // updated field
  final String email; // updated field
  final String? profilePicture;
  final String password; // updated field
  final String confirmPassword; // updated field

  const AuthEntity({
    this.userId,
    required this.username, // updated field
    required this.email, // updated field
    this.profilePicture,
    required this.password, // updated field
    required this.confirmPassword, // updated field
  });

  @override
  List<Object?> get props =>
      [userId, username, email, profilePicture, password, confirmPassword];
}
