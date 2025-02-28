// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament_creation_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TournamentApiModel _$TournamentApiModelFromJson(Map<String, dynamic> json) =>
    TournamentApiModel(
      id: json['_id'] as String?,
      name: json['name'] as String,
      game: json['game'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      prize: json['prize'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$TournamentApiModelToJson(TournamentApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'game': instance.game,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'prize': instance.prize,
      'description': instance.description,
    };
