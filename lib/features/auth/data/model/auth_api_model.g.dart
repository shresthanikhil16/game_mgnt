// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthApiModel _$AuthApiModelFromJson(Map<String, dynamic> json) => AuthApiModel(
      id: json['_id'] as String?,
      username: json['username'] as String,
      image: json['image'] as String?,
      email: json['email'] as String,
      password: json['password'] as String?,
      confirmPassword: json['confirmPassword'] as String,
    );

Map<String, dynamic> _$AuthApiModelToJson(AuthApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'username': instance.username,
      'image': instance.image,
      'email': instance.email,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
    };
