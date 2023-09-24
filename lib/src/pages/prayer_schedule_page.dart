import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/prayer_schedule.dart';
import '../providers/providers.dart' show prayerScheduleProvider, cityProvider;

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
  late PrayerSchedule _schedule;
  bool _prayerScheduleFetched = false;

  @override
  Widget build(BuildContext context) {
    final city = ref.watch(cityProvider(id: widget.cityId));
    final schedule =
        ref.watch(prayerScheduleProvider(cityId: widget.cityId, date: _now));
    final timeTextStyle = Theme.of(context).textTheme.headlineMedium;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: city.when(
          data: (data) => Text(data.name),
          error: (_, __) => const Text('Failed to load'),
          loading: () => const Text('...'),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 8.0),
          StreamBuilder(
            stream: Stream.periodic(const Duration(seconds: 1)),
            builder: (context, snapshot) {
              final now = DateTime.now();
              return Column(
                children: [
                  if (_prayerScheduleFetched)
                    _TimeRemaining(
                      now: now,
                      prayerSchedule: _schedule,
                      textStyle: timeTextStyle!,
                    )
                ],
              );
            },
          ),
          const SizedBox(height: 16.0),
          schedule.when(
            data: (data) {
              if (_prayerScheduleFetched == false) {
                setState(() {
                  _schedule = data;
                  _prayerScheduleFetched = true;
                });
              }

              return _PrayerScheduleColumn(prayerSchedule: data);
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

class _TimeRemaining extends StatelessWidget {
  const _TimeRemaining(
      {required this.now,
      required this.prayerSchedule,
      required this.textStyle});

  final DateTime now;
  final PrayerSchedule prayerSchedule;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    late DateTime compare;
    late String trailing;
    late String leading;

    if (now.isBefore(prayTime(context, now, prayerSchedule.imsak))) {
      compare = prayTime(context, now, prayerSchedule.imsak);
      trailing = 'to Imsak';
    } else if (now.isBefore(prayTime(context, now, prayerSchedule.fajr))) {
      compare = prayTime(context, now, prayerSchedule.fajr);
      trailing = 'to Fajr';
    } else if (now.isBefore(prayTime(context, now, prayerSchedule.sunrise))) {
      compare = prayTime(context, now, prayerSchedule.sunrise);
      trailing = 'to Sunrise';
    } else if (now.isBefore(prayTime(context, now, prayerSchedule.dhuha))) {
      compare = prayTime(context, now, prayerSchedule.dhuha);
      trailing = 'to Dhuha';
    } else if (now.isBefore(prayTime(context, now, prayerSchedule.dhuhr))) {
      compare = prayTime(context, now, prayerSchedule.dhuhr);
      trailing = 'to Dhuhr';
    } else if (now.isBefore(prayTime(context, now, prayerSchedule.asr))) {
      compare = prayTime(context, now, prayerSchedule.asr);
      trailing = 'to Asr';
    } else if (now.isBefore(prayTime(context, now, prayerSchedule.maghrib))) {
      compare = prayTime(context, now, prayerSchedule.maghrib);
      trailing = 'to Maghrib';
    } else {
      compare = prayTime(context, now, prayerSchedule.isha);
      trailing = 'to Isha';
    }

    final split = '${compare.difference(now)}'.split('.');
    leading = split[0];

    return Text(
      '$leading $trailing',
      textAlign: TextAlign.center,
      style: textStyle,
    );
  }

  DateTime prayTime(BuildContext context, DateTime now, String timeText) {
    final split = timeText.split(':');
    return DateTime(
        now.year, now.month, now.day, int.parse(split[0]), int.parse(split[1]));
  }
}
