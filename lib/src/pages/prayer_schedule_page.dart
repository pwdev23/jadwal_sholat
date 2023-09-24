import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers.dart' show prayerScheduleProvider;

class PrayerSchedulePage extends ConsumerStatefulWidget {
  static const routeName = '/schedule';

  const PrayerSchedulePage({
    super.key,
    required this.cityId,
  });

  final String cityId;

  @override
  ConsumerState<PrayerSchedulePage> createState() => _PrayerSchedulePageState();
}

class _PrayerSchedulePageState extends ConsumerState<PrayerSchedulePage> {
  final _now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final schedule =
        ref.watch(prayerScheduleProvider(cityId: widget.cityId, date: _now));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          Text('City ID: ${widget.cityId}'),
          schedule.when(
            data: (data) {
              return Column(
                children: [
                  Text(data.imsak),
                  Text(data.fajr),
                  Text(data.sunrise),
                  Text(data.dhuha),
                  Text(data.dhuhr),
                  Text(data.asr),
                  Text(data.maghrib),
                  Text(data.isha),
                ],
              );
            },
            error: (_, __) => const Text('Failed to load'),
            loading: () => const LinearProgressIndicator(),
          ),
        ],
      ),
    );
  }
}

class PrayerScheduleArgs {
  const PrayerScheduleArgs(this.cityId);

  final String cityId;
}
