// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SetModelAdapter extends TypeAdapter<SetModel> {
  @override
  final int typeId = 2;

  @override
  SetModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SetModel(
      id: fields[0] as String,
      weight: fields[1] as double?,
      reps: fields[2] as double?,
      isWarmup: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SetModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.weight)
      ..writeByte(2)
      ..write(obj.reps)
      ..writeByte(3)
      ..write(obj.isWarmup);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SetModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
