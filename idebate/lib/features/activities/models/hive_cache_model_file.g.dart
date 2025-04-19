// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_cache_model_file.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookAdapter extends TypeAdapter<Book> {
  @override
  final int typeId = 0;

  @override
  Book read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Book(
      subject: fields[0] as String,
      isbn: fields[1] as String,
      title: fields[2] as String,
      publisher: fields[3] as String,
      published: fields[4] as String,
      totalQty: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Book obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.subject)
      ..writeByte(1)
      ..write(obj.isbn)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.publisher)
      ..writeByte(4)
      ..write(obj.published)
      ..writeByte(5)
      ..write(obj.totalQty);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 1;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      firstName: fields[0] as String,
      lastName: fields[1] as String,
      email: fields[2] as String,
      id: fields[3] as String,
      phoneNumber: fields[4] as String,
      password: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.firstName)
      ..writeByte(1)
      ..write(obj.lastName)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.phoneNumber)
      ..writeByte(5)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BorrowedAdapter extends TypeAdapter<Borrowed> {
  @override
  final int typeId = 2;

  @override
  Borrowed read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Borrowed(
      isbn: fields[0] as String,
      subject: fields[1] as String,
      title: fields[2] as String,
      borrowedBy: fields[3] as String,
      email: fields[4] as String,
      id: fields[5] as String,
      phoneNumber: fields[6] as String,
      pickDate: fields[7] as String,
      returnDate: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Borrowed obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.isbn)
      ..writeByte(1)
      ..write(obj.subject)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.borrowedBy)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.id)
      ..writeByte(6)
      ..write(obj.phoneNumber)
      ..writeByte(7)
      ..write(obj.pickDate)
      ..writeByte(8)
      ..write(obj.returnDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BorrowedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PendingReturnAdapter extends TypeAdapter<PendingReturn> {
  @override
  final int typeId = 3;

  @override
  PendingReturn read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PendingReturn(
      isbn: fields[0] as String,
      subject: fields[1] as String,
      title: fields[2] as String,
      returnedBy: fields[3] as String,
      email: fields[4] as String,
      id: fields[5] as String,
      phoneNumber: fields[6] as String,
      returnDate: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PendingReturn obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.isbn)
      ..writeByte(1)
      ..write(obj.subject)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.returnedBy)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.id)
      ..writeByte(6)
      ..write(obj.phoneNumber)
      ..writeByte(7)
      ..write(obj.returnDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PendingReturnAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
