
// import 'package:get_storage/get_storage.dart';

class TValidator {

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address.';
    }
    return null;
  }


  static String? validateNationalId(String? value) {
    if (value == null || value.isEmpty) {
      return 'National ID is required.';
    }
    final RegExp alphabeteregex = RegExp(r'^[A-Z]+$');

    if (alphabeteregex.hasMatch(value)) {
      return 'Please Enter only numbers';
    }
    if (value.length < 16) {
      return 'Please enter a valid National ID';
    }
    if (value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'No special characters';
    }
    return null;
  }

  static String? validateEmptyText(String fieldName, String? value) {
    if (value == null || value.isEmpty || value == "") {
      return '$fieldName is required.';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone Number is required.';
    }
    final RegExp alphabeteregex = RegExp(r'^[A-Z]+$');

    if (alphabeteregex.hasMatch(value)) {
      return 'Please Enter only numbers';
    }
    if (value.length < 12) {
      return 'Please enter a Phone Number starting with 250 not (+250)';
    }
    if (value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'No special characters';
    }
    if (!value.startsWith('250')) {
      return 'the phone number must start with 250';
    }
    return null;
  }

  static String? validateReceived(String? value) {
    if (value == null || value.isEmpty) {
      return 'Received required';
    }
    if (value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'remove special characters';
    }
    if (value.contains(RegExp(r'[+\-]'))) {
      return 'remove - sign';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain uppercase letters.';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character.';
    }
    return null;
  }

  static String? validateOtp(String? value) {
    if (value == null || value.isEmpty) {
      return 'OTP is required.';
    }
    if (value.length < 6 || value.length > 6) {
      return 'OTP must be 6 characters long.';
    }
    final RegExp alphabeteregex = RegExp(r'^[A-Z]+$');

    if (alphabeteregex.hasMatch(value)) {
      return 'Please Enter only numbers';
    }
    return null;
  }

  static String? validateIsbn(String? value)
  {
    if (value == null || value.isEmpty) {
      return 'Pleas scan the ISBN';
    }
    return null;
  }

  static String? validateBookTitle(String? value)
  {
    if (value == null || value.isEmpty) {
      return 'Book Title is required.';
    }
    return null;
  }

  static String? validateBookPublisher(String? value)
  {
    if (value == null || value.isEmpty) {
      return 'Book Publisher is required.';
    }
    return null;
  }

  static String? validateBookPublished(String? value)
  {
    if (value == null || value.isEmpty) {
      return 'publishing year is required.';
    }
    if (value.length < 4 || value.length > 4) {
      return 'publishing year must be 4 characters long.';
    }

    final RegExp alphabeteregex = RegExp(r'^[A-Z]+$');

    if (alphabeteregex.hasMatch(value)) {
      return 'Please Enter only numbers';
    }

    return null;
  }

  static String? validateBookQty(String? value)
  {
    if (value == null || value.isEmpty) {
      return 'Book quantity is required.';
    }

    final RegExp alphabeteregex = RegExp(r'^[A-Z]+$');

    if (alphabeteregex.hasMatch(value)) {
      return 'Please Enter only numbers';
    }

    return null;
  }
}