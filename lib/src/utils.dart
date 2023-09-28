import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'models/prayer_schedule.dart';

String parseDate(DateTime date) {
  late String finalM;
  late String finalD;

  final y = date.year;
  final m = date.month;
  final d = date.day;

  if (m < 10) {
    finalM = '0$m';
  } else {
    finalM = '$m';
  }

  if (d < 10) {
    finalD = '0$d';
  } else {
    finalD = '$d';
  }

  return '/$y/$finalM/$finalD';
}

DateTime prayTime(BuildContext context, DateTime now, String timeText) {
  final split = timeText.split(':');
  return DateTime(
      now.year, now.month, now.day, int.parse(split[0]), int.parse(split[1]));
}

void requestPermission() {
  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()!
      .requestPermission();
}

Future<void> setScheduleNotifications(
    {required PrayerSchedule prayerSchedule}) async {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin.cancelAll();

  // Initialize time zones only once during app initialization
  tz.initializeTimeZones();

  // Get the local time zone
  final String local = await FlutterTimezone.getLocalTimezone();

  // Define Android notification details (channel)
  const androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'prayer_channel',
    'Prayer Schedule',
    channelDescription: 'Get prayer time reminders',
  );

  // Define general notification details
  const platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  // Loop through the prayer times in the schedule and schedule notifications
  for (final entry in prayerSchedule.toJson().entries) {
    final prayerName = entry.key;
    final prayerTime = entry.value;

    // Calculate the notification time
    final notificationTime = tz.TZDateTime.now(tz.getLocation(local))
        .add(const Duration(seconds: 5));

    // Schedule the notification
    await flutterLocalNotificationsPlugin.zonedSchedule(
      // Use a unique ID for each prayer time (you can use a hash or index)
      prayerName.hashCode,
      prayerName,
      prayerTime,
      notificationTime,
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
