import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:idebate/app.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:idebate/features/activities/models/hive_cache_model_file.dart';
import 'notification_service.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _loadingResources();

  // Request Notification Permissions
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/launcher_icon');
  const InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (response) {
      print('Notification tapped with payload: ${response.payload}');
    },
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(BookAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(BorrowedAdapter());
  Hive.registerAdapter(PendingReturnAdapter());

  await Hive.openBox<Book>('booksBox');
  await Hive.openBox<User>('userBox');
  await Hive.openBox<Borrowed>('borrowedBox');
  await Hive.openBox<PendingReturn>('pendingReturnBox');


  //schedule Notifications
  await checkAndScheduleNotifications();


  runApp(const App());
}

// _loadingResources function
Future<void> _loadingResources() async {
  await Future.delayed(const Duration(seconds: 1));
}





