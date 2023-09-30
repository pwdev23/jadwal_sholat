import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shimmer/shimmer.dart';

import '../models/prayer_schedule.dart';
import '../myquran_apis.dart' show kBaseUrl;
import '../providers/providers.dart';
import '../utils.dart';
import '../common.dart';
import 'search_page.dart' show SearchArgs;

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
          loading: () => const _ShimmerProgressIndicator(
            width: 140,
            height: 45.0,
            radius: 8.0,
          ),
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
                enableNotifications: false,
                onNotifications: () {
                  final m = ScaffoldMessenger.of(context);
                  m
                    ..removeCurrentSnackBar()
                    ..showSnackBar(const SnackBar(
                        content: Text('Install a notifications')));
                },
                onUrl: () => _launchUrl(kBaseUrl),
                prayerSchedule: data,
                imsak: _imsak,
                onImsak: (_) {},
                fajr: _fajr,
                onFajr: (_) {},
                sunrise: _sunrise,
                onSunrise: (_) {},
                dhuha: _dhuha,
                onDhuha: (_) {},
                dhuhr: _dhuhr,
                onDhuhr: (_) {},
                asr: _asr,
                onAsr: (_) {},
                maghrib: _maghrib,
                onMaghrib: (_) {},
                isha: _isha,
                onIsha: (_) {},
              );
            },
            error: (_, __) => Text(l10n.failedToLoad),
            loading: () => const _LoadingPrayerSchedule(),
          ),
          const SizedBox(height: kToolbarHeight * 2),
        ],
      ),
      floatingActionButton: FloatingActionButton(
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
        child: const Icon(Icons.search),
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

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri,
        mode: LaunchMode.platformDefault,
        webViewConfiguration: const WebViewConfiguration(
          enableJavaScript: true,
          enableDomStorage: true,
        ))) {
      throw Exception('Failed to launch $url');
    }
  }
}

class PrayerScheduleArgs {
  const PrayerScheduleArgs(this.data);

  final String data;
}

class _PrayerScheduleColumn extends StatelessWidget {
  const _PrayerScheduleColumn({
    required this.prayerSchedule,
    required this.enableNotifications,
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
    required this.onNotifications,
    required this.onUrl,
  });

  final PrayerSchedule prayerSchedule;
  final bool enableNotifications;
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
  final VoidCallback onNotifications;
  final VoidCallback onUrl;

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
        if (enableNotifications)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: OutlinedButton.icon(
              onPressed: onNotifications,
              icon: Icon(Icons.refresh, color: colorScheme.inverseSurface),
              label: Text(l10n.notifications, style: textTheme.titleMedium),
            ),
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
        const SizedBox(height: 16.0),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: colorScheme.tertiaryContainer,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info, color: colorScheme.onTertiaryContainer),
              const SizedBox(width: 16.0),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    text: l10n.about1,
                    style: textTheme.bodySmall!
                        .copyWith(color: colorScheme.onTertiaryContainer),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' api.myquran.com',
                        style:
                            textTheme.bodySmall!.copyWith(color: Colors.blue),
                        recognizer: TapGestureRecognizer()..onTap = onUrl,
                      ),
                      TextSpan(
                        text: "${l10n.about2}.",
                        style: textTheme.bodySmall!
                            .copyWith(color: colorScheme.onTertiaryContainer),
                      ),
                    ],
                  ),
                ),
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

class _ShimmerProgressIndicator extends StatelessWidget {
  const _ShimmerProgressIndicator({
    this.width = double.infinity,
    this.height = kToolbarHeight,
    this.radius = 16.0,
  });

  final double width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Shimmer.fromColors(
      baseColor: Theme.of(context).disabledColor,
      highlightColor: colorScheme.surface,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: Theme.of(context).disabledColor),
      ),
    );
  }
}

class _LoadingPrayerSchedule extends StatelessWidget {
  const _LoadingPrayerSchedule();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ShimmerProgressIndicator(
            height: kToolbarHeight * 2,
          ),
          const SizedBox(height: 16.0),
          Wrap(
            runSpacing: 8.0,
            spacing: 8.0,
            children: kScheduleShimmer
                .map((e) => _ShimmerProgressIndicator(
                      width: e['width']!,
                      height: e['height']!,
                      radius: e['radius']!,
                    ))
                .toList(),
          ),
          const SizedBox(height: 16.0),
          const _ShimmerProgressIndicator(
            height: kToolbarHeight * 2,
          ),
        ],
      ),
    );
  }
}

const kScheduleShimmer = [
  {
    "width": 130.0,
    "height": 45.0,
    "radius": 8.0,
  },
  {
    "width": 140.0,
    "height": 45.0,
    "radius": 8.0,
  },
  {
    "width": 140.0,
    "height": 45.0,
    "radius": 8.0,
  },
  {
    "width": 150.0,
    "height": 45.0,
    "radius": 8.0,
  },
  {
    "width": 130.0,
    "height": 45.0,
    "radius": 8.0,
  },
  {
    "width": 140.0,
    "height": 45.0,
    "radius": 8.0,
  },
  {
    "width": 140.0,
    "height": 45.0,
    "radius": 8.0,
  },
  {
    "width": 130.0,
    "height": 45.0,
    "radius": 8.0,
  },
];
