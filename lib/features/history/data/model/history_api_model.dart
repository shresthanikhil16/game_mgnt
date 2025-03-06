import 'package:game_mgnt/features/history/domain/entity/history_entity.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'history_api_model.g.dart';

@HiveType(
    typeId:
        1) // Unique typeId for Hive (ensure it doesn’t conflict with other Hive types)
@JsonSerializable()
class HistoryApiModel {
  @HiveField(0)
  final String tournament;
  @HiveField(1)
  final String winner;
  @HiveField(2)
  final DateTime date;

  HistoryApiModel({
    required this.tournament,
    required this.winner,
    required this.date,
  });

  factory HistoryApiModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryApiModelToJson(this);

  HistoryEntity toEntity() {
    return HistoryEntity(
      tournament: tournament,
      winner: winner,
      date: date,
    );
  }
}
