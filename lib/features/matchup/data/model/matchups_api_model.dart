import 'package:game_mgnt/features/matchup/domain/entity/matchups_entity.dart';

class MatchupApiModel {
  final String tournament;
  final List<MatchupPairApiModel> matchups;

  MatchupApiModel({required this.tournament, required this.matchups});

  factory MatchupApiModel.fromJson(Map<String, dynamic> json) {
    return MatchupApiModel(
      tournament: json['tournament'],
      matchups: (json['matchups'] as List)
          .map((matchup) => MatchupPairApiModel.fromJson(matchup))
          .toList(),
    );
  }

  MatchupEntity toEntity() {
    return MatchupEntity(
      tournament: tournament,
      matchups: matchups.map((pair) => pair.toEntity()).toList(),
    );
  }
}

class MatchupPairApiModel {
  final String participant1;
  final String participant2;

  MatchupPairApiModel({required this.participant1, required this.participant2});

  factory MatchupPairApiModel.fromJson(Map<String, dynamic> json) {
    return MatchupPairApiModel(
      participant1: json['participant1'],
      participant2: json['participant2'],
    );
  }

  MatchupPairEntity toEntity() {
    return MatchupPairEntity(
      participant1: participant1,
      participant2: participant2,
    );
  }
}
