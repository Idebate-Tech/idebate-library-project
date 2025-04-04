// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_local_storage.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Profile extends _Profile with RealmEntity, RealmObjectBase, RealmObject {
  Profile(
    String firstName,
    String lastName,
    String password,
    String nationalId,
    String email,
    String phoneNumber,
  ) {
    RealmObjectBase.set(this, 'firstName', firstName);
    RealmObjectBase.set(this, 'lastName', lastName);
    RealmObjectBase.set(this, 'password', password);
    RealmObjectBase.set(this, 'nationalId', nationalId);
    RealmObjectBase.set(this, 'email', email);
    RealmObjectBase.set(this, 'phoneNumber', phoneNumber);
  }

  Profile._();

  @override
  String get firstName =>
      RealmObjectBase.get<String>(this, 'firstName') as String;
  @override
  set firstName(String value) => RealmObjectBase.set(this, 'firstName', value);

  @override
  String get lastName =>
      RealmObjectBase.get<String>(this, 'lastName') as String;
  @override
  set lastName(String value) => RealmObjectBase.set(this, 'lastName', value);

  @override
  String get password =>
      RealmObjectBase.get<String>(this, 'password') as String;
  @override
  set password(String value) => RealmObjectBase.set(this, 'password', value);

  @override
  String get nationalId =>
      RealmObjectBase.get<String>(this, 'nationalId') as String;
  @override
  set nationalId(String value) =>
      RealmObjectBase.set(this, 'nationalId', value);

  @override
  String get email => RealmObjectBase.get<String>(this, 'email') as String;
  @override
  set email(String value) => RealmObjectBase.set(this, 'email', value);

  @override
  String get phoneNumber =>
      RealmObjectBase.get<String>(this, 'phoneNumber') as String;
  @override
  set phoneNumber(String value) =>
      RealmObjectBase.set(this, 'phoneNumber', value);

  @override
  Stream<RealmObjectChanges<Profile>> get changes =>
      RealmObjectBase.getChanges<Profile>(this);

  @override
  Stream<RealmObjectChanges<Profile>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Profile>(this, keyPaths);

  @override
  Profile freeze() => RealmObjectBase.freezeObject<Profile>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'firstName': firstName.toEJson(),
      'lastName': lastName.toEJson(),
      'password': password.toEJson(),
      'nationalId': nationalId.toEJson(),
      'email': email.toEJson(),
      'phoneNumber': phoneNumber.toEJson(),
    };
  }

  static EJsonValue _toEJson(Profile value) => value.toEJson();
  static Profile _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'firstName': EJsonValue firstName,
        'lastName': EJsonValue lastName,
        'password': EJsonValue password,
        'nationalId': EJsonValue nationalId,
        'email': EJsonValue email,
        'phoneNumber': EJsonValue phoneNumber,
      } =>
        Profile(
          fromEJson(firstName),
          fromEJson(lastName),
          fromEJson(password),
          fromEJson(nationalId),
          fromEJson(email),
          fromEJson(phoneNumber),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Profile._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, Profile, 'Profile', [
      SchemaProperty('firstName', RealmPropertyType.string),
      SchemaProperty('lastName', RealmPropertyType.string),
      SchemaProperty('password', RealmPropertyType.string),
      SchemaProperty('nationalId', RealmPropertyType.string),
      SchemaProperty('email', RealmPropertyType.string),
      SchemaProperty('phoneNumber', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class Book extends _Book with RealmEntity, RealmObjectBase, RealmObject {
  Book(
    String isbn,
    String subject,
    String title,
    String borrowedBy,
    String email,
    String nationalId,
    String phoneNumber,
    String returnDate,
  ) {
    RealmObjectBase.set(this, 'isbn', isbn);
    RealmObjectBase.set(this, 'subject', subject);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'borrowedBy', borrowedBy);
    RealmObjectBase.set(this, 'email', email);
    RealmObjectBase.set(this, 'nationalId', nationalId);
    RealmObjectBase.set(this, 'phoneNumber', phoneNumber);
    RealmObjectBase.set(this, 'returnDate', returnDate);
  }

  Book._();

  @override
  String get isbn => RealmObjectBase.get<String>(this, 'isbn') as String;
  @override
  set isbn(String value) => RealmObjectBase.set(this, 'isbn', value);

  @override
  String get subject => RealmObjectBase.get<String>(this, 'subject') as String;
  @override
  set subject(String value) => RealmObjectBase.set(this, 'subject', value);

  @override
  String get title => RealmObjectBase.get<String>(this, 'title') as String;
  @override
  set title(String value) => RealmObjectBase.set(this, 'title', value);

  @override
  String get borrowedBy =>
      RealmObjectBase.get<String>(this, 'borrowedBy') as String;
  @override
  set borrowedBy(String value) =>
      RealmObjectBase.set(this, 'borrowedBy', value);

  @override
  String get email => RealmObjectBase.get<String>(this, 'email') as String;
  @override
  set email(String value) => RealmObjectBase.set(this, 'email', value);

  @override
  String get nationalId =>
      RealmObjectBase.get<String>(this, 'nationalId') as String;
  @override
  set nationalId(String value) =>
      RealmObjectBase.set(this, 'nationalId', value);

  @override
  String get phoneNumber =>
      RealmObjectBase.get<String>(this, 'phoneNumber') as String;
  @override
  set phoneNumber(String value) =>
      RealmObjectBase.set(this, 'phoneNumber', value);

  @override
  String get returnDate =>
      RealmObjectBase.get<String>(this, 'returnDate') as String;
  @override
  set returnDate(String value) =>
      RealmObjectBase.set(this, 'returnDate', value);

  @override
  Stream<RealmObjectChanges<Book>> get changes =>
      RealmObjectBase.getChanges<Book>(this);

  @override
  Stream<RealmObjectChanges<Book>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Book>(this, keyPaths);

  @override
  Book freeze() => RealmObjectBase.freezeObject<Book>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'isbn': isbn.toEJson(),
      'subject': subject.toEJson(),
      'title': title.toEJson(),
      'borrowedBy': borrowedBy.toEJson(),
      'email': email.toEJson(),
      'nationalId': nationalId.toEJson(),
      'phoneNumber': phoneNumber.toEJson(),
      'returnDate': returnDate.toEJson(),
    };
  }

  static EJsonValue _toEJson(Book value) => value.toEJson();
  static Book _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'isbn': EJsonValue isbn,
        'subject': EJsonValue subject,
        'title': EJsonValue title,
        'borrowedBy': EJsonValue borrowedBy,
        'email': EJsonValue email,
        'nationalId': EJsonValue nationalId,
        'phoneNumber': EJsonValue phoneNumber,
        'returnDate': EJsonValue returnDate,
      } =>
        Book(
          fromEJson(isbn),
          fromEJson(subject),
          fromEJson(title),
          fromEJson(borrowedBy),
          fromEJson(email),
          fromEJson(nationalId),
          fromEJson(phoneNumber),
          fromEJson(returnDate),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Book._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, Book, 'Book', [
      SchemaProperty('isbn', RealmPropertyType.string),
      SchemaProperty('subject', RealmPropertyType.string),
      SchemaProperty('title', RealmPropertyType.string),
      SchemaProperty('borrowedBy', RealmPropertyType.string),
      SchemaProperty('email', RealmPropertyType.string),
      SchemaProperty('nationalId', RealmPropertyType.string),
      SchemaProperty('phoneNumber', RealmPropertyType.string),
      SchemaProperty('returnDate', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class Library extends _Library with RealmEntity, RealmObjectBase, RealmObject {
  Library(
    String subject,
    String isbn,
    String title,
    String publisher,
    String published,
  ) {
    RealmObjectBase.set(this, 'subject', subject);
    RealmObjectBase.set(this, 'isbn', isbn);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'publisher', publisher);
    RealmObjectBase.set(this, 'published', published);
  }

  Library._();

  @override
  String get subject => RealmObjectBase.get<String>(this, 'subject') as String;
  @override
  set subject(String value) => RealmObjectBase.set(this, 'subject', value);

  @override
  String get isbn => RealmObjectBase.get<String>(this, 'isbn') as String;
  @override
  set isbn(String value) => RealmObjectBase.set(this, 'isbn', value);

  @override
  String get title => RealmObjectBase.get<String>(this, 'title') as String;
  @override
  set title(String value) => RealmObjectBase.set(this, 'title', value);

  @override
  String get publisher =>
      RealmObjectBase.get<String>(this, 'publisher') as String;
  @override
  set publisher(String value) => RealmObjectBase.set(this, 'publisher', value);

  @override
  String get published =>
      RealmObjectBase.get<String>(this, 'published') as String;
  @override
  set published(String value) => RealmObjectBase.set(this, 'published', value);

  @override
  Stream<RealmObjectChanges<Library>> get changes =>
      RealmObjectBase.getChanges<Library>(this);

  @override
  Stream<RealmObjectChanges<Library>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Library>(this, keyPaths);

  @override
  Library freeze() => RealmObjectBase.freezeObject<Library>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'subject': subject.toEJson(),
      'isbn': isbn.toEJson(),
      'title': title.toEJson(),
      'publisher': publisher.toEJson(),
      'published': published.toEJson(),
    };
  }

  static EJsonValue _toEJson(Library value) => value.toEJson();
  static Library _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'subject': EJsonValue subject,
        'isbn': EJsonValue isbn,
        'title': EJsonValue title,
        'publisher': EJsonValue publisher,
        'published': EJsonValue published,
      } =>
        Library(
          fromEJson(subject),
          fromEJson(isbn),
          fromEJson(title),
          fromEJson(publisher),
          fromEJson(published),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Library._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, Library, 'Library', [
      SchemaProperty('subject', RealmPropertyType.string),
      SchemaProperty('isbn', RealmPropertyType.string),
      SchemaProperty('title', RealmPropertyType.string),
      SchemaProperty('publisher', RealmPropertyType.string),
      SchemaProperty('published', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class Checker extends _Checker with RealmEntity, RealmObjectBase, RealmObject {
  Checker(
    String checker,
  ) {
    RealmObjectBase.set(this, 'checker', checker);
  }

  Checker._();

  @override
  String get checker => RealmObjectBase.get<String>(this, 'checker') as String;
  @override
  set checker(String value) => RealmObjectBase.set(this, 'checker', value);

  @override
  Stream<RealmObjectChanges<Checker>> get changes =>
      RealmObjectBase.getChanges<Checker>(this);

  @override
  Stream<RealmObjectChanges<Checker>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Checker>(this, keyPaths);

  @override
  Checker freeze() => RealmObjectBase.freezeObject<Checker>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'checker': checker.toEJson(),
    };
  }

  static EJsonValue _toEJson(Checker value) => value.toEJson();
  static Checker _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'checker': EJsonValue checker,
      } =>
        Checker(
          fromEJson(checker),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Checker._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, Checker, 'Checker', [
      SchemaProperty('checker', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
