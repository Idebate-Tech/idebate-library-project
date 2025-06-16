import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:idebate/common/widgets/recover_Account_screen/recover_screen.dart';
import 'package:idebate/common/widgets/success_screen/success_screen.dart';
import 'package:idebate/features/authentication/screens/login/login.dart';
import 'package:idebate/manager_menu.dart';
import 'package:idebate/navigation_menu.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/text_strings.dart';
import '../../authentication/screens/password_configuration/reset_password.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/hive_cache_model_file.dart';
import 'package:http/http.dart' as http;

const String apiKey = "ertuy22413rritivgcjffjzzxbcfgh"; // Replace with your secret key
const String baseUrl = 'https://iread-proxy.onrender.com/api'; // Replace with your Render URL

Map<String, String> get headers => {
  'Content-Type': 'application/json',
  'x-api-key': apiKey,
};

final booksBox = Hive.box<Book>('booksBox');
final userBox = Hive.box<User>('userBox');
final borrowedBox = Hive.box<Borrowed>('borrowedBox');
final pendingReturnBox = Hive.box<PendingReturn>('pendingReturnBox');

final _spreadsheetId = TTexts.spreadsheetId ;
final person = userBox.values;
final book = booksBox.values;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

/// find by ISBN
Future<String?> findBookByISBN(String isbn, BuildContext context) async {
  // Show the circular loader
  showDialog(
    context: Get.context!,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
  String? title;
  String? subject;
  try{
    final response = await http.get(
      Uri.parse('$baseUrl/find/book?isbn=$isbn'),
      headers: headers,
    );
    var jsonResponse = jsonDecode(response.body);
    String status = jsonResponse['status'];
    subject = jsonResponse['subject'];
    title = jsonResponse['title'];
    if(status == "valid")
      {
        Navigator.of(Get.context!).pop();
        return '$title+$subject';
      }
    else
      {
        Navigator.of(Get.context!).pop();
        return "not found";
      }
  }

  catch (e)
  {
    SnackBar(content: Text("the error $e"));
    Navigator.of(Get.context!).pop();
    notOnlineMessage(Get.context!).show();
  }
  return null;
}

/// find by ISBN For Return LookUp
Future<String?> findBookReturnLookUp(String isbn, BuildContext context) async {
  // Show the circular loader
  showDialog(
    context: Get.context!,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
  String? title;
  String? subject;
  String? name;
  String? email;
  String? phoneNumber;
  try{
    final response = await http.get(
      Uri.parse('$baseUrl/book/return/lookup?isbn=$isbn'),
      headers: headers,
    );
    var jsonResponse = jsonDecode(response.body);
    String status = jsonResponse['status'];
    subject = jsonResponse['subject'];
    title = jsonResponse['title'];
    name = jsonResponse['returnedBy'];
    email = jsonResponse['email'];
    phoneNumber = jsonResponse['phoneNum'];
    if(status == "valid")
    {
      Navigator.of(Get.context!).pop();
      return '$subject+$title+$name+$email+$phoneNumber';
    }
    else
    {
      Navigator.of(Get.context!).pop();
      return "not found";
    }
  }

  catch (e)
  {
    SnackBar(content: Text("the error $e"));
    Navigator.of(Get.context!).pop();
    notOnlineMessage(Get.context!).show();
  }
  return null;
}

/// find by ISBN for Book Look-up
Future<void> bookLookUpByISBN(String isbn, BuildContext context) async {
  // Show the circular loader
  showDialog(
    context: Get.context!,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
  String? title;
  String? subject;
  String? publisher;
  String? published;
  String? copies;

  try{
    final response = await http.get(
      Uri.parse('$baseUrl/find/book/details?isbn=$isbn'),
      headers: headers,
    );
    var jsonResponse = jsonDecode(response.body);
    String status = jsonResponse['status'];
    subject = jsonResponse['subject'];
    title = jsonResponse['title'];
    publisher = jsonResponse['publisher'];
    published = jsonResponse['published'];
    copies = jsonResponse['qty'];
    if(status == "valid")
    {
      Navigator.of(Get.context!).pop();
      bookDetailsPop(Get.context!,title,subject,publisher,published,copies,isbn).show();
    }
    else
    {
      Navigator.of(Get.context!).pop();
      bookDetailsPop(Get.context!,"not Found","not Found","not Found","not Found","not Found",isbn).show();
    }
  }

  catch (e)
  {
    SnackBar(content: Text("the error $e"));
    Navigator.of(Get.context!).pop();
    notOnlineMessage(Get.context!).show();
  }
  return;
}

/// add New book
Future<void> addNewBook(String bookSubject,String isbn, String bookTitle,String  bookPublisher, String bookPublished,String  bookQty) async {
  // Show the circular loader
  showDialog(
    context: Get.context!,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
  try{
    final res = await http.post(
      Uri.parse('$baseUrl/books/add'),
      headers: headers,
      body: json.encode({
        'isbn': isbn,
        'subject': bookSubject,
        'title': bookTitle,
        'publisher': bookPublisher,
        'published': bookPublished,
        'qty': bookQty
      }),
    );
    var jsonResponse = jsonDecode(res.body);
    String? status = jsonResponse['status'];
    String? upload = jsonResponse['upload'];

    if(upload == "exists")
    {
      Navigator.of(Get.context!).pop();
      popUpBookAlreadyExistScreen(Get.context!).show();
    }
    else{
      // Show success screen
      Navigator.of(Get.context!).pop();
      await flutterLocalNotificationsPlugin.show(
        6, // Notification ID
        "Your all set 😃",
        ' $bookTitle has been added successfully to the library',
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'library_channel',
            'Library Notifications',
            channelDescription: 'Notifications related to book encouragement',
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
      );
      newBookSuccessScreen(Get.context!).show();
    }
  }
  catch (e)
  {
    Navigator.of(Get.context!).pop();
    notOnlineMessage(Get.context!).show();
  }
}

/// add borrowed to sheet
Future<void> addBorrowedRow(String isbn, String subject, String bookTitle, String borrowedBy, String email, String id, String phoneNumber ,String pickDate, BuildContext context,String returnDate) async {
  // Show the circular loader
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
  try{
    final res = await http.post(
      Uri.parse('$baseUrl/books/borrow'),
      headers: headers,
      body: json.encode({
        'isbn': isbn,
        'subject': subject,
        'title': bookTitle,
        'borrowedBy': borrowedBy,
        'email': email,
        'id': id,
        'phoneNumber': phoneNumber,
        'pickDate': pickDate,
        'returnDate': returnDate
      }),
    );
    var jsonResponse = jsonDecode(res.body);
    String? status = jsonResponse['status'];

    if(status == 'already-borrowed')
    {
      Navigator.of(Get.context!).pop();
      ruleOfOneMessage(Get.context!).show();
    }
    else
    {
        ///Add to cache
        Borrowed borrowed = Borrowed(isbn: isbn, subject: subject, title: bookTitle, borrowedBy: borrowedBy, email: email, id: id, phoneNumber: phoneNumber, pickDate: pickDate, returnDate: returnDate);
        borrowedBox.put(id, borrowed);

        // Show success screen
        Navigator.of(Get.context!).pop();
        await flutterLocalNotificationsPlugin.show(
          6, // Notification ID
          "Your all set 😃",
          'Enjoy reading ${borrowed.title}!',
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'library_channel',
              'Library Notifications',
              channelDescription: 'Notifications related to book encouragement',
              importance: Importance.high,
              priority: Priority.high,
            ),
          ),
        );
        popUpSuccessScreen(Get.context!).show();
    }
  }
  catch (e)
  {
    Navigator.of(Get.context!).pop();
    notOnlineMessage(Get.context!).show();
  }
}

/// add to return pending sheet
Future<void> addReturnPendingRow(String isbn, String subject, String bookTitle, String returnedBy, String email, String id, String phoneNumber, String pickDate, BuildContext context) async {
  // Show the circular loader
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );

  try {
    final res = await http.post(
      Uri.parse('$baseUrl/return/pending'),
      headers: headers,
      body: json.encode({
        'isbn': isbn,
        'subject': subject,
        'title': bookTitle,
        'returnedBy': returnedBy,
        'email': email,
        'id': id,
        'phoneNumber': phoneNumber,
        'pickDate': pickDate,
      }),
    );
    var jsonResponse = jsonDecode(res.body);
    String status = jsonResponse['status'];
    if(status == "pending-returned")
    {
        borrowedBox.delete(id);
        /// Close the loader and show success dialog
        Navigator.of(Get.context!).pop();
        await flutterLocalNotificationsPlugin.show(
          7, // Notification ID
          'Return Filed!',
          'Your return request has been filed successfully',
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'library_channel',
              'Library Notifications',
              channelDescription: 'Notifications related to book encouragement',
              importance: Importance.high,
              priority: Priority.high,
            ),
          ),
        );

        returnSuccessScreen(Get.context!).show();
      }
    else
      {
        Navigator.of(Get.context!).pop();
        popUpBookNotFoundScreen(Get.context!).show();
      }

  } catch (e) {
    // Close the loader and show error message
    Navigator.of(Get.context!).pop();
    notOnlineMessage(Get.context!).show();
  }
}

/// add to return confirm sheet
Future<void> addReturnConfirmRow(String isbn, String subject, String bookTitle, String returnedBy, String email, String id, String phoneNumber, String pickDate, BuildContext context) async {

  // Show the circular loader
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );

  try {
    String receiverName = "${person.first.firstName} ${person.first.lastName}";
    String receiverEmail = person.first.email;
    final res = await http.post(
      Uri.parse('$baseUrl/return/confirm'),
      headers: headers,
      body: json.encode({
        'isbn': isbn,
        'subject': subject,
        'title': bookTitle,
        'returnedBy': returnedBy,
        'email': email,
        'id': id,
        'phoneNumber': phoneNumber,
        'pickDate': pickDate,
        'receiverName': receiverName,
        'receiverEmail':receiverEmail
      }),
    );
    var jsonResponse = jsonDecode(res.body);
    String status = jsonResponse['status'];
    if(status == "confirmed-return")
      {
        /// Close the loader and show success dialog
        Navigator.of(Get.context!).pop();
        returnConfirmSuccessScreen(Get.context!).show();
      }
  } catch (e) {
    // Close the loader and show error message
    Navigator.of(Get.context!).pop();
    notOnlineMessage(Get.context!).show();
  }
}

/// login
Future<void> login(String email, String password, String unEncrypted,BuildContext context) async {
    // Show the circular loader
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
  try{
    final res = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: headers,
      body: json.encode({
        'email': email,
        'password': password,
        'unEncrypted': unEncrypted,
      }),
    );
    var jsonResponse = jsonDecode(res.body);
    String status = jsonResponse['status'];
    if(status == "valid")
    {
      String fname = jsonResponse['firstName'];
      String lname = jsonResponse['lastName'];
      String natid = jsonResponse['id'];
      String phNum = jsonResponse['phone'];
      String role = jsonResponse['role'];
      if(role == "user")
        {
          /// add user to hive cache
          User user = User(firstName: fname, lastName: lname, email: email, id: natid, phoneNumber: phNum, password: password);
          userBox.put(natid, user);

          /// add books to library
          final response = await http.get(
            Uri.parse('$baseUrl/library/sync'),
            headers: headers,
          );
          print("the responsebody ==== ${response.body}");
          final List<dynamic> data = json.decode(response.body);
          print("the data ==== $data");


          for(var item in data)
            {
              final book = Book.fromJson(item);
              await booksBox.put(book.isbn, book);
            }
          print("library added");

          /// add borrowed if available
          final borrowedRes = await http.get(
            Uri.parse('$baseUrl/login/find/borrowed?email=$email'),
            headers: headers,
          );
          var jsonBorrowResponse = jsonDecode(borrowedRes.body);
          String status = jsonBorrowResponse['status'];
          if(status == "valid")
            {
              print("added borrowed books .... or not");
              String isbn = jsonBorrowResponse['isbn'];
              String title = jsonBorrowResponse['title'];
              String subject = jsonBorrowResponse['subject'];
              String email = jsonBorrowResponse['email'];
              String id = jsonBorrowResponse['id'];
              String phoneNumber = jsonBorrowResponse['phoneNumber'];
              String borrowedBy = jsonBorrowResponse['borrowedBy'];
              String pickDate = jsonBorrowResponse['pickDate'];
              String returnDate = jsonBorrowResponse['returnDate'];

              ///Add to cache
              Borrowed borrowed = Borrowed(isbn: isbn, subject: subject, title: title, borrowedBy: borrowedBy, email: email, id: id, phoneNumber: phoneNumber, pickDate: pickDate, returnDate: returnDate);
              borrowedBox.put(id, borrowed);
            }

          print("added borrowed books .... or not");

       // Close the loader and navigate to user Main Screen
          Navigator.of(Get.context!).pop();
      Navigator.pushAndRemoveUntil(
        Get.context!,
        MaterialPageRoute(builder: (context) => const NavigationMenu()),
            (route) => false, // Removes all previous routes
      );
        }
      else
        {
          User user = User(firstName: fname, lastName: lname, email: email, id: natid, phoneNumber: phNum, password: password);
          userBox.put(natid, user);
          Navigator.of(Get.context!).pop(); // Close the loader
          Navigator.pushAndRemoveUntil(
            Get.context!,
            MaterialPageRoute(builder: (context) => const ManagerMenu()),
                (route) => false, // Removes all previous routes
          );
        }
    }
    else
    {
      Navigator.of(Get.context!).pop(); // Close the loader
      wrongCredentials(Get.context!).show();
    }
  }
  catch (e)
  {
    Navigator.of(Get.context!).pop();
    print("the e == $e");
    ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text("the error $e")));
    notOnlineMessage(Get.context!).show();
  }
}

/// Add new user
Future<void> addNewuser(String fName, String lName, String email, String id, String phoneNumber, String password, BuildContext context) async {
  // Show the circular loader
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );

  try {
    final res = await http.post(
      Uri.parse('$baseUrl/users/register'),
      headers: headers,
      body: json.encode({
        'firstName':fName,
        'lastName':lName,
        'email': email,
        'id':id,
        'phoneNumber':phoneNumber,
        'password': password,
      }),
    );
    var jsonResponse = jsonDecode(res.body);
    String status = jsonResponse['status'];
    /// verify for existing accounts by ID
      if (status == "exists") {
        String name = "$fName $lName";
        Navigator.of(Get.context!).pop();
        //Navigate to recoverScreen and close all previous routes
        Navigator.pushAndRemoveUntil(
          Get.context!,
          MaterialPageRoute(builder: (context) =>  RecoverScreen(name: name,email: email,id: id)),
              (route) => false,
        );
        return;
      }
      else{
        /// Add to cache
        User user = User(firstName: fName, lastName: lName, email: email, id: id, phoneNumber: phoneNumber, password: password);
        userBox.put(id, user);

        /// add books to library
        // final response = await http.get(
        //   Uri.parse('$baseUrl/library/sync'),
        //   headers: headers,
        // );
        // final List<dynamic> data = json.decode(response.body);
        //
        // for(var item in data)
        // {
        //   final book = Book.fromJson(item);
        //   await booksBox.put(book.isbn, book);
        // }

        Navigator.of(Get.context!).pop(); // Close the loader
        // Navigate to SuccessScreen and close all previous routes
        Navigator.pushAndRemoveUntil(
          Get.context!,
          MaterialPageRoute(builder: (context) => const SuccessScreen()),
              (route) => false,
        );
      }

  } catch (e)
  {
    Navigator.of(Get.context!).pop(); // Close the loader
    notOnlineMessage(Get.context!).show();
  }
}

/// Update Library
Future<void> updateLibrary(BuildContext context) async {
  // Show the circular loader
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );

  try {
    /// delete old books first
    booksBox.clear();
    /// add books to library
    final response = await http.get(
      Uri.parse('$baseUrl/library/sync'),
      headers: headers,
    );
    final List<dynamic> data = json.decode(response.body);

    for(var item in data)
    {
      final book = Book.fromJson(item);
      await booksBox.put(book.isbn, book);
    }

    Navigator.of(Get.context!).pop(); // Close the loader
    libraryUpdated(Get.context!).show();
    await flutterLocalNotificationsPlugin.show(
      9, // Notification ID
      'Library updated successfully!',
      'Dear ${person.first.lastName}, Your library has been updated Successfully!',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'library_channel',
          'Library Notifications',
          channelDescription: 'Notifications related to book encouragement',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );

  } catch (e)
  {
    Navigator.of(Get.context!).pop(); // Close the loader
    notOnlineMessage(Get.context!).show();
  }
}

/// recoverAccount
Future<void> recoverAccount(BuildContext context, String id) async {
  // Show the circular loader
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );

  try {
    final response = await http.get(
      Uri.parse('$baseUrl/find/book?isbn=$id'),
      headers: headers,
    );
    var jsonResponse = jsonDecode(response.body);
    String status = jsonResponse['status'];
    String firstName = jsonResponse['firstName'];
    String lastName = jsonResponse['lastName'];
    String password = jsonResponse['password'];
    String phone = jsonResponse['phone'];
    String email = jsonResponse['email'];
    String userId = jsonResponse['id'];
    String fName ='',lName='';

    /// Add user to realm db
    User user = User(firstName: firstName, lastName: lastName, email: email, id: userId, phoneNumber: phone, password: password);
    userBox.put(id, user);


    /// add borrowed if available
    final borrowedRes = await http.get(
      Uri.parse('$baseUrl/login/find/borrowed'),
      headers: headers,
    );
    var jsonBorrowResponse = jsonDecode(borrowedRes.body);
    String borrowStatus = jsonBorrowResponse['status'];
    if(borrowStatus == "valid")
    {
      String isbn = jsonBorrowResponse['isbn'];
      String title = jsonBorrowResponse['title'];
      String subject = jsonBorrowResponse['subject'];
      String email = jsonBorrowResponse['email'];
      String id = jsonBorrowResponse['id'];
      String phoneNumber = jsonBorrowResponse['phoneNumber'];
      String borrowedBy = jsonBorrowResponse['borrowedBy'];
      String pickDate = jsonBorrowResponse['pickDate'];
      String returnDate = jsonBorrowResponse['returnDate'];

      ///Add to cache
      Borrowed borrowed = Borrowed(isbn: isbn, subject: subject, title: title, borrowedBy: borrowedBy, email: email, id: id, phoneNumber: phoneNumber, pickDate: pickDate, returnDate: returnDate);
      borrowedBox.put(id, borrowed);
    }

    /// add books to library
    final res = await http.get(
      Uri.parse('$baseUrl/library/sync'),
      headers: headers,
    );
    final List<dynamic> data = json.decode(res.body);

    for(var item in data)
    {
      final book = Book.fromJson(item);
      await booksBox.put(book.isbn, book);
    }


    Navigator.of(Get.context!).pop(); // Close the loader
    accountRestore(Get.context!, "$fName $lName").show();

    await flutterLocalNotificationsPlugin.show(
      20, // Notification ID
      'Your account has been restored successfully',
      'Dear $lName, Your account has been recovered Successfully!',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'library_channel',
          'Library Notifications',
          channelDescription: 'Notifications related to book encouragement',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );

    // Navigate to SuccessScreen and close all previous routes
    Navigator.pushAndRemoveUntil(
      Get.context!,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
    );

  } catch (e)
  {
    Navigator.of(Get.context!).pop(); // Close the loader
    notOnlineMessage(Get.context!).show();
  }
}

/// update new password (here)
Future<void> updatePassword(String password, String natId, BuildContext context) async {
  // Show the circular loader
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );

  try {
    final response = await http.post(
      Uri.parse('$baseUrl/users/update-password'),
      headers: headers,
      body: json.encode({
        'id':natId,
        'password': password,
      }),
    );
    var jsonResponse = jsonDecode(response.body);
    String status = jsonResponse['status'];
    if (status == "not-found") {
      Navigator.of(Get.context!).pop();
      idNoMatch(Get.context!, natId).show();
      // throw Exception('No matching row found for natId: $natId');
    }
    else
      {
        Navigator.of(Get.context!).pop(); // Close the loader
        // Navigate to SuccessScreen and close all previous routes
        Navigator.pushAndRemoveUntil(
          Get.context!,
          MaterialPageRoute(builder: (context) => const PasswordRestScreen()),
              (route) => false,
        );


        await flutterLocalNotificationsPlugin.show(
          10, // Notification ID
          'Password Reset successfully!',
          'Dear User, Your Password has been reset Successfully!',
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'library_channel',
              'Library Notifications',
              channelDescription: 'Notifications related to book encouragement',
              importance: Importance.high,
              priority: Priority.high,
            ),
          ),
        );
      }


  } catch (e) {
    print("error e  == $e");
    Navigator.of(Get.context!).pop(); // Close the loader
    notOnlineMessage(Get.context!).show();
  }
}

void openGoogleSearch(String query, BuildContext context) async {
  final url = Uri.parse('https://www.google.com/search?q=$query');
  try {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      // Fallback to opening browser directly
      await launch('https://www.google.com/search?q=$query');
    }
  } catch (e) {
    notOnlineMessage(Get.context!).show();
    throw 'Could not launch $url';
  }
}

AwesomeDialog idNoMatch(BuildContext context, String natId) {
  return AwesomeDialog(
      context: context,
      width: 500,
      headerAnimationLoop: false,
      dialogType: DialogType.noHeader,
      title: TTexts.idNoMatch,
      desc: "${TTexts.idNoMatchSub}$natId",
      btnOkColor: Colors.redAccent,
      btnOkText: TTexts.close,
      btnOkOnPress: () => {},
    );
}

AwesomeDialog googleSheetNotUpdated(BuildContext context) {
  return AwesomeDialog(
          context: context,
          width: 500,
          headerAnimationLoop: false,
          dialogType: DialogType.noHeader,
          title: TTexts.googleSheetNotUpdated,
          desc: TTexts.googleSheetNotUpdatedSub,
          btnOkColor: Colors.redAccent,
          btnOkText: TTexts.close,
          btnOkOnPress: () => {},
        );
}

AwesomeDialog wrongCredentials(BuildContext context) {
  return AwesomeDialog(
    context: context,
    width: 500,
    headerAnimationLoop: false,
    dialogType: DialogType.noHeader,
    title: TTexts.wrongCredentials,
    desc: TTexts.wrongCredentialsSub,
    btnOkColor: Colors.redAccent,
    btnOkText: TTexts.close,
    btnOkOnPress: () => {},
  );
}

AwesomeDialog popUpBookNotFoundScreen(BuildContext context) {
  return AwesomeDialog(
    context: context,
    width: 500,
    headerAnimationLoop: false,
    dialogType: DialogType.noHeader,
    title: TTexts.bookNotFound,
    desc: TTexts.bookNotFoundMessage,
    btnOkColor: Colors.redAccent,
    btnOkText: TTexts.close,
    btnOkOnPress: () => {},
  );
}

AwesomeDialog popUpBookAlreadyExistScreen(BuildContext context) {
  return AwesomeDialog(
    context: context,
    width: 500,
    headerAnimationLoop: false,
    dialogType: DialogType.noHeader,
    title: 'Already in the library 🤷',
    desc: "This book already Exists in the library!",
    btnOkColor: Colors.redAccent,
    btnOkText: TTexts.close,
    btnOkOnPress: () => {},
  );
}

AwesomeDialog popUpSuccessScreen(BuildContext context) {
    return AwesomeDialog(
      context: context,
      width: 500,
      headerAnimationLoop: false,
      dialogType: DialogType.noHeader,
      title: TTexts.complete,
      desc: TTexts.completeMessage,
      btnOkColor: Colors.green,
      btnOkText: TTexts.done,
      btnOkOnPress: () => {},
    );
}

AwesomeDialog newBookSuccessScreen(BuildContext context) {
  return AwesomeDialog(
    context: context,
    width: 500,
    headerAnimationLoop: false,
    dialogType: DialogType.noHeader,
    title: "New book added! 📚",
    desc: "A new book has been added to the library",
    btnOkColor: Colors.green,
    btnOkText: TTexts.done,
    btnOkOnPress: () => {},
  );
}

AwesomeDialog errorWhileLoadingLibrary(BuildContext context) {
  return AwesomeDialog(
    context: context,
    width: 500,
    headerAnimationLoop: false,
    dialogType: DialogType.noHeader,
    title: TTexts.loadLibraryError,
    desc: TTexts.loadLibraryErrorSub,
    btnOkColor: Colors.redAccent,
    btnOkText: TTexts.close,
    btnOkOnPress: () => {},
  );
}

AwesomeDialog notOnlineMessage(BuildContext context) {
  return AwesomeDialog(
      context: context,
      width: 500,
      headerAnimationLoop: false,
      dialogType: DialogType.noHeader,
      title: TTexts.notOnline,
      desc: TTexts.notOnlineSub,
      btnOkColor: Colors.redAccent,
      btnOkText: TTexts.close,
      btnOkOnPress: () => {},
    );
}

AwesomeDialog ruleOfOneMessage(BuildContext context) {
  return AwesomeDialog(
    context: context,
    width: 500,
    headerAnimationLoop: false,
    dialogType: DialogType.noHeader,
    title: TTexts.ruleOfOne,
    desc: TTexts.ruleOfOneSub,
    btnOkColor: Colors.redAccent,
    btnOkText: TTexts.close,
    btnOkOnPress: () => {},
  );
}

AwesomeDialog libraryUpdated(BuildContext context) {
  return AwesomeDialog(
    context: context,
    width: 500,
    headerAnimationLoop: false,
    dialogType: DialogType.noHeader,
    title: TTexts.libraryUpdate,
    desc: TTexts.libraryUpdateSub,
    btnOkColor: Colors.green,
    btnOkText: TTexts.done,
    btnOkOnPress: () => {},
  );
}

AwesomeDialog accountRestore(BuildContext context, String name) {
  return AwesomeDialog(
    context: context,
    width: 500,
    headerAnimationLoop: false,
    dialogType: DialogType.noHeader,
    title: 'Account restored 😎',
    desc: "Welcome back $name",
    btnOkColor: Colors.green,
    btnOkText: TTexts.done,
    btnOkOnPress: () => {},
  );
}

AwesomeDialog returnSuccessScreen(BuildContext context) {
  return AwesomeDialog(

    context: context,
    width: 500,
    headerAnimationLoop: false,
    dialogType: DialogType.noHeader,
    title: TTexts.Filled,
    desc: TTexts.FilledMessage2,
    btnOkColor: Colors.green,
    btnOkText: TTexts.done,
    btnOkOnPress: () => {},
  );
}

AwesomeDialog returnConfirmSuccessScreen(BuildContext context) {
  return AwesomeDialog(

    context: context,
    width: 500,
    headerAnimationLoop: false,
    dialogType: DialogType.noHeader,
    title: "Return confirmed 🤝🏻",
    desc: "The return request has been filed successfully!",
    btnOkColor: Colors.green,
    btnOkText: TTexts.done,
    btnOkOnPress: () => {},
  );
}

AwesomeDialog bookDetailsPop(BuildContext context,title,subject,publisher,published,copies,isbn) {
  return AwesomeDialog(
    context: context,
    width: 500,
    headerAnimationLoop: false,
    dialogType: DialogType.noHeader,
    title: title,
    desc: ('Subject: $subject \n Publisher: $publisher \n Published: $published \n Available copies: $copies'),
    btnOkColor: TColors.primary,
    btnOkText: "Search Online",
    buttonsTextStyle: const TextStyle(color: TColors.white),
    btnOkOnPress: () => {openGoogleSearch(isbn,context)},
  );
}
