import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/prayer_schedule.dart';
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
            data: (data) => _PrayerScheduleColumn(prayerSchedule: data),
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

class _PrayerScheduleColumn extends StatelessWidget {
  const _PrayerScheduleColumn({required this.prayerSchedule});

  final PrayerSchedule prayerSchedule;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildScheduleContainer(context, prayerSchedule.imsak, 'Imsak'),
        _buildScheduleContainer(context, prayerSchedule.fajr, 'Fajr'),
        _buildScheduleContainer(context, prayerSchedule.sunrise, 'Sunrise'),
        _buildScheduleContainer(context, prayerSchedule.dhuha, 'Dhuha'),
        _buildScheduleContainer(context, prayerSchedule.dhuhr, 'Dhuhr'),
        _buildScheduleContainer(context, prayerSchedule.asr, 'Asr'),
        _buildScheduleContainer(context, prayerSchedule.maghrib, 'Maghrib'),
        _buildScheduleContainer(context, prayerSchedule.isha, 'Isha'),
      ],
    );
  }

  Widget _buildScheduleContainer(
      BuildContext context, String time, String name) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context)
        .textTheme
        .headlineSmall!
        .copyWith(color: colorScheme.onSecondaryContainer);

    return Container(
      margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        color: colorScheme.secondaryContainer,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: textStyle),
          Text(time, style: textStyle),
        ],
      ),
    );
  }
}
