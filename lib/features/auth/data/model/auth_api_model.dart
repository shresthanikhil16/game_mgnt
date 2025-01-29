import 'package:equatable/equatable.dart';
import 'package:game_mgnt/features/auth/domain/entity/auth_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String username;
  final String? image;
  final String email;
  final String? password;
  final String confirmPassword;

  const AuthApiModel({
    this.id,
    required this.username,
    required this.image,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  //To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      userId: id,
      username: username,
      email: email,
      password: password ?? '',
      confirmPassword: confirmPassword,
    );
  }

  //from Entity
  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      username: entity.username,
      email: entity.email,
      image: entity.image,
      password: entity.password,
      confirmPassword: entity.confirmPassword,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
