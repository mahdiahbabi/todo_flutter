// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 0;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task()
      ..TaskTitle = fields[0] as String
      ..TaskDetail = fields[1] as String
      ..Time = fields[2] as DateTime
      ..categori = fields[3] as Categori
      ..iscompleted = fields[4] as bool;
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.TaskTitle)
      ..writeByte(1)
      ..write(obj.TaskDetail)
      ..writeByte(2)
      ..write(obj.Time)
      ..writeByte(3)
      ..write(obj.categori)
      ..writeByte(4)
      ..write(obj.iscompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CategoriAdapter extends TypeAdapter<Categori> {
  @override
  final int typeId = 1;

  @override
  Categori read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Categori.work;
      case 1:
        return Categori.study;
      case 2:
        return Categori.sport;
      default:
        return Categori.work;
    }
  }

  @override
  void write(BinaryWriter writer, Categori obj) {
    switch (obj) {
      case Categori.work:
        writer.writeByte(0);
        break;
      case Categori.study:
        writer.writeByte(1);
        break;
      case Categori.sport:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoriAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
