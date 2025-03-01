// lib/features/history/data/model/history_api_model.dart
import 'package:game_mgnt/features/history/domain/entity/history_entity.dart';

class HistoryApiModel {
  final String tournament;
  final String winner;
  final DateTime date;

  HistoryApiModel({
    required this.tournament,
    required this.winner,
    required this.date,
  });

  factory HistoryApiModel.fromJson(Map<String, dynamic> json) {
    return HistoryApiModel(
      tournament: json['tournament'],
      winner: json['winner'],
      date: DateTime.parse(json['date']),
    );
  }

  HistoryEntity toEntity() {
    return HistoryEntity(
      tournament: tournament,
      winner: winner,
      date: date,
    );
  }
}
