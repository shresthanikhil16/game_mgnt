// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveMessageModelAdapter extends TypeAdapter<HiveMessageModel> {
  @override
  final int typeId = 0;

  @override
  HiveMessageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveMessageModel(
      sender: fields[0] as String,
      receiver: fields[1] as String,
      text: fields[2] as String,
      timestamp: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, HiveMessageModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.sender)
      ..writeByte(1)
      ..write(obj.receiver)
      ..writeByte(2)
      ..write(obj.text)
      ..writeByte(3)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveMessageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
