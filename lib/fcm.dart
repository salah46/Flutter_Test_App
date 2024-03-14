import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_map_essay/doctor/screen/doctorsList.dart';
import 'package:flutter_map_essay/local_notification.dart';
import 'package:flutter_map_essay/tokenacces.dart';
import 'package:http/http.dart' as http;

AccessTokenFireBase accesstoken = AccessTokenFireBase();
late AndroidNotificationChannel channel;
var instance = FirebaseMessaging.instance;

class FireBaseMessageService {
  static String? token;

  static initFcmService() async {
    var instance = FirebaseMessaging.instance;

    await instance.requestPermission();
    await refreshToken();
    await getTheToken(instance);
    await storeTokenInFirebaseFirestore(token!);

    // Listen to messages
    listenFCM();

    // Send test push message
    // sendPushMessage(token!, "Hello", 'body text');

    // Enable auto initialization
    await instance.setAutoInitEnabled(true);
  }

  static Future<void> refreshToken() async {
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      print("##################\n");
      print(fcmToken);

      token = fcmToken;

      print("##################\n");
    }).onError((err) {
      // Error getting token.
    });

    await getTheToken(instance);
    if (token != null) {
      await storeTokenInFirebaseFirestore(token!);
    //  sendPushMessage(token!, "Hello", 'body text'); //ot for the sender
    }

    loadFCM();
    await instance.setAutoInitEnabled(true);
  }

  static Future<void> getTheToken(FirebaseMessaging instance) async {
    await instance.getToken().then((value) {
      print("§§§§§##################\n");
      print(value);
      token = value!;
      print("##################\n");
    });
  }

  static storeTokenInFirebaseFirestore(String token) async {
    String? existingToken = await getExistingToken();
    if (existingToken != token) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc('user1')
          .set({"token": token}, SetOptions(merge: true));
    } else {
      print('there is a match and no change occures to the user token');
    }
  }

  static Future<String?> getExistingToken() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc('user1')
          .get();
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>; // Explicit casting
        return data['token'] as String?;
      } else {
        // Document doesn't exist
        return null;
      }
    } catch (error) {
      print("Failed to get existing token: $error");
      return null;
    }
  }
}

Future<String> getAccessToken() async {
  var acToken = await accesstoken.getToken();
  return acToken;
}

Future<void> sendPushMessage(String token, String title, String body) async {
  try {
    // Update  this with your private key
    String accessToken = await getAccessToken();
    print(accessToken.toString());
    http.Response response = await http.post(
      Uri.parse(
          'https://fcm.googleapis.com/v1/projects/flutteressay/messages:send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        'message': {
          'token': token,
          'notification': {
            'body': body,
            'title': title,
          },
        },
      }),
    );

    if (response.statusCode == 200) {
      print("Notification sent successfully. Response: ${response.body}");
    } else {
      print(
          "Failed to send notification. Response status code: ${response.statusCode}");
    }
  } catch (e) {
    print("Error sending notification: $e");
  }
}

void requestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
}

Future<void> backgroundMessageHandler(RemoteMessage message) async {
  print("hello, the app is in the background but not terminated");
  // Your background message handling logic here
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    print("======================================the app is in the background  not terminated");
    String token = "";
    await FirebaseMessaging.instance.getToken().then((value) {
      token = value!;
    });
    // sendPushMessage(token, "Hello", 'background');
    // showNotification(notification.title!, notification.body!);
    // if (navigatorKey.currentContext != null) {
    //   Navigator.push(
    //     navigatorKey.currentContext!,
    //     MaterialPageRoute(builder: (context) => const DoctorsList()),
    //   );
    // }
  }
}

void listenFCM() async {
  // Foreground message handling
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print(
        "======================================the app is in the foreground  not terminated");
      RemoteNotification? notification = message.notification;
    //  sendPushMessage(token, "Hello", 'background');
       showNotification(notification!.title!, notification.body!);
      // any action here will be excute after the notifications
     print(
        "======================================${message.data}");
    
  });

  // When the app is in the background but not terminated
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    print(
        '######################################you click the onMessageOpenedApp');
    if (navigatorKey.currentContext != null) {
      Navigator.push(
        navigatorKey.currentContext!,
        MaterialPageRoute(builder: (context) => const DoctorsList()),
      );
    }
  });

  // Background message handling
  FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
}

// Keep the rest of your existing code unchanged

void loadFCM() async {
  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.high,
      enableVibration: true,
    );

    //  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}
