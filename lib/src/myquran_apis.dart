import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/city.dart';
import 'utils.dart';

const kBaseUrl = 'https://api.myquran.com';

class MyQuranApis {
  Future<List<City>> getCities(
    String cityName,
  ) async {
    if (cityName.isEmpty || cityName == '') {
      return <City>[];
    }

    final path = '/v1/sholat/kota/cari/$cityName';

    var url = Uri.parse('$kBaseUrl$path');

    final res = await http.get(url);

    if (res.statusCode != 200) {
      throw Exception('Failed to load');
    }

    final d = json.decode(res.body);

    return (d['data'] as List).map((e) => City.fromJson(e)).toList();
  }

  Future<void> getPrayerSchedulePerDay({
    required String cityId,
    required DateTime date,
    required Function(int) onError,
    required Function(dynamic) onSchedule,
  }) async {
    final path = '/v1/sholat/jadwal/$cityId${parseDate(date)}';

    final url = Uri.parse('$kBaseUrl$path');

    final res = await http.get(url);

    if (res.statusCode != 200) {
      onError(res.statusCode);
      throw Exception('Failed to load');
    }

    final d = json.decode(res.body);

    onSchedule(d['data']['jadwal']);
  }
}
