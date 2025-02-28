import 'package:equatable/equatable.dart';

class TournamentRegistrationEntity extends Equatable {
  final String? id;
  final String name;
  final String email;
  final String game;
  final String tournament;
  final String teamNumber;

  const TournamentRegistrationEntity({
    this.id,
    required this.name,
    required this.email,
    required this.game,
    required this.tournament,
    required this.teamNumber,
  });

  @override
  List<Object?> get props => [id, name, email, game, tournament, teamNumber];
}
