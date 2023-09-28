import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/prayer_schedule.dart';
import '../providers/providers.dart';
import '../utils.dart';
import '../common.dart';
import 'search_page.dart';

class PrayerSchedulePage extends ConsumerStatefulWidget {
  static const routeName = '/schedule';

  const PrayerSchedulePage({
    super.key,
    required this.data,
  });

  final String data;

  @override
  ConsumerState<PrayerSchedulePage> createState() => _PrayerSchedulePageState();
}

class _PrayerSchedulePageState extends ConsumerState<PrayerSchedulePage> {
  final _now = DateTime.now();
  late PrayerSchedule _schedule;
  late String _cityId;
  late bool _imsak;
  late bool _fajr;
  late bool _sunrise;
  late bool _dhuha;
  late bool _dhuhr;
  late bool _asr;
  late bool _maghrib;
  late bool _isha;
  bool _prayerScheduleFetched = false;

  @override
  void initState() {
    super.initState();

    _getData(widget.data);

    requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final nav = Navigator.of(context);
    final city = ref.watch(cityProvider(id: _cityId));
    final schedule =
        ref.watch(prayerScheduleProvider(cityId: _cityId, date: _now));
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
          error: (_, __) => Text(l10n.failedToLoad,
              style: TextStyle(color: colorScheme.onSurface)),
          loading: () =>
              Text('', style: TextStyle(color: colorScheme.onSurface)),
        ),
        actions: [
          IconButton(
            tooltip: l10n.searchYourCity,
            onPressed: () async {
              var data = {
                "cityId": _cityId,
                "notifications": {
                  "imsak": _imsak,
                  "fajr": _fajr,
                  "sunrise": _sunrise,
                  "dhuha": _dhuha,
                  "dhuhr": _dhuhr,
                  "asr": _asr,
                  "maghrib": _maghrib,
                  "isha": _isha,
                }
              };

              final d = json.encode(data);

              final prefs = await SharedPreferences.getInstance();

              prefs.setString('data', d);

              nav.pushNamed('/search', arguments: SearchArgs(d));
            },
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
                // setScheduleNotifications(prayerSchedule: data);

                setState(() {
                  _schedule = data;
                  _prayerScheduleFetched = true;
                });
              }

              return _PrayerScheduleColumn(
                prayerSchedule: data,
                imsak: _imsak,
                onImsak: (v) {
                  setState(() => _imsak = v);
                  _setData();
                },
                fajr: _fajr,
                onFajr: (v) {
                  setState(() => _fajr = v);
                  _setData();
                },
                sunrise: _sunrise,
                onSunrise: (v) {
                  setState(() => _sunrise = v);
                  _setData();
                },
                dhuha: _dhuha,
                onDhuha: (v) {
                  setState(() => _dhuha = v);
                  _setData();
                },
                dhuhr: _dhuhr,
                onDhuhr: (v) {
                  setState(() => _dhuhr = v);
                  _setData();
                },
                asr: _asr,
                onAsr: (v) {
                  setState(() => _asr = v);
                  _setData();
                },
                maghrib: _maghrib,
                onMaghrib: (v) {
                  setState(() => _maghrib = v);
                  _setData();
                },
                isha: _isha,
                onIsha: (v) {
                  setState(() => _isha = v);
                  _setData();
                },
              );
            },
            error: (_, __) => Text(l10n.failedToLoad),
            loading: () => const LinearProgressIndicator(),
          ),
          const SizedBox(height: kToolbarHeight * 2),
        ],
      ),
    );
  }

  void _getData(String data) {
    final d = json.decode(data);
    final n = d['notifications'] as Map<String, dynamic>;

    setState(() {
      _cityId = d['cityId'];
      _imsak = n['imsak']!;
      _fajr = n['fajr']!;
      _sunrise = n['sunrise']!;
      _dhuha = n['dhuha']!;
      _dhuhr = n['dhuhr']!;
      _asr = n['asr']!;
      _maghrib = n['maghrib']!;
      _isha = n['isha']!;
    });
  }

  Future<void> _setData() async {
    final prefs = await SharedPreferences.getInstance();

    var data = {
      "cityId": _cityId,
      "notifications": {
        "imsak": _imsak,
        "fajr": _fajr,
        "sunrise": _sunrise,
        "dhuha": _dhuha,
        "dhuhr": _dhuhr,
        "asr": _asr,
        "maghrib": _maghrib,
        "isha": _isha,
      }
    };

    var d = json.encode(data);

    prefs.setString('data', d);
  }
}

class PrayerScheduleArgs {
  const PrayerScheduleArgs(this.data);

  final String data;
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
    final l10n = AppLocalizations.of(context)!;
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
          child: Text(l10n.notifications, style: textTheme.titleMedium),
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
                  '${l10n.imsak} ${prayerSchedule.imsak}',
                  style: titleMedium,
                ),
                selected: imsak,
                onSelected: (v) => {onImsak(v)},
              ),
              ChoiceChip.elevated(
                selectedColor: colorScheme.secondaryContainer,
                label: Text(
                  '${l10n.fajr} ${prayerSchedule.fajr}',
                  style: titleMedium,
                ),
                selected: fajr,
                onSelected: (v) => {onFajr(v)},
              ),
              ChoiceChip.elevated(
                selectedColor: colorScheme.secondaryContainer,
                label: Text(
                  '${l10n.sunrise} ${prayerSchedule.sunrise}',
                  style: titleMedium,
                ),
                selected: sunrise,
                onSelected: (v) => {onSunrise(v)},
              ),
              ChoiceChip.elevated(
                selectedColor: colorScheme.secondaryContainer,
                label: Text(
                  '${l10n.dhuha} ${prayerSchedule.dhuha}',
                  style: titleMedium,
                ),
                selected: dhuha,
                onSelected: (v) => {onDhuha(v)},
              ),
              ChoiceChip.elevated(
                selectedColor: colorScheme.secondaryContainer,
                label: Text(
                  '${l10n.dhuhr} ${prayerSchedule.dhuhr}',
                  style: titleMedium,
                ),
                selected: dhuhr,
                onSelected: (v) => {onDhuhr(v)},
              ),
              ChoiceChip.elevated(
                selectedColor: colorScheme.secondaryContainer,
                label: Text(
                  '${l10n.asr} ${prayerSchedule.asr}',
                  style: titleMedium,
                ),
                selected: asr,
                onSelected: (v) => {onAsr(v)},
              ),
              ChoiceChip.elevated(
                selectedColor: colorScheme.secondaryContainer,
                label: Text(
                  '${l10n.maghrib} ${prayerSchedule.maghrib}',
                  style: titleMedium,
                ),
                selected: maghrib,
                onSelected: (v) => {onMaghrib(v)},
              ),
              ChoiceChip.elevated(
                selectedColor: colorScheme.secondaryContainer,
                label: Text(
                  '${l10n.isha} ${prayerSchedule.isha}',
                  style: titleMedium,
                ),
                selected: isha,
                onSelected: (v) => {onIsha(v)},
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
