import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzData;

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

// setting up the local notifications
  Future<void> setup() async {
    const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettings = InitializationSettings(
      android: androidSetting,
    );
    await flutterLocalNotificationsPlugin.initialize(initSettings).then((_) {
      debugPrint('setupPlugin: setup success');
    }).catchError((Object error) {
      debugPrint('Error: $error');
    });
  }

  //setting the notification to go off after a certain time period
  Future<void> addNotification(
      {required int id,
      required String title,
      required String body,
      required String term,
      required String channel}) async {
    tzData.initializeTimeZones();

    final androidDetail = AndroidNotificationDetails(
        channel, // channel Id
        channel // channel Name
        );

    RepeatInterval repeatInterval = RepeatInterval.daily;
    if (term == 'Daily') {
      repeatInterval = RepeatInterval.daily;
    } else if (term == 'Weekly') {
      repeatInterval = RepeatInterval.weekly;
    }

    await flutterLocalNotificationsPlugin.periodicallyShow(id, title, body,
        repeatInterval, NotificationDetails(android: androidDetail));
  }

  //deleting the saved notification
  Future<void> cancelNotifications(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
