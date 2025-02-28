import 'package:equatable/equatable.dart';
import 'package:game_mgnt/features/match_register/domain/entity/tournament_registration_entity.dart';

class TournamentRegistrationApiModel extends Equatable {
  final String? id;
  final String name;
  final String email;
  final String game;
  final String tournament;
  final String teamNumber;

  const TournamentRegistrationApiModel({
    this.id,
    required this.name,
    required this.email,
    required this.game,
    required this.tournament,
    required this.teamNumber,
  });

  factory TournamentRegistrationApiModel.fromJson(Map<String, dynamic> json) {
    return TournamentRegistrationApiModel(
      id: json['_id'] as String?,
      name: json['name'] as String,
      email: json['email'] as String,
      game: json['game'] as String,
      tournament: json['tournament'] as String,
      teamNumber: json['teamNumber'].toString(), // Ensure it's a String
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id, // Include `_id` for consistency
      'name': name,
      'email': email,
      'game': game,
      'tournament': tournament,
      'teamNumber': teamNumber,
    };
  }

  TournamentRegistrationEntity toEntity() {
    return TournamentRegistrationEntity(
      id: id,
      name: name,
      email: email,
      game: game,
      tournament: tournament,
      teamNumber: teamNumber,
    );
  }

  factory TournamentRegistrationApiModel.fromEntity(
      TournamentRegistrationEntity entity) {
    return TournamentRegistrationApiModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      game: entity.game,
      tournament: entity.tournament,
      teamNumber: entity.teamNumber,
    );
  }

  @override
  List<Object?> get props => [id, name, email, game, tournament, teamNumber];
}
