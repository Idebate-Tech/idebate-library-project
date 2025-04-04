import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:gsheets/gsheets.dart';
import 'package:idebate/common/widgets/recover_Account_screen/recover_screen.dart';
import 'package:idebate/common/widgets/success_screen/success_screen.dart';
import 'package:idebate/features/authentication/screens/login/login.dart';
import 'package:idebate/manager_menu.dart';
import 'package:idebate/navigation_menu.dart';
import 'package:idebate/utils/constants/credentials_string.dart';
import 'package:realm/realm.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/text_strings.dart';
import '../../authentication/screens/password_configuration/reset_password.dart';
import '../models/realm_local_storage.dart';
import 'package:url_launcher/url_launcher.dart';

var config = Configuration.local([Book.schema,Profile.schema,Library.schema,]);
var realm = Realm(config);
final _spreadsheetId = TTexts.spreadsheetId ;
final person = realm.all<Profile>();
final book = realm.all<Book>();

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

/// find by ISBN
Future<String?> findBookByISBN(String isbn, BuildContext context) async {
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
    final jsonString = await rootBundle.loadString(TCredentials.myCredentials);
    final credentials = json.decode(jsonString) as Map<String, dynamic> ;
    final gsheets = GSheets(credentials);
    final spreadsheet = await gsheets.spreadsheet(_spreadsheetId);
    final booksSheet = spreadsheet.worksheetByTitle('books');
    String? name;
    String? email;
    String? phoneNumber;
    String? title;
    String? subject;


    if (booksSheet == null) {
      Navigator.of(Get.context!).pop();
      notOnlineMessage(Get.context!).show();
      throw Exception('Books sheet not found');
    }

    /// Search for ISBN in the first column (column 1)
    final allRows = await booksSheet.values.allRows();
    for (final row in allRows) {
      if (row.isNotEmpty && row[1] == isbn) {
        title = row[2];
        subject = row[0];
        Navigator.of(Get.context!).pop();
        return '$title+$subject';
      }
    }

    /// Book not found error message
    Navigator.of(Get.context!).pop();
    popUpBookNotFoundScreen(Get.context!).show();
    return 'not found'; // ISBN not found
  }
  catch (e)
  {
    Navigator.of(Get.context!).pop();
    notOnlineMessage(Get.context!).show();
  }

  return null;
}

/// find by ISBN For Return LookUp
Future<String?> findBookReturnLookUp(String isbn, BuildContext context) async {
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
    final jsonString = await rootBundle.loadString(TCredentials.myCredentials);
    final credentials = json.decode(jsonString) as Map<String, dynamic> ;
    final gsheets = GSheets(credentials);
    final spreadsheet = await gsheets.spreadsheet(_spreadsheetId);
    final booksSheet = spreadsheet.worksheetByTitle('pending returns');
    String? title;
    String? subject;
    String? name;
    String? email;
    String? phoneNumber;

    if (booksSheet == null) {
      Navigator.of(Get.context!).pop();
      notOnlineMessage(Get.context!).show();
      throw Exception('Books sheet not found');
    }

    /// Search for ISBN in the first column (column 1)
    final allRows = await booksSheet.values.allRows();
    for (final row in allRows) {
      if (row.isNotEmpty && row[0] == isbn) {
        subject = row[1];
        title = row[2];
        name = row[3];
        email = row[4];
        phoneNumber = row[6];
        Navigator.of(Get.context!).pop();
        return '$subject+$title+$name+$email+$phoneNumber';
      }
    }

    /// Book not found error message
    Navigator.of(Get.context!).pop();
    popUpBookNotFoundScreen(Get.context!).show();
    return 'not found'; // ISBN not found
  }
  catch (e)
  {
    Navigator.of(Get.context!).pop();
    notOnlineMessage(Get.context!).show();
  }

  return null;
}

/// find by ISBN for Book Look-up
Future<void> bookLookUpByISBN(String isbn, BuildContext context) async {
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
    final jsonString = await rootBundle.loadString(TCredentials.myCredentials);
    final credentials = json.decode(jsonString) as Map<String, dynamic> ;
    final gsheets = GSheets(credentials);
    final spreadsheet = await gsheets.spreadsheet(_spreadsheetId);
    final booksSheet = spreadsheet.worksheetByTitle('books');
    String? title;
    String? subject;
    String? publisher;
    String? published;
    String? copies;
    if (booksSheet == null) {
      Navigator.of(Get.context!).pop();
      notOnlineMessage(Get.context!).show();
      throw Exception('Books sheet not found');
    }
    print("the isbn === $isbn");
    /// Search for ISBN in the first column (column 1)
    final allRows = await booksSheet.values.allRows();
    for (final row in allRows) {
      if (row.isNotEmpty && row[1] == isbn) {
        title = row[2];
        subject = row[0];
        publisher = row[3];
        published = row[4];
        copies = row[5];

        Navigator.of(Get.context!).pop();
        bookDetailsPop(Get.context!,title,subject,publisher,published,copies,isbn).show();
      }
    }

    /// Book not found error message
    Navigator.of(Get.context!).pop();
    bookDetailsPop(Get.context!,title,subject,publisher,published,copies,isbn).show();// ISBN not found
  }
  catch (e)
  {
    Navigator.of(Get.context!).pop();
    notOnlineMessage(Get.context!).show();
  }

  return null;
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
    final jsonString = await rootBundle.loadString(TCredentials.myCredentials);
    final credentials = json.decode(jsonString) as Map<String, dynamic> ;
    final gsheets = GSheets(credentials);
    final spreadsheet = await gsheets.spreadsheet(_spreadsheetId);
    final borrowedSheet = spreadsheet.worksheetByTitle('borrowed');

    if (borrowedSheet == null) {
      /// Not online error
      Navigator.of(Get.context!).pop();
      notOnlineMessage(Get.context!).show();
      throw Exception('Borrowed sheet not found');
    }

    if(book.isNotEmpty)
      {
        Navigator.of(Get.context!).pop();
        ruleOfOneMessage(Get.context!).show();
      }
    else
      {
        if(bookTitle == "not found")
        {
          Navigator.of(Get.context!).pop();
          popUpBookNotFoundScreen(Get.context!).show();
        }
        else{
          // Add to cache
          realm.write(() {
            Book book = Book(isbn,subject, bookTitle, borrowedBy, email, id, phoneNumber,returnDate);
            realm.add<Book>(book);
          });

          // Add the new row
          List<String> rowData = [isbn,subject, bookTitle, borrowedBy, email, id, phoneNumber,pickDate,returnDate];
          await borrowedSheet.values.appendRow(rowData);

          // Show success screen
          Navigator.of(Get.context!).pop();
          await flutterLocalNotificationsPlugin.show(
            6, // Notification ID
            "Your all set 😃",
            'Enjoy reading ${book.first.title}!',
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
  }
  catch (e)
  {
    Navigator.of(Get.context!).pop();
    notOnlineMessage(Get.context!).show();
  }
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
    final jsonString = await rootBundle.loadString(TCredentials.myCredentials);
    final credentials = json.decode(jsonString) as Map<String, dynamic> ;
    final gsheets = GSheets(credentials);
    final spreadsheet = await gsheets.spreadsheet(_spreadsheetId);
    final bookSheet = spreadsheet.worksheetByTitle('books');

    if (bookSheet == null) {
      /// Not online error
      Navigator.of(Get.context!).pop();
      notOnlineMessage(Get.context!).show();
      throw Exception('Books sheet not found');
    }

    String title = "";
    /// Search for ISBN in the first column (column 1)
    final allRows = await bookSheet.values.allRows();
    for (final row in allRows) {
      if (row.isNotEmpty && row[1] == isbn) {
        title = row[2];
      }
    }
      if(title != "")
      {
        Navigator.of(Get.context!).pop();
        popUpBookAlreadyExistScreen(Get.context!).show();
      }
      else{
        // Add the new row
        List<String> rowData = [bookSubject,isbn,bookTitle, bookPublisher, bookPublished, bookQty];
        await bookSheet.values.appendRow(rowData);

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
    final jsonString = await rootBundle.loadString(TCredentials.myCredentials);
    final credentials = json.decode(jsonString) as Map<String, dynamic>;
    final gsheets = GSheets(credentials);
    final spreadsheet = await gsheets.spreadsheet(_spreadsheetId);
    final returnSheet = spreadsheet.worksheetByTitle('pending returns');
    final borrowedSheet = spreadsheet.worksheetByTitle('borrowed');

    if (returnSheet == null) {
      throw Exception('Borrowed sheet not found');
    }

    // Remove book from cache
    realm.write(() {
      realm.deleteAll<Book>();
    });

    // Add the new row
    List<String> rowData = [isbn, subject, bookTitle, returnedBy, email, id, phoneNumber, pickDate];
    await returnSheet.values.appendRow(rowData);
    /// remove book from borrowed sheet

    if (borrowedSheet != null) {
      final borrowRows = await borrowedSheet.values.allRows();
      if (borrowRows.isNotEmpty) {
        for (int i = 0; i < borrowRows.length; i++) {
          final row = borrowRows[i]; // Get the row
          if (row.isNotEmpty && row[5] == id) { // Check column 5 for match
            await borrowedSheet.deleteRow(i + 1); // Google Sheets uses 1-based index
          }
        }
      }
    }

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

  } catch (e) {
    // Close the loader and show error message
    print("in the catch statament and the error is $e");
    Navigator.of(Get.context!).pop();
    notOnlineMessage(Get.context!).show();
  }
}

/// add to return pending sheet
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
    final jsonString = await rootBundle.loadString(TCredentials.myCredentials);
    final credentials = json.decode(jsonString) as Map<String, dynamic>;
    final gsheets = GSheets(credentials);
    final spreadsheet = await gsheets.spreadsheet(_spreadsheetId);
    final returnSheet = spreadsheet.worksheetByTitle('confirmed returns');
    final returnPendingSheet = spreadsheet.worksheetByTitle('pending returns');


    if (returnSheet == null) {
      throw Exception('Borrowed sheet not found');
    }

    // Remove book from cache
    // realm.write(() {
    //   realm.deleteAll<Book>();
    // });

    String receiverName = "${person.first.firstName} ${person.first.lastName}";
    String receiverEmail = person.first.email;
    // Add the new row
    List<String> rowData = [isbn, subject, bookTitle, returnedBy, email, id, phoneNumber, pickDate,receiverName,receiverEmail];
    await returnSheet.values.appendRow(rowData);
    /// remove book from borrowed sheet
    if (returnPendingSheet != null) {
      final borrowRows = await returnPendingSheet.values.allRows();
      if (borrowRows.isNotEmpty) {
        for (int i = 0; i < borrowRows.length; i++) {
          final row = borrowRows[i]; // Get the row
          if (row.isNotEmpty && row[5] == id) { // Check column 5 for match
            await returnPendingSheet.deleteRow(i + 1); // Google Sheets uses 1-based index
          }
        }
      }
    }

    /// Close the loader and show success dialog
   Navigator.of(Get.context!).pop();
    await flutterLocalNotificationsPlugin.show(
      7, // Notification ID
      'Return confirmed!',
      'The return request has been confirmed successfully',
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
    returnConfirmSuccessScreen(Get.context!).show();

  } catch (e) {
    // Close the loader and show error message
    Navigator.of(Get.context!).pop();
    notOnlineMessage(Get.context!).show();
  }
}

/// Login
Future<void> login(String email, String password,String unEncrypted, BuildContext context) async {
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
    final jsonString = await rootBundle.loadString(TCredentials.myCredentials);
    final credentials = json.decode(jsonString) as Map<String, dynamic>;
    final gsheets = GSheets(credentials);
    final spreadsheet = await gsheets.spreadsheet(_spreadsheetId);
    final userSheet = spreadsheet.worksheetByTitle('Librarians');
    String capPass ="";
    if(email == person.first.email && password == person.first.password)
    {
      Navigator.of(Get.context!).pop(); // Close the loader
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const NavigationMenu()),
            (route) => false, // Removes all previous routes
      );
    }
    else if(email.contains("admin"))
    {
      print("we are here");
      if (userSheet != null) {
        final userRows = await userSheet.values.allRows();
        if (userRows.isNotEmpty) {
            for (final row in userRows) { // Skip the header row
              if (row.isNotEmpty && row[3] == email) { // Ensure the row has enough columns
                capPass = row[6];
              }
            }
        }
      }
      if(capPass == unEncrypted)
        {
          Navigator.of(Get.context!).pop(); // Close the loader
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const ManagerMenu()),
                (route) => false, // Removes all previous routes
          );
        }
      else
        {
          Navigator.of(Get.context!).pop(); // Close the loader
          wrongCredentials(Get.context!).show();
        }
    }
  }
  catch (e)
  {
    Navigator.of(Get.context!).pop();
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
    final jsonString = await rootBundle.loadString(TCredentials.myCredentials);
    final credentials = json.decode(jsonString) as Map<String, dynamic>;
    final gsheets = GSheets(credentials);
    final spreadsheet = await gsheets.spreadsheet(_spreadsheetId);
    final userSheet = spreadsheet.worksheetByTitle('user');
    final bookSheet = spreadsheet.worksheetByTitle('books');

    String name= "";
    String emailAddress = "";
    // bool userFound = false;
    if (userSheet == null) {
      /// Not online error
      Navigator.of(Get.context!).pop(); // Close the loader
      errorWhileLoadingLibrary(Get.context!).show();
      throw Exception('Borrowed sheet not found');
    }

    /// verify for existing accounts by ID
    final allRows = await userSheet.values.allRows();
    for (final row in allRows) {
      if (row.isNotEmpty && row[3] == id) {
        name = "${row[0]} ${row[1]}";
        emailAddress = row[2];
        Navigator.of(Get.context!).pop();
        //Navigate to recoverScreen and close all previous routes
        Navigator.pushAndRemoveUntil(
          Get.context!,
          MaterialPageRoute(builder: (context) =>  RecoverScreen(name: name,email: emailAddress,id: id)),
              (route) => false,
        );
        return;
      }
    }

        /// Add the new row
        List<String> rowData = [fName, lName, email, id, phoneNumber, password];
        await userSheet.values.appendRow(rowData);

        /// Add to cache
        realm.write(() {
          Profile newUser = Profile(fName, lName, password, id, email, phoneNumber);
          realm.add<Profile>(newUser);
        });

        /// For loop that adds all the books from the books sheet to realm table called Library
        if (bookSheet != null) {
          final bookRows = await bookSheet.values.allRows();
          if (bookRows.isNotEmpty) {
            realm.write(() {
              for (var row in bookRows.skip(1)) { // Skip the header row
                if (row.length >= 5) { // Ensure the row has enough columns
                  Library book = Library(row[0],row[1],row[2],row[3],row[4]);
                  realm.add<Library>(book);
                }
              }
            });
          }
        }
        Navigator.of(Get.context!).pop(); // Close the loader

        await flutterLocalNotificationsPlugin.show(
          8, // Notification ID
          'Welcome ${person.first.lastName} 🥳!',
          'Your user has been created Successfully!',
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
          MaterialPageRoute(builder: (context) => const SuccessScreen()),
              (route) => false,
        );

  } catch (e)
  {
    Navigator.of(Get.context!).pop();
    print("The error ++ $e");// Close the loader
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
    final jsonString = await rootBundle.loadString(TCredentials.myCredentials);
    final credentials = json.decode(jsonString) as Map<String, dynamic>;
    final gsheets = GSheets(credentials);
    final spreadsheet = await gsheets.spreadsheet(_spreadsheetId);
    final borrowedSheet = spreadsheet.worksheetByTitle('user');
    final bookSheet = spreadsheet.worksheetByTitle('books');

    if (borrowedSheet == null) {
      /// Not online error
      Navigator.of(Get.context!).pop(); // Close the loader
      errorWhileLoadingLibrary(Get.context!).show();
      throw Exception('Borrowed sheet not found');
    }

    // delete old books first
    realm.write(() {
      realm.deleteAll<Library>();
    });

    /// For loop that adds all the books from the books sheet to realm table called Library
    if (bookSheet != null) {
      final bookRows = await bookSheet.values.allRows();
      if (bookRows.isNotEmpty) {
        realm.write(() {
          for (var row in bookRows.skip(1)) { // Skip the header row
            if (row.length >= 5) { // Ensure the row has enough columns
              Library book = Library(row[0],row[1],row[2],row[3],row[4]);
              realm.add<Library>(book);
            }
          }
        });
      }
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
    final jsonString = await rootBundle.loadString(TCredentials.myCredentials);
    final credentials = json.decode(jsonString) as Map<String, dynamic>;
    final gsheets = GSheets(credentials);
    final spreadsheet = await gsheets.spreadsheet(_spreadsheetId);
    final userSheet = spreadsheet.worksheetByTitle('user');
    final bookSheet = spreadsheet.worksheetByTitle('books');
    final borrowedSheet = spreadsheet.worksheetByTitle('borrowed');

    String fName ='',lName='';

    /// Add user to realm db
    if (userSheet != null) {
      final userRows = await userSheet.values.allRows();
      if (userRows.isNotEmpty) {
        realm.write(() {
          for (final row in userRows) { // Skip the header row
            if (row.isNotEmpty && row[3] == id) { // Ensure the row has enough columns
              Profile profile = Profile(row[0],row[1],row[5],row[3],row[2],row[4]);
              fName = row[0];
              lName = row[1];
              realm.add<Profile>(profile);
            }
          }
        });
      }
    }

    /// Add borrowed to realm db
    if (borrowedSheet != null) {
      final borrowedRows = await borrowedSheet.values.allRows();
      if (borrowedRows.isNotEmpty) {
        realm.write(() {
          for (final row in borrowedRows) { // Skip the header row
            if (row.isNotEmpty && row[5] == id) { // Ensure the row has enough columns
              Book book = Book(row[0],row[1],row[2],row[3],row[4],row[5],row[6],row[8]);
              realm.add<Book>(book);
            }
          }
        });
      }
    }

    /// For loop that adds all the books from the books sheet to realm table called Library
    if (bookSheet != null) {
      final bookRows = await bookSheet.values.allRows();
      if (bookRows.isNotEmpty) {
        realm.write(() {
          for (var row in bookRows.skip(1)) { // Skip the header row
            if (row.length >= 5) { // Ensure the row has enough columns
              Library book = Library(row[0],row[1],row[2],row[3],row[4]);
              realm.add<Library>(book);
            }
          }
        });
      }
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
    Navigator.of(Get.context!).pop();
    print("error on recover == $e");// Close the loader
    notOnlineMessage(Get.context!).show();
  }
}

/// update new password
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
    // Load Google Sheets credentials
    final jsonString = await rootBundle.loadString(TCredentials.myCredentials);
    final credentials = json.decode(jsonString) as Map<String, dynamic>;
    final gsheets = GSheets(credentials);
    final spreadsheet = await gsheets.spreadsheet(_spreadsheetId);

    // Get the 'user' worksheet
    final borrowedSheet = spreadsheet.worksheetByTitle('user');
    if (borrowedSheet == null) {
      Navigator.of(Get.context!).pop(); // Close the loader
      errorWhileLoadingLibrary(Get.context!).show();
      throw Exception('User worksheet not found');
    }

    // Update row in worksheet
    final allRows = await borrowedSheet.values.allRows();
    bool rowUpdated = false;

    for (int i = 0; i < allRows.length; i++) {
      final row = allRows[i];
      if (row.isNotEmpty && row[3] == natId) { // Check the 4th column
        final success = await borrowedSheet.values.insertValue(
          password,
          column: 6, // 6th column
          row: i + 1, // Adjust for 1-based indexing
        );

        if (!success) {
          googleSheetNotUpdated(Get.context!).show();
          throw Exception('Failed to update Google Sheet row');
        }

        rowUpdated = true;
        break;
      }
    }

    if (!rowUpdated) {
      idNoMatch(Get.context!, natId).show();
      throw Exception('No matching row found for natId: $natId');
    }

    // Update Realm Profile table
    realm.write(() {
      final existingProfile = realm.all<Profile>().firstWhere(
            (profile) => profile.nationalId == natId,
        orElse: () => throw Exception('No matching Profile found in Realm'),
      );
      existingProfile.password = password;
    });

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
      'Dear ${person.first.lastName}, Your Password has been reset Successfully!',
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

  } catch (e) {
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
