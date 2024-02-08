import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../aladhan_apis.dart';
import '../models/aladhan_timings.dart';
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

@riverpod
Future<City> city(CityRef ref, {required String id}) async {
  final api = MyQuranApis();
  final city = api.getCity(id: id);
  return city;
}

@riverpod
Future<AlAdhanTimings> timings(TimingsRef ref,
    {required double lat, required double lng, required int method}) async {
  final api = AlAdhanApis();
  final timings = api.getTimings(lat, lng, method);
  return timings;
}
