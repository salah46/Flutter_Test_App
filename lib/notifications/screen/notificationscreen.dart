import 'package:flutter/material.dart';
import 'package:flutter_map_essay/hive_boxes.dart';
import 'package:flutter_map_essay/local_notification.dart';
import 'package:flutter_map_essay/notifications/model/notifications.dart';
import 'package:flutter_map_essay/notifications/screen/add_notifications_widget.dart';
import 'package:flutter_map_essay/services.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

var title = "";

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await showMyDialog(context);
              title = "Notifications";

              setState(() {});
            },
            icon: const Icon(Icons.add),
          )
        ],
        title: Text(title),
      ),
      body: _buildNotificationsList(),
    );
  }

  Widget _buildNotificationsList() {
    return boxNotifications.length == 0
        ? const Center(
            child: Text("empty"),
          )
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: boxNotifications.length,
            itemBuilder: (context, index) {
              Notifications notifications = boxNotifications.getAt(index);
              return Card(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            notifications.title,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () async {
                                  if (notifications.key != null) {
                                    await flutterLocalNotificationsPlugin
                                        .cancel(notifications.key);
                                  }
                                  boxNotifications.delete(notifications.key);

                                  setState(() {});
                                },
                                icon: Icon(Icons.delete)),
                            IconButton(
                                onPressed: () {
                                  scheduleNotification(
                                      id: int.parse(notifications.key),
                                      title: notifications.title,
                                      body: notifications.body,
                                      scheduledNotificationDateTime:
                                          notifications.time);
                                  setState(() {});
                                },
                                icon: Icon(Icons.schedule))
                          ],
                        )
                      ],
                    ),
                    Text(
                      notifications.time.toString(),
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    Text(
                      notifications.body,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      notifications.key.toString(),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              );
            },
          );
  }
}
