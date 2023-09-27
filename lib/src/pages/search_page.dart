import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common.dart';
import '../providers/providers.dart' show citiesProvider;
import 'prayer_schedule_page.dart' show PrayerScheduleArgs;

class SearchPage extends ConsumerStatefulWidget {
  static const routeName = '/search';

  const SearchPage({super.key, required this.data});

  final String data;

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final nav = Navigator.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    const horizontalPadding = EdgeInsets.symmetric(horizontal: 16.0);
    final cities = ref.watch(citiesProvider(cityName: _controller.text));

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: colorScheme.surface,
          flexibleSpace: SafeArea(
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 45.0,
                  margin: horizontalPadding,
                  padding: const EdgeInsets.only(left: 16.0, right: 50.0),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: TextFormField(
                    controller: _controller,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                        hintText: l10n.cityName,
                        border: InputBorder.none,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        isCollapsed: true,
                        errorMaxLines: 0,
                        constraints: const BoxConstraints(
                          minWidth: double.infinity,
                          maxHeight: 40.0,
                        ),
                        contentPadding: const EdgeInsets.only(bottom: 4.0)),
                    keyboardType: TextInputType.name,
                    onChanged: (str) {
                      if (str.length % 3 == 0) {
                        setState(() {});
                      }
                    },
                    textInputAction: TextInputAction.search,
                    onFieldSubmitted: (_) => setState(() {}),
                    style: TextStyle(color: colorScheme.onPrimaryContainer),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Visibility(
                    visible: _controller.text.isNotEmpty,
                    child: IconButton(
                      onPressed: () {
                        _controller.clear();
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.cancel,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        body: cities.when(
          data: (data) {
            if (data.isEmpty) {
              return Center(
                child: Text(
                  l10n.searchYourCity,
                  style: textTheme.bodyLarge!
                      .copyWith(color: colorScheme.onSurface),
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemBuilder: (context, index) {
                const allRadius = RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                );

                const startRadius = RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                );

                const endRadius = RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                );

                const midRadius = RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0.0),
                    topRight: Radius.circular(0.0),
                  ),
                );

                late RoundedRectangleBorder radius;
                if (data.length == 1) {
                  radius = allRadius;
                } else if (index == 0) {
                  radius = startRadius;
                } else if (index == data.length - 1) {
                  radius = endRadius;
                } else {
                  radius = midRadius;
                }

                return ListTile(
                  onTap: () => _setCityId(
                      data[index].id,
                      (d) => nav.pushNamedAndRemoveUntil(
                          '/schedule', (route) => false,
                          arguments: PrayerScheduleArgs(d))),
                  shape: radius,
                  title: Text(
                    data[index].name,
                    style: TextStyle(color: colorScheme.onPrimaryContainer),
                  ),
                  subtitle: Text(data[index].id),
                  tileColor: colorScheme.surfaceVariant,
                );
              },
              separatorBuilder: (_, __) => Divider(
                height: 0.0,
                color: colorScheme.onSurfaceVariant,
              ),
              itemCount: data.length,
            );
          },
          error: (_, __) => Center(
            child: Text(l10n.failedToLoad),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  Future<void> _setCityId(String cityId, Function(String) onData) async {
    final prefs = await SharedPreferences.getInstance();
    final data = json.decode(widget.data);
    final notifications = data['notifications'] as Map<String, dynamic>;

    var newData = {
      "cityId": cityId,
      "notifications": {
        "imsak": notifications['imsak'],
        "fajr": notifications['fajr'],
        "sunrise": notifications['sunrise'],
        "dhuha": notifications['dhuha'],
        "dhuhr": notifications['dhuhr'],
        "asr": notifications['asr'],
        "maghrib": notifications['maghrib'],
        "isha": notifications['isha'],
      }
    };

    final d = json.encode(newData);

    prefs.setString('data', d);

    onData(d);
  }
}

class SearchArgs {
  const SearchArgs(this.data);

  final String data;
}
