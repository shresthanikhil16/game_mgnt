// tournament_creation_api_model.dart (Canvas 3)
import 'package:equatable/equatable.dart';
import 'package:game_mgnt/features/tournament_creation/domain/entity/tournament_creation_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tournament_creation_api_model.g.dart';

@JsonSerializable()
class TournamentApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String name;
  final String game;
  final DateTime startDate;
  final DateTime endDate;
  final String prize;
  final String description;

  const TournamentApiModel({
    this.id,
    required this.name,
    required this.game,
    required this.startDate,
    required this.endDate,
    required this.prize,
    required this.description,
  });

  factory TournamentApiModel.fromJson(Map<String, dynamic> json) =>
      _$TournamentApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$TournamentApiModelToJson(this);

  TournamentEntity toEntity() {
    return TournamentEntity(
      id: id,
      name: name,
      game: game,
      startDate: startDate,
      endDate: endDate,
      prize: prize,
      description: description,
    );
  }

  factory TournamentApiModel.fromEntity(TournamentEntity entity) {
    return TournamentApiModel(
      id: entity.id,
      name: entity.name,
      game: entity.game,
      startDate: entity.startDate,
      endDate: entity.endDate,
      prize: entity.prize,
      description: entity.description,
    );
  }

  @override
  List<Object?> get props =>
      [id, name, game, startDate, endDate, prize, description];
}
