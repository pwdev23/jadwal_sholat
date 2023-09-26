import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/prayer_schedule.dart';
import '../providers/providers.dart' show prayerScheduleProvider, cityProvider;
import '../utils.dart';
import '../common.dart';

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
  bool _imsak = false;
  bool _fajr = true;
  bool _sunrise = false;
  bool _dhuha = false;
  bool _dhuhr = true;
  bool _asr = true;
  bool _maghrib = true;
  bool _isha = true;

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    final city = ref.watch(cityProvider(id: widget.cityId));
    final schedule =
        ref.watch(prayerScheduleProvider(cityId: widget.cityId, date: _now));
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        title: city.when(
          data: (data) => Text(
            data.name,
            style: TextStyle(color: colorScheme.onSurface),
          ),
          error: (_, __) => Text('Failed to load',
              style: TextStyle(color: colorScheme.onSurface)),
          loading: () =>
              Text('', style: TextStyle(color: colorScheme.onSurface)),
        ),
        actions: [
          IconButton(
            tooltip: 'Search city',
            onPressed: () => nav.pushNamed('/search'),
            icon: const Icon(Icons.search),
          )
        ],
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
                      backgroundColor: colorScheme.inverseSurface,
                      now: now,
                      prayerSchedule: _schedule,
                      foregroundColor: colorScheme.onInverseSurface,
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

              return _PrayerScheduleColumn(
                prayerSchedule: data,
                imsak: _imsak,
                onImsak: (v) => setState(() => _imsak = v),
                fajr: _fajr,
                onFajr: (v) => setState(() => _fajr = v),
                sunrise: _sunrise,
                onSunrise: (v) => setState(() => _sunrise = v),
                dhuha: _dhuha,
                onDhuha: (v) => setState(() => _dhuha = v),
                dhuhr: _dhuhr,
                onDhuhr: (v) => setState(() => _dhuhr = v),
                asr: _asr,
                onAsr: (v) => setState(() => _asr = v),
                maghrib: _maghrib,
                onMaghrib: (v) => setState(() => _maghrib = v),
                isha: _isha,
                onIsha: (v) => setState(() => _isha = v),
              );
            },
            error: (_, __) => const Text('Failed to load'),
            loading: () => const LinearProgressIndicator(),
          ),
          const SizedBox(height: kToolbarHeight * 2),
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
  const _PrayerScheduleColumn({
    required this.prayerSchedule,
    required this.imsak,
    required this.fajr,
    required this.sunrise,
    required this.dhuha,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    required this.onImsak,
    required this.onFajr,
    required this.onSunrise,
    required this.onDhuha,
    required this.onDhuhr,
    required this.onAsr,
    required this.onMaghrib,
    required this.onIsha,
  });

  final PrayerSchedule prayerSchedule;
  final bool imsak;
  final bool fajr;
  final bool sunrise;
  final bool dhuha;
  final bool dhuhr;
  final bool asr;
  final bool maghrib;
  final bool isha;
  final Function(bool) onImsak;
  final Function(bool) onFajr;
  final Function(bool) onSunrise;
  final Function(bool) onDhuha;
  final Function(bool) onDhuhr;
  final Function(bool) onAsr;
  final Function(bool) onMaghrib;
  final Function(bool) onIsha;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final titleMedium = Theme.of(context)
        .textTheme
        .titleMedium!
        .copyWith(color: colorScheme.onSecondaryContainer);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('Notifications', style: textTheme.titleMedium),
        ),
        const SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Wrap(
            runSpacing: 2.0,
            spacing: 8.0,
            children: [
              ChoiceChip.elevated(
                selectedColor: colorScheme.secondaryContainer,
                label: Text(
                  'Imsak: ${prayerSchedule.imsak}',
                  style: titleMedium,
                ),
                selected: imsak,
                onSelected: (v) => {onImsak(v)},
              ),
              ChoiceChip.elevated(
                selectedColor: colorScheme.secondaryContainer,
                label: Text(
                  'Fajr: ${prayerSchedule.fajr}',
                  style: titleMedium,
                ),
                selected: fajr,
                onSelected: (v) => {onImsak(v)},
              ),
              ChoiceChip.elevated(
                selectedColor: colorScheme.secondaryContainer,
                label: Text(
                  'Sunrise: ${prayerSchedule.sunrise}',
                  style: titleMedium,
                ),
                selected: sunrise,
                onSelected: (v) => {onImsak(v)},
              ),
              ChoiceChip.elevated(
                selectedColor: colorScheme.secondaryContainer,
                label: Text(
                  'Dhuha: ${prayerSchedule.dhuha}',
                  style: titleMedium,
                ),
                selected: dhuha,
                onSelected: (v) => {onImsak(v)},
              ),
              ChoiceChip.elevated(
                selectedColor: colorScheme.secondaryContainer,
                label: Text(
                  'Dhuhr: ${prayerSchedule.dhuhr}',
                  style: titleMedium,
                ),
                selected: dhuhr,
                onSelected: (v) => {onImsak(v)},
              ),
              ChoiceChip.elevated(
                selectedColor: colorScheme.secondaryContainer,
                label: Text(
                  'Asr: ${prayerSchedule.asr}',
                  style: titleMedium,
                ),
                selected: asr,
                onSelected: (v) => {onImsak(v)},
              ),
              ChoiceChip.elevated(
                selectedColor: colorScheme.secondaryContainer,
                label: Text(
                  'Maghrib: ${prayerSchedule.maghrib}',
                  style: titleMedium,
                ),
                selected: maghrib,
                onSelected: (v) => {onImsak(v)},
              ),
              ChoiceChip.elevated(
                selectedColor: colorScheme.secondaryContainer,
                label: Text(
                  'Isha: ${prayerSchedule.isha}',
                  style: titleMedium,
                ),
                selected: isha,
                onSelected: (v) => {onImsak(v)},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TimeRemaining extends StatelessWidget {
  const _TimeRemaining({
    required this.now,
    required this.prayerSchedule,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final DateTime now;
  final PrayerSchedule prayerSchedule;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    final leadingStyle = Theme.of(context)
        .textTheme
        .headlineLarge!
        .copyWith(color: foregroundColor);
    final tralingStyle = Theme.of(context)
        .textTheme
        .titleMedium!
        .copyWith(color: foregroundColor);
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
      child: Text.rich(
        TextSpan(
          text: '$leading ',
          style: leadingStyle,
          children: [
            TextSpan(text: trailing, style: tralingStyle),
          ],
        ),
      ),
    );
  }
}
