// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament_creation_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TournamentHiveModelAdapter extends TypeAdapter<TournamentHiveModel> {
  @override
  final int typeId = 1;

  @override
  TournamentHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TournamentHiveModel(
      tournamentId: fields[0] as String?,
      name: fields[1] as String,
      game: fields[2] as String,
      startDate: fields[3] as DateTime,
      endDate: fields[4] as DateTime,
      prize: fields[5] as String,
      description: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TournamentHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.tournamentId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.game)
      ..writeByte(3)
      ..write(obj.startDate)
      ..writeByte(4)
      ..write(obj.endDate)
      ..writeByte(5)
      ..write(obj.prize)
      ..writeByte(6)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TournamentHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
