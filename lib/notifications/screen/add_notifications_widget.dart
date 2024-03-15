import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import "package:flutter_map_essay/hive_boxes.dart";
import 'package:flutter_map_essay/local_notification.dart';
import 'package:flutter_map_essay/notifications/model/notifications.dart';
import 'package:flutter_map_essay/services.dart';

class MyDialog extends StatefulWidget {
  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  TextEditingController textEditingController3 = TextEditingController();

  // Now create the list with the instances
  List<DateTime> datetimes = [];
  int repeat = 1;
  @override
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Custom Dialog'),
      content: SingleChildScrollView(
        child: Column(
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
            TextField(
              onChanged: (value) {
                setState(() {
                  repeat = int.parse(value);
                });
              },
              controller: textEditingController3,
              decoration: const InputDecoration(
                  labelText: 'The numbers of medcine repetitions'),
            ),
            const SizedBox(height: 10),
            // Generate date picker buttons based on repeat value
            Column(
              children: List.generate(repeat, (index) {
                return Column(
                  children: [
                    timePick(context),
                    const SizedBox(height: 10),
                  ],
                );
              }),
            ),
          ],
        ),
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
                Notifications(title: text1, body: text2, times: datetimes);
            Navigator.of(context).pop();
            await boxNotifications.put(boxNotifications.length * 4, item);
            // scheduleNotification(
            //     id: int.parse(item.key.toString()),
            //     title: item.title,
            //     body: item.body,
            //     scheduledNotificationDateTime: item.time);
            for (int i = 0; i < datetimes.length; i++) {
              int id = item.key + i;
              print("$id");
              scheduledSpecificPeriodicNotificationDaily(
                  tag: "${item.key}_$i",
                  id: id,
                  title: item.title,
                  body: item.body,
                  dateBegin: datetimes[i],
                  dateEnd: DateTime(2024, 3, 15, 13, 8, 0));
              print("########################");
            }

            setState(() {});
          },
          child: const Text('OK'),
        ),
      ],
    );
  }

  ElevatedButton timePick(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    return ElevatedButton(
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
              datetimes.add(selectedDate);
            });
          }
        }
      },
      child: const Text('Select Date and Time'),
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
