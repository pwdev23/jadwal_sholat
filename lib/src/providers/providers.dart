import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/models.dart';
import '../myquran_apis.dart';

part 'providers.g.dart';

@riverpod
Future<List<City>> cities(CitiesRef ref, {required String cityName}) async {
  final api = MyQuranApis();
  final cities = api.getCities(cityName);
  return cities;
}

@riverpod
Future<PrayerSchedule> prayerSchedule(PrayerScheduleRef ref,
    {required String cityId, required DateTime date}) async {
  final api = MyQuranApis();
  final prayerSchedule =
      api.getPrayerSchedulePerDay(cityId: cityId, date: date);
  return prayerSchedule;
}
