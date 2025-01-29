import 'package:equatable/equatable.dart';
import 'package:game_mgnt/app/constants/hive_table_constant.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entity/auth_entity.dart';

part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.studentTableId)
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String? studentId;
  @HiveField(1)
  final String username; // updated field
  @HiveField(2)
  final String email; // updated field
  @HiveField(3)
  final String password; // updated field
  @HiveField(4)
  final String confirmPassword; // updated field

  AuthHiveModel({
    String? studentId,
    required this.username, // updated field
    required this.email, // updated field
    required this.password, // updated field
    required this.confirmPassword, // updated field
  }) : studentId = studentId ?? const Uuid().v4();

  // Initial Constructor
  const AuthHiveModel.initial()
      : studentId = '',
        username = '', // updated field
        email = '', // updated field
        password = '', // updated field
        confirmPassword = ''; // updated field

  // From Entity
  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      studentId: entity.userId,
      username: entity.username, // updated field
      email: entity.email, // updated field
      password: entity.password, // updated field
      confirmPassword: entity.confirmPassword, // updated field
    );
  }

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      userId: studentId,
      username: username, // updated field
      email: email, // updated field
      password: password, // updated field
      confirmPassword: confirmPassword, // updated field
    );
  }

  @override
  List<Object?> get props =>
      [studentId, username, email, password, confirmPassword];
}
