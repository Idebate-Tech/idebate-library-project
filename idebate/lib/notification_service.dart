import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
// import 'package:realm/realm.dart';
// import 'features/activities/models/realm_local_storage.dart';
import 'package:timezone/timezone.dart' as tz;

import 'features/activities/models/hive_cache_model_file.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

final booksBox = Hive.box<Book>('booksBox');
final userBox = Hive.box<User>('userBox');
final borrowedBox = Hive.box<Borrowed>('borrowedBox');
final pendingReturnBox = Hive.box<PendingReturn>('pendingReturnBox');

// final config = Configuration.local([Book.schema, Profile.schema]);
// final realm = Realm(config);

Future<void> checkAndScheduleNotifications() async {
  print('checkAndScheduleNotifications started');

  final now = DateTime.now();
  // final books = realm.all<Book>();
  // final person = realm.all<Profile>();

  final person = userBox.values;
  final books = borrowedBox.values;

  // If person is empty, show a one-time immediate notification
  if (person.isEmpty) {
    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      'Hi there 😃!',
      "Welcome to the iDebate library App! Let's get you signed up.",
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'library_channel', // Unique channel ID
          'Library Notifications', // Channel name
          channelDescription: 'Notifications related to user setup and book returns',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
    print('Generic notification sent for first-time user.');
    return;
  }

  // If no books are available, send a generic notification
  if (books.isEmpty) {
    await flutterLocalNotificationsPlugin.show(
      1, // Notification ID
      'Hi there! 🤗',
      'Today is a nice day to read a book!',
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
    print('Generic notification sent for no books.');
    return;
  }
  else
    {
      final returnDate = DateFormat('dd-MM-yyyy').parse(books.first.returnDate);
      final int difference = returnDate.difference(now).inDays;
      String? title;
      String? body;
      if (difference == 3) {
        title = 'Three days to go!';
        body = 'Only three days to go before your return date: $returnDate.';
      } else if (difference == 2) {
        title = 'Two days to go!';
        body = 'Only two days to go before your return date: $returnDate.';
      } else if (difference == 1) {
        title = 'One day to go!';
        body = 'Tomorrow is your return date: $returnDate.';
      } else if (difference == 0) {
        title = 'Today is your return date!';
        body = 'Please ensure you return the book "${books.first.title}" today.';
      } else if (difference < 0) {
        title = 'You missed your return date 😱!';
        body = 'Please schedule a time to return the book "${books.first.title}".';
      }
        await flutterLocalNotificationsPlugin.show(
          1, // Notification ID
          title,
          body,
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
        print('Generic notification sent for no books.');
        return;
    }

  // // Schedule notifications for each book
  // for (final book in books) {
  //   final returnDate = DateFormat('dd-MM-yyyy').parse(book.returnDate);
  //   final int difference = returnDate.difference(now).inDays;
  //
  //   String? title;
  //   String? body;
  //
  //   if (difference == 3) {
  //     title = 'Three days to go!';
  //     body = 'Only three days to go before your return date: $returnDate.';
  //   } else if (difference == 2) {
  //     title = 'Two days to go!';
  //     body = 'Only two days to go before your return date: $returnDate.';
  //   } else if (difference == 1) {
  //     title = 'One day to go!';
  //     body = 'Tomorrow is your return date: $returnDate.';
  //   } else if (difference == 0) {
  //     title = 'Today is your return date!';
  //     body = 'Please ensure you return the book "${book.title}" today.';
  //   } else if (difference < 0) {
  //     title = 'You missed your return date 😱!';
  //     body = 'Please schedule a time to return the book "${book.title}".';
  //   }
  //
  //   if (title != null && body != null) {
  //     // Schedule notifications at 9 AM and 4 PM
  //     final tz.TZDateTime scheduledTime9AM = tz.TZDateTime.local(
  //       returnDate.year,
  //       returnDate.month,
  //       returnDate.day,
  //       9, // 9 AM
  //     );
  //     final tz.TZDateTime scheduledTime4PM = tz.TZDateTime.local(
  //       returnDate.year,
  //       returnDate.month,
  //       returnDate.day,
  //       16, // 4 PM
  //     );
  //
  //     await flutterLocalNotificationsPlugin.zonedSchedule(
  //       book.hashCode, // Unique ID for 9 AM notification
  //       title,
  //       body,
  //       scheduledTime9AM,
  //       const NotificationDetails(
  //         android: AndroidNotificationDetails(
  //           'library_channel',
  //           'Library Notifications',
  //           channelDescription: 'Notifications related to book returns',
  //           importance: Importance.high,
  //           priority: Priority.high,
  //         ),
  //       ),
  //       uiLocalNotificationDateInterpretation:
  //       UILocalNotificationDateInterpretation.absoluteTime,
  //       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //     );
  //
  //     await flutterLocalNotificationsPlugin.zonedSchedule(
  //       book.hashCode + 1, // Unique ID for 4 PM notification
  //       title,
  //       body,
  //       scheduledTime4PM,
  //       const NotificationDetails(
  //         android: AndroidNotificationDetails(
  //           'library_channel',
  //           'Library Notifications',
  //           channelDescription: 'Notifications related to book returns',
  //           importance: Importance.high,
  //           priority: Priority.high,
  //         ),
  //       ),
  //       uiLocalNotificationDateInterpretation:
  //       UILocalNotificationDateInterpretation.absoluteTime,
  //       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //     );
  //
  //     print(
  //         'Notifications scheduled for book "${book.title}" at 9 AM and 4 PM.');
  //   }
  // }
  //
  // print('checkAndScheduleNotifications completed.');
}