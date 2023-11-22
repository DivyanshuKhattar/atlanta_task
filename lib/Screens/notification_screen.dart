import 'package:atlanta_task/Resources/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  double deviceHeight = 0.0;
  double deviceWidth = 0.0;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  NotificationService notificationService = NotificationService();

  @override
  void initState() {
    notificationService.initialiseNotifications();
    var androidInitialize = const AndroidInitializationSettings('app_icon');
    var initializeSetting = InitializationSettings(android: androidInitialize);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin!.initialize(initializeSetting);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: deviceHeight*0.07),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 30, 15, 10),
                  child: Text(
                    "Notifications",
                  ),
                ),
                /// title
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 11, 20, 11),
                  child: TextFormField(
                    controller: titleController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Field Required";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.2),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.fromLTRB(15, 11, 15, 11),
                      hintText: "Enter Title here...",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 11, 20, 40),
                  child: TextFormField(
                    controller: bodyController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Field Required";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.2),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.fromLTRB(15, 11, 15, 11),
                      hintText: "Enter Description here...",
                    ),
                  ),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(deviceWidth*0.42,deviceHeight*0.055),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: (){
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (formKey.currentState!.validate()) {
                      showNotification(titleController.text, bodyController.text);
                    }
                  },
                  child: Text(
                    "Show Notification",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Function to show the notification
  Future showNotification(String title, String description) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_name',
      'channel_description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin!.show(
      0,
      title,
      description,
      platformChannelSpecifics,
    );
  }
}
