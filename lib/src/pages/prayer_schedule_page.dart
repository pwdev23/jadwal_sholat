import 'package:flutter/material.dart';

class PrayerSchedulePage extends StatefulWidget {
  static const routeName = '/schedule';

  const PrayerSchedulePage({
    super.key,
    required this.cityId,
  });

  final String cityId;

  @override
  State<PrayerSchedulePage> createState() => _PrayerSchedulePageState();
}

class _PrayerSchedulePageState extends State<PrayerSchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'City ID: ${widget.cityId}',
            ),
          ],
        ),
      ),
    );
  }
}

class PrayerScheduleArgs {
  const PrayerScheduleArgs(this.cityId);

  final String cityId;
}
