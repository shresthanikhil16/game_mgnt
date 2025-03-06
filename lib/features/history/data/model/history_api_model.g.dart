// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_api_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HistoryApiModelAdapter extends TypeAdapter<HistoryApiModel> {
  @override
  final int typeId = 1;

  @override
  HistoryApiModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HistoryApiModel(
      tournament: fields[0] as String,
      winner: fields[1] as String,
      date: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, HistoryApiModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.tournament)
      ..writeByte(1)
      ..write(obj.winner)
      ..writeByte(2)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryApiModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryApiModel _$HistoryApiModelFromJson(Map<String, dynamic> json) =>
    HistoryApiModel(
      tournament: json['tournament'] as String,
      winner: json['winner'] as String,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$HistoryApiModelToJson(HistoryApiModel instance) =>
    <String, dynamic>{
      'tournament': instance.tournament,
      'winner': instance.winner,
      'date': instance.date.toIso8601String(),
    };
