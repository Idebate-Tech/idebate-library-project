import 'package:hive/hive.dart';
part 'hive_cache_model_file.g.dart';
// Book Model
@HiveType(typeId: 0)
class Book extends HiveObject {
  @HiveField(0)
  final String subject;

  @HiveField(1)
  final String isbn;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String publisher;

  @HiveField(4)
  final String published;

  @HiveField(5)
  final String totalQty;

  Book({
    required this.subject,
    required this.isbn,
    required this.title,
    required this.publisher,
    required this.published,
    required this.totalQty,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      subject: json['subject'] ?? '',
      isbn: json['isbn'] ?? '',
      title: json['title'] ?? '',
      publisher: json['publisher'] ?? '',
      published: json['published'] ?? '',
      totalQty: json['qty'] ?? '', // make sure this matches backend
    );
  }
}

// User Model
@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  final String firstName;

  @HiveField(1)
  final String lastName;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String id;

  @HiveField(4)
  final String phoneNumber;

  @HiveField(5)
  late final String password;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.id,
    required this.phoneNumber,
    required this.password,
  });
}

// Borrowed Model
@HiveType(typeId: 2)
class Borrowed extends HiveObject {
  @HiveField(0)
  final String isbn;

  @HiveField(1)
  final String subject;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String borrowedBy;

  @HiveField(4)
  final String email;

  @HiveField(5)
  final String id;

  @HiveField(6)
  final String phoneNumber;

  @HiveField(7)
  final String pickDate;

  @HiveField(8)
  final String returnDate;

  Borrowed({
    required this.isbn,
    required this.subject,
    required this.title,
    required this.borrowedBy,
    required this.email,
    required this.id,
    required this.phoneNumber,
    required this.pickDate,
    required this.returnDate,
  });
}

// PendingReturn Model
@HiveType(typeId: 3)
class PendingReturn extends HiveObject {
  @HiveField(0)
  final String isbn;

  @HiveField(1)
  final String subject;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String returnedBy;

  @HiveField(4)
  final String email;

  @HiveField(5)
  final String id;

  @HiveField(6)
  final String phoneNumber;

  @HiveField(7)
  final String returnDate;

  PendingReturn({
    required this.isbn,
    required this.subject,
    required this.title,
    required this.returnedBy,
    required this.email,
    required this.id,
    required this.phoneNumber,
    required this.returnDate,
  });
}


