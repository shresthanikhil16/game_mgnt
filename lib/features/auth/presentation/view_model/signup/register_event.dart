part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class LoadImage extends RegisterEvent {
  final File file;

  const LoadImage({
    required this.file,
  });
}

class RegisterStudent extends RegisterEvent {
  final BuildContext context;
  final String username;
  final String email;
  final String? image;
  final String password;
  final String confirmPassword;

  const RegisterStudent({
    required this.context,
    required this.username,
    required this.email,
    this.image,
    required this.password,
    required this.confirmPassword,
  });
}
