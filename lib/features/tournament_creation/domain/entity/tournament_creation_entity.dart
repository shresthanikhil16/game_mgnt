// tournament_entity.dart (Canvas 5)
import 'package:equatable/equatable.dart';

class TournamentEntity extends Equatable {
  final String name;
  final String game;
  final DateTime startDate;
  final DateTime endDate;
  final String prize;
  final String description;
  final String? id;

  const TournamentEntity({
    required this.name,
    required this.game,
    required this.startDate,
    required this.endDate,
    required this.prize,
    required this.description,
    this.id,
  });

  factory TournamentEntity.fromJson(Map<String, dynamic> json) {
    return TournamentEntity(
      name: json['name'],
      game: json['game'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      prize: json['prize'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'game': game,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'prize': prize,
      'description': description,
    };
  }

  @override
  List<Object?> get props =>
      [name, game, startDate, endDate, prize, description, id];
}
