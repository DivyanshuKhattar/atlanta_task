import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService{
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings("@drawable/app_icon");

  void initialiseNotifications() async{
    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
}