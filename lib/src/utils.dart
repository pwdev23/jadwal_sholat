import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/address_ip.dart';

String parseDate(DateTime date) {
  late String finalM;
  late String finalD;

  final y = date.year;
  final m = date.month;
  final d = date.day;

  if (m < 10) {
    finalM = '0$m';
  } else {
    finalM = '$m';
  }

  if (d < 10) {
    finalD = '0$d';
  } else {
    finalD = '$d';
  }

  return '/$y/$finalM/$finalD';
}

DateTime prayTime(BuildContext context, DateTime now, String timeText) {
  final split = timeText.split(':');
  return DateTime(
      now.year, now.month, now.day, int.parse(split[0]), int.parse(split[1]));
}

Future<String> determinePublicIP() async {
  const url = 'https://api.ipify.org';

  final res = await http.get(Uri.parse(url));

  if (res.statusCode != 200) throw Exception('Failed to load');

  return res.body;
}

Future<AddressIP> determineAddressFromIP(String ip) async {
  final url = 'http://ip-api.com/json/$ip';

  final res = await http.get(Uri.parse(url));

  if (res.statusCode != 200) throw Exception('Failed to load');

  var decoded = json.decode(res.body);

  return AddressIP.fromJson(decoded);
}
