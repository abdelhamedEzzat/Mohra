import 'package:hive/hive.dart';

part 'notification_model.g.dart';

@HiveType(typeId: 0)
class Notification extends HiveObject {
  @HiveField(0)
  final String companyName;
  @HiveField(1)
  final String stutasTextNotification;
  @HiveField(2)
  final String normalText;
  @HiveField(3)
  final String sendNotificationBy;

  Notification(
      {required this.companyName,
      required this.stutasTextNotification,
      required this.normalText,
      required this.sendNotificationBy});
}
