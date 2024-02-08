import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/aladhan_timings.dart';

const kAladhanBaseUrl = 'http://api.aladhan.com';

class AlAdhanApis {
  Future<AlAdhanTimings> getTimings(double lat, double lng, int m) async {
    const v = '/v1';
    final path = '/timings/1398332113?latitude=$lat&longitude=$lng&method=$m';
    final url = '$kAladhanBaseUrl$v$path';

    final res = await http.get(Uri.parse(url));

    if (res.statusCode != 200) throw Exception('Failed to load');

    final d = json.decode(res.body)['data']['timings'];

    return AlAdhanTimings.fromJson(d);
  }
}
