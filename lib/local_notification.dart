import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_map_essay/services.dart';
import 'package:timezone/timezone.dart' as tz;

// Initialize local notifications
void initializeNotification() {
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()!
      .requestNotificationsPermission();

  // Initialize plugin settings
  AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/ic_launcher');
  const DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
          onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
  const LinuxInitializationSettings initializationSettingsLinux =
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

// Callback for receiving local notifications
void _onDidReceiveLocalNotification(
    int id, String? title, String? body, String? payload) {
  // Handle received local notification
}

// Show a notification
Future<void> showNotification(String title, String body) async {
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'your_channel_id', 'Your Channel Name',
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

// Handle notification response
@pragma('vm:entry-point')
void notificationResponse(NotificationResponse notificationResponse) {
  if (notificationResponse.actionId == "accept" &&
      navigatorKey.currentContext != null) {
    // Route to page when "accept" action is clicked
    Navigator.push(
      navigatorKey.currentContext!,
      MaterialPageRoute(builder: (context) => const Placeholder()),
    );
  }
}

// Schedule a notification
Future scheduleNotification({
  int? id,
  required String title,
  required String body,
  required DateTime scheduledNotificationDateTime,
}) async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
    id!,
    title,
    body,
    tz.TZDateTime.from(
      scheduledNotificationDateTime,
      tz.local,
    ),
    await notificationDetails(),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
  );

//   flutterLocalNotificationsPlugin.(
//       id, title, body,RepeatInterval.daily , await notificationDetails());
}

tz.TZDateTime _convertTime(DateTime scheduledNotificationDateTime) {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduleDate = tz.TZDateTime(
    tz.local,
    scheduledNotificationDateTime.year,
    scheduledNotificationDateTime.month,
    scheduledNotificationDateTime.day,
    scheduledNotificationDateTime.hour,
    scheduledNotificationDateTime.minute,
  );

  if (scheduleDate.isBefore(now)) {
    scheduleDate = scheduleDate.add(const Duration(days: 1));
  }

  return scheduleDate;
}

Future<void> scheduledPeriodicNotification(
    {required int id,
    required String title,
    required String body,
    required DateTime time}) async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
    id,
    title,
    body,
    _convertTime(time),
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'your channel id',
        'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
      ),
    ),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
    //payload: 'It could be anything you pass',
  );
}

Future<void> schedulePeriodicNotifications(
    {required int id,
    required String title,
    required String body,
    required RepeatInterval repeatInterval}) async {
  await flutterLocalNotificationsPlugin.periodicallyShow(
    id,
    title,
    body,
    repeatInterval,
    await notificationDetails(),
    androidAllowWhileIdle: true,
  );
}

// Returns notification details
Future<NotificationDetails> notificationDetails() async {
  return const NotificationDetails(
    android: AndroidNotificationDetails('channelId', 'channelName',
        importance: Importance.max),
    iOS: DarwinNotificationDetails(),
  );
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();