import 'package:hive/hive.dart';

part 'notifications.g.dart';

@HiveType(typeId: 1)
class Notifications extends HiveObject {
  Notifications({required this.title, required this.body, required this.times});
  @HiveField(0)
  String title;

  @HiveField(1)
  String body;
  @HiveField(2)
  List <DateTime> times;
}
