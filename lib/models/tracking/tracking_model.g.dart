// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracking_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrackerAdapter extends TypeAdapter<Tracker> {
  @override
  final int typeId = 3;

  @override
  Tracker read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tracker(
      id: fields[0] as String,
      title: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Tracker obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrackerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
