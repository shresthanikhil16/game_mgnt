import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entity/auth_entity.dart';
import '../repository/auth_repository.dart';

class RegisterUserParams extends Equatable {
  final String username; // updated to firstName
  final String email; // updated to email
  final String? profilePicture;
  final String password;
  final String confirmPassword; // added confirmPassword

  const RegisterUserParams({
    required this.username, // updated to firstName
    required this.email, // updated to email
    this.profilePicture,
    required this.password,
    required this.confirmPassword, // added confirmPassword
  });

  // Initial constructor
  const RegisterUserParams.initial({
    required this.username, // updated to firstName
    required this.email, // updated to email
    required this.profilePicture,
    required this.password,
    required this.confirmPassword, // added confirmPassword
  });

  @override
  List<Object?> get props => [
        username,
        email,
        profilePicture,
        password,
        confirmPassword
      ]; // updated props
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
      username: params.username, // updated to firstName
      email: params.email, // updated to email
      profilePicture: params.profilePicture,
      password: params.password,
      confirmPassword: params.confirmPassword, // added confirmPassword
    );
    return repository.registerStudent(authEntity);
  }
}
