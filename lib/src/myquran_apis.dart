import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jadwal_sholat/src/models/prayer_schedule.dart';

import 'models/city.dart';
import 'utils.dart';

const kBaseUrl = 'https://api.myquran.com';
const kVersion = 'v2';

class MyQuranApis {
  Future<List<City>> getAllCities() async {
    const path = '/$kVersion/sholat/kota/semua';

    final url = Uri.parse('$kBaseUrl$path');

    final res = await http.get(url);

    if (res.statusCode != 200) throw Exception('Failed to load');

    final d = json.decode(res.body);

    return (d as List).map((e) => City.fromJson(e)).toList();
  }

  Future<List<City>> getCities(
    String cityName,
  ) async {
    if (cityName.isEmpty || cityName == '') {
      return <City>[];
    }

    final path = '/$kVersion/sholat/kota/cari/$cityName';

    var url = Uri.parse('$kBaseUrl$path');

    final res = await http.get(url);

    if (res.statusCode != 200) {
      throw Exception('Failed to load');
    }

    final d = json.decode(res.body);

    return (d['data'] as List).map((e) => City.fromJson(e)).toList();
  }

  Future<PrayerSchedule> getPrayerSchedulePerDay({
    required String cityId,
    required DateTime date,
  }) async {
    final path = '/$kVersion/sholat/jadwal/$cityId${parseDate(date)}';

    final url = Uri.parse('$kBaseUrl$path');

    final res = await http.get(url);

    if (res.statusCode != 200) throw Exception('Failed to load');

    final d = json.decode(res.body);

    return PrayerSchedule.fromJson(d['data']['jadwal']);
  }

  Future<City> getCity({required String id}) async {
    final path = '/$kVersion/sholat/kota/$id';

    final url = Uri.parse('$kBaseUrl$path');

    final res = await http.get(url);

    if (res.statusCode != 200) throw Exception('Failed to load');

    final d = json.decode(res.body);

    return City.fromJson(d['data']);
  }
}
