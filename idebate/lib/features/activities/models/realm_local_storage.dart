import 'package:realm/realm.dart';  // import realm package
part 'realm_local_storage.realm.dart';


/// User
@RealmModel()
class _Profile
{
  late String firstName;
  late String lastName;
  late String password;
  late String nationalId;
  late String email;
  late String phoneNumber;
}

/// Borrowed Book
@RealmModel()
class _Book
{
  late String isbn;
  late String subject;
  late String title;
  late String borrowedBy;
  late String email;
  late String nationalId;
  late String phoneNumber;
  late String returnDate;
}


/// Library
@RealmModel()
class _Library
{
  late String subject;
  late String isbn;
  late String title;
  late String publisher;
  late String published;
}

/// checker
@RealmModel()
class _Checker
{
  late String checker;
}