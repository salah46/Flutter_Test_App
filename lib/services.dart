// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_map_essay/doctor.dart';
import 'package:flutter_map_essay/doctorsList.dart';
import 'firebase_options.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
initServices() async {
  initLocalNotification();
  catchUpdateInFirestore();
}

// void onDidReceiveLocalNotification(
//     int id, String title?, String? body, String? payload) async {
//   // display a dialog with the notification details, tap ok to go to another page
//   showDialog(
//     context: context,
//     builder: (BuildContext context) => CupertinoAlertDialog(
//       title: Text(title),
//       content: Text(body),
//       actions: [
//         CupertinoDialogAction(
//           isDefaultAction: true,
//           child: Text('Ok'),
//           onPressed: () async {
//             Navigator.of(context, rootNavigator: true).pop();
//             await Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => SecondScreen(payload),
//               ),
//             );
//           },
//         )
//       ],
//     ),
//   );
// }

initLocalNotification() {
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()!
      .requestNotificationsPermission();
  // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
          onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
  final LinuxInitializationSettings initializationSettingsLinux =
      LinuxInitializationSettings(defaultActionName: 'Open notification');
  InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux);
  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveBackgroundNotificationResponse: notificationResponse,
    onDidReceiveNotificationResponse: notificationResponse,
  );
}

void catchUpdateInFirestore() {
  FirebaseFirestore.instance
      .collection("Notifications")
      .orderBy("createAt", descending: true)
      .snapshots()
      .listen((event) {
    if (event.docs.isNotEmpty) {
      var firstDocumentData =
          event.docs.first.data(); // Access data from the first document
      var hightlign = firstDocumentData['H1'];
      var body = firstDocumentData['B1'];
      showNotification(hightlign, body);
      print('The last update ::::: ${event.docs.first.data().values}');
    }
  });
}

void _onDidReceiveLocalNotification(
    int id, String? title, String? body, String? payload) {}

Future<void> showNotification(String title, String body) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id', 'your channel name',
      channelDescription: 'Description',
      importance: Importance.max,
      priority: Priority.high,
      actions: [
        AndroidNotificationAction(
          'accept',
          'Accept',
          showsUserInterface: true,
        ),
        AndroidNotificationAction('decline', 'Decline',
            showsUserInterface: true)
      ]);
  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );
  await flutterLocalNotificationsPlugin.show(
    0,
    title,
    body,
    platformChannelSpecifics,
    payload: 'Default_Sound',
  );
}
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
@pragma('vm:entry-point')
@pragma('vm:entry-point')
void notificationResponse(NotificationResponse notificationResponse) {
  if (notificationResponse.actionId == "accept" && navigatorKey.currentContext != null) {
    // Route to page when "accept" action is clicked
    Navigator.push(
      navigatorKey.currentContext!,
      MaterialPageRoute(builder: (context) => DoctorsList()),
    );
  }
  // Print the payload irrespective of the action
  print(notificationResponse.payload);
}

