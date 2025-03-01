import 'package:game_mgnt/features/profile/domain/entity/profile_entity.dart';

class ProfileApiModel {
  final String username;
  final String email;
  final String profilePicture;

  ProfileApiModel({
    required this.username,
    required this.email,
    required this.profilePicture,
  });

  factory ProfileApiModel.fromJson(Map<String, dynamic> json) {
    return ProfileApiModel(
      username: json['username'],
      email: json['email'],
      profilePicture: json['profilePicture'] ?? '',
    );
  }

  // Convert to Entity
  ProfileEntity toEntity() {
    return ProfileEntity(
      username: username,
      email: email,
      profilePicture: profilePicture,
    );
  }
}
