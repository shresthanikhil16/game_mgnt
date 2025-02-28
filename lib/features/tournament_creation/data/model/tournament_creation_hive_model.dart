import 'package:equatable/equatable.dart';
import 'package:game_mgnt/features/tournament_creation/domain/entity/tournament_creation_entity.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/constants/hive_table_constant.dart';

part 'tournament_creation_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.tournamentTableId)
class TournamentHiveModel extends Equatable {
  @HiveField(0)
  final String? tournamentId;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String game;
  @HiveField(3)
  final DateTime startDate;
  @HiveField(4)
  final DateTime endDate;
  @HiveField(5)
  final String prize;
  @HiveField(6)
  final String description;

  TournamentHiveModel({
    String? tournamentId,
    required this.name,
    required this.game,
    required this.startDate,
    required this.endDate,
    required this.prize,
    required this.description,
  }) : tournamentId = tournamentId ?? const Uuid().v4();

  // Initial Constructor
  TournamentHiveModel.initial()
      : tournamentId = '',
        name = '',
        game = '',
        startDate = DateTime.now(),
        endDate = DateTime.now(),
        prize = '',
        description = '';

  // From Entity
  factory TournamentHiveModel.fromEntity(TournamentEntity entity) {
    return TournamentHiveModel(
      tournamentId: entity.id,
      name: entity.name,
      game: entity.game,
      startDate: entity.startDate,
      endDate: entity.endDate,
      prize: entity.prize,
      description: entity.description,
    );
  }

  // To Entity
  TournamentEntity toEntity() {
    return TournamentEntity(
      id: tournamentId,
      name: name,
      game: game,
      startDate: startDate,
      endDate: endDate,
      prize: prize,
      description: description,
    );
  }

  @override
  List<Object?> get props =>
      [tournamentId, name, game, startDate, endDate, prize, description];
}
