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
    final nav = Navigator.of(context);
    final city = ref.watch(cityProvider(id: widget.cityId));
    final schedule =
        ref.watch(prayerScheduleProvider(cityId: widget.cityId, date: _now));
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final colorScheme = Theme.of(context).colorScheme;
    final timeTextStyle = Theme.of(context)
        .textTheme
        .headlineMedium!
        .copyWith(color: colorScheme.onPrimaryContainer);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        title: city.when(
          data: (data) => Text(
            data.name,
            style: TextStyle(color: onSurface),
          ),
          error: (_, __) =>
              Text('Failed to load', style: TextStyle(color: onSurface)),
          loading: () => Text('', style: TextStyle(color: onSurface)),
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
                      backgroundColor: colorScheme.primaryContainer,
                      now: now,
                      prayerSchedule: _schedule,
                      textStyle: timeTextStyle,
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
          const SizedBox(height: kToolbarHeight),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => nav.pushNamed('/search'),
        child: const Icon(Icons.search),
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
    final colorScheme = Theme.of(context).colorScheme;
    final titleLarge = Theme.of(context).textTheme.titleLarge;

    return Container(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        children: [
          _PrayerTimeTile(
            backgroundColor: colorScheme.surfaceVariant,
            leading: 'Imsak',
            trailing: prayerSchedule.imsak,
            textStyle:
                titleLarge!.copyWith(color: colorScheme.onSurfaceVariant),
          ),
          _PrayerTimeTile(
            backgroundColor: colorScheme.secondaryContainer,
            leading: 'Fajr',
            trailing: prayerSchedule.fajr,
            textStyle:
                titleLarge.copyWith(color: colorScheme.onSecondaryContainer),
          ),
          _PrayerTimeTile(
            backgroundColor: colorScheme.surfaceVariant,
            leading: 'Sunrise',
            trailing: prayerSchedule.sunrise,
            textStyle: titleLarge.copyWith(color: colorScheme.onSurfaceVariant),
          ),
          _PrayerTimeTile(
            backgroundColor: colorScheme.secondaryContainer,
            leading: 'Dhuha',
            trailing: prayerSchedule.dhuha,
            textStyle:
                titleLarge.copyWith(color: colorScheme.onSecondaryContainer),
          ),
          _PrayerTimeTile(
            backgroundColor: colorScheme.surfaceVariant,
            leading: 'Dhuhr',
            trailing: prayerSchedule.dhuhr,
            textStyle: titleLarge.copyWith(color: colorScheme.onSurfaceVariant),
          ),
          _PrayerTimeTile(
            backgroundColor: colorScheme.secondaryContainer,
            leading: 'Asr',
            trailing: prayerSchedule.asr,
            textStyle:
                titleLarge.copyWith(color: colorScheme.onSecondaryContainer),
          ),
          _PrayerTimeTile(
            backgroundColor: colorScheme.surfaceVariant,
            leading: 'Maghrib',
            trailing: prayerSchedule.maghrib,
            textStyle: titleLarge.copyWith(color: colorScheme.onSurfaceVariant),
          ),
          _PrayerTimeTile(
            backgroundColor: colorScheme.secondaryContainer,
            leading: 'Isha',
            trailing: prayerSchedule.isha,
            textStyle:
                titleLarge.copyWith(color: colorScheme.onSecondaryContainer),
          ),
        ],
      ),
    );
  }
}

class _TimeRemaining extends StatelessWidget {
  const _TimeRemaining({
    required this.now,
    required this.prayerSchedule,
    required this.textStyle,
    required this.backgroundColor,
  });

  final DateTime now;
  final PrayerSchedule prayerSchedule;
  final TextStyle textStyle;
  final Color backgroundColor;

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
    } else if (now.isBefore(prayTime(context, now, prayerSchedule.isha))) {
      compare = prayTime(context, now, prayerSchedule.isha);
      trailing = 'to Isha';
    } else {
      final tomorrow = now.add(const Duration(days: 1));
      compare = prayTime(context, tomorrow, prayerSchedule.imsak);
      trailing = 'to Imsak';
    }

    final split = '${compare.difference(now)}'.split('.');
    leading = split[0];

    return Container(
      width: double.infinity,
      height: kToolbarHeight * 2,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: backgroundColor,
      ),
      child: Text(
        '$leading $trailing',
        textAlign: TextAlign.center,
        style: textStyle,
      ),
    );
  }

  DateTime prayTime(BuildContext context, DateTime now, String timeText) {
    final split = timeText.split(':');
    return DateTime(
        now.year, now.month, now.day, int.parse(split[0]), int.parse(split[1]));
  }
}

class _PrayerTimeTile extends StatelessWidget {
  const _PrayerTimeTile({
    required this.backgroundColor,
    required this.leading,
    required this.trailing,
    required this.textStyle,
  });

  final Color backgroundColor;
  final String leading;
  final String trailing;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(leading, style: textStyle),
          Text(trailing, style: textStyle),
        ],
      ),
    );
  }
}
