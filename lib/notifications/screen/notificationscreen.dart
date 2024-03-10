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
            shrinkWrap: true,
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
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            notifications.title,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () async {
                                  for (var i = 0;
                                      i < notifications.times.length;
                                      i++) {
                                    if (notifications.key != null) {
                                      await flutterLocalNotificationsPlugin
                                          .cancel(notifications.key,
                                              tag: "${notifications.key}_$i");
                                    }
                                  }
                                  if (notifications.key != null) {
                                    boxNotifications.delete(notifications.key);
                                  }
                                  setState(() {});
                                },
                                icon: const Icon(Icons.delete)),
                            IconButton(
                                onPressed: () {
                                  scheduleNotification(
                                      id: int.parse(notifications.key),
                                      title: notifications.title,
                                      body: notifications.body,
                                      scheduledNotificationDateTime:
                                          notifications.times[index]);
                                  setState(() {});
                                },
                                icon: const Icon(Icons.schedule))
                          ],
                        )
                      ],
                    ),
                    for (var i = 0; i < notifications.times.length; i++)
                      Text(
                        notifications.times[i].toString(),
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
