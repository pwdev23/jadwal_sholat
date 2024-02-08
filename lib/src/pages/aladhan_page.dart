import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common.dart';
import '../models/address_ip.dart';
import '../providers/providers.dart' show timingsProvider;
import '../shared/shimmer_progress_indicator.dart';

class AlAdhanPage extends ConsumerStatefulWidget {
  static const routeName = '/aladhan';

  const AlAdhanPage({super.key, required this.addressIP});

  final AddressIP addressIP;

  @override
  ConsumerState<AlAdhanPage> createState() => _AlAdhanPageState();
}

class _AlAdhanPageState extends ConsumerState<AlAdhanPage> {
  static const String url = 'https://aladhan.com/prayer-times-api';
  static const String providerName = 'aladhan.com';
  final int m = 5;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    var timings = ref.watch(timingsProvider(
      lat: widget.addressIP.lat,
      lng: widget.addressIP.lng,
      method: m,
    ));
    final title = widget.addressIP.city.toUpperCase();
    final titleMedium = Theme.of(context)
        .textTheme
        .titleMedium!
        .copyWith(color: colorScheme.onSecondaryContainer);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: timings.when(
        data: (data) {
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              _TimeBanner(
                backgroundColor: colorScheme.inverseSurface,
                child: const Text('data'),
              ),
              const SizedBox(height: 25.0),
              Wrap(
                runSpacing: 2.0,
                spacing: 8.0,
                children: [
                  ChoiceChip.elevated(
                    label: Text('${l10n.imsak} ${data.imsak}'),
                    labelStyle: titleMedium,
                    selected: false,
                    onSelected: (v) => {},
                  ),
                  ChoiceChip.elevated(
                    label: Text('${l10n.fajr} ${data.fajr}'),
                    labelStyle: titleMedium,
                    selected: false,
                    onSelected: (v) => {},
                  ),
                  ChoiceChip.elevated(
                    label: Text('${l10n.sunrise} ${data.sunrise}'),
                    labelStyle: titleMedium,
                    selected: false,
                    onSelected: (v) => {},
                  ),
                  ChoiceChip.elevated(
                    label: Text('${l10n.dhuhr} ${data.dhuhr}'),
                    labelStyle: titleMedium,
                    selected: false,
                    onSelected: (v) => {},
                  ),
                  ChoiceChip.elevated(
                    label: Text('${l10n.asr} ${data.asr}'),
                    labelStyle: titleMedium,
                    selected: false,
                    onSelected: (v) => {},
                  ),
                  ChoiceChip.elevated(
                    label: Text('${l10n.maghrib} ${data.maghrib}'),
                    labelStyle: titleMedium,
                    selected: false,
                    onSelected: (v) => {},
                  ),
                  ChoiceChip.elevated(
                    label: Text('${l10n.isha} ${data.isha}'),
                    labelStyle: titleMedium,
                    selected: false,
                    onSelected: (v) => {},
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Container(
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
                              text: ' $providerName.',
                              style: textTheme.bodySmall!
                                  .copyWith(color: colorScheme.surfaceTint),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => _launchUrl(url),
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
        },
        error: (_, __) => Center(child: Text(l10n.failedToLoad)),
        loading: () => const _LoadingTimings(),
      ),
    );
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

class AlAdhanArgs {
  const AlAdhanArgs({required this.addressIP});

  final AddressIP addressIP;
}

class _TimeBanner extends StatelessWidget {
  const _TimeBanner({
    required this.backgroundColor,
    required this.child,
  });

  final Color backgroundColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight * 2,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: child,
    );
  }
}

class _LoadingTimings extends StatelessWidget {
  const _LoadingTimings();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: [
        const ShimmerProgressIndicator(
          height: kToolbarHeight * 2,
        ),
        const SizedBox(height: 25.0),
        Shimmer.fromColors(
          baseColor: Theme.of(context).splashColor,
          highlightColor: Theme.of(context).colorScheme.surface,
          child: Wrap(
            runSpacing: 8.0,
            spacing: 8.0,
            children: kTimingsShimmer
                .map((e) => Container(
                      width: e['width'],
                      height: e['height'],
                      decoration: BoxDecoration(
                        color: Theme.of(context).splashColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ))
                .toList(),
          ),
        ),
        const SizedBox(height: 16.0),
        const ShimmerProgressIndicator(
          height: kToolbarHeight * 2,
        ),
      ],
    );
  }
}

const kTimingsShimmer = [
  {"width": 130.0, "height": 45.0},
  {"width": 140.0, "height": 45.0},
  {"width": 140.0, "height": 45.0},
  {"width": 150.0, "height": 45.0},
  {"width": 130.0, "height": 45.0},
  {"width": 140.0, "height": 45.0},
  {"width": 140.0, "height": 45.0}
];
