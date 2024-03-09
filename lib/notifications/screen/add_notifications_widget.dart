import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import "package:flutter_map_essay/hive_boxes.dart";
import 'package:flutter_map_essay/local_notification.dart';
import 'package:flutter_map_essay/notifications/model/notifications.dart';

class MyDialog extends StatefulWidget {
  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Custom Dialog'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: textEditingController1,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: textEditingController2,
            decoration: const InputDecoration(labelText: 'Body'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
                initialDatePickerMode: DatePickerMode.day,
                builder: (BuildContext context, Widget? child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      primaryColor: Colors.teal,
                      accentColor: Colors.teal,
                      colorScheme: ColorScheme.light(primary: Colors.teal),
                      buttonTheme:
                          ButtonThemeData(textTheme: ButtonTextTheme.primary),
                    ),
                    child: child!,
                  );
                },
              );

              if (picked != null && picked != selectedDate) {
                // Now, let's show the time picker
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(selectedDate),
                );

                if (pickedTime != null) {
                  // Combine the date and time
                  DateTime combinedDateTime = DateTime(
                    picked.year,
                    picked.month,
                    picked.day,
                    pickedTime.hour,
                    pickedTime.minute,
                  );

                  setState(() {
                    selectedDate = combinedDateTime;
                  });
                }
              }
            },
            child: const Text('Select Date and Time'),
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            // Handle the data from the text fields and date picker
            String text1 = textEditingController1.text;
            String text2 = textEditingController2.text;
            Notifications item =
                Notifications(title: text1, body: text2, time: selectedDate);
            Navigator.of(context).pop();
            await boxNotifications.put(boxNotifications.length + 1, item);
            // scheduleNotification(
            //     id: int.parse(item.key.toString()),
            //     title: item.title,
            //     body: item.body,
            //     scheduledNotificationDateTime: item.time);
            schedulePeriodicNotifications(
                id: item.key,
                title: item.title,
                body: item.body,
                repeatInterval: RepeatInterval.everyMinute );
            setState(() {});
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}

Future<void> showMyDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return MyDialog();
    },
  );
}
