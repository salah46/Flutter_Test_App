// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_map_essay/hive_boxes.dart';
import 'package:hive_flutter/adapters.dart';
import 'local_notification.dart';
import 'notifications/model/notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

initServices() async {
  initializeNotification();
  catchUpdateInFirestore();
}

void catchUpdateInFirestore() {
  FirebaseFirestore.instance
      .collection("Notifications")
      .where("isShowed", isEqualTo: 0)
      .orderBy("createAt", descending: true)
      .snapshots()
      .listen((event) {
    if (event.docs.isNotEmpty) {
      var firstDocumentData =
          event.docs.first.data(); // Access data from the first document
      var hightline = firstDocumentData['H1'];
      var body = firstDocumentData['B1'];
      // modify isShowed field to 1
      // Get the reference to the document and update the isShowed field
      var documentReference = event.docs.first.reference;
      documentReference.update({'isShowed': 1});
      showNotification(hightline, body);

      print('The last update ::::: ${event.docs.first.data().values}');
    }
  });
}

Future<void> hiveInit() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NotificationsAdapter());
boxNotifications = await Hive.openBox<Notifications>('userBox');
}
