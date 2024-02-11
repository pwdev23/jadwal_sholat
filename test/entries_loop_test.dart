import 'package:flutter_test/flutter_test.dart';

import 'package:jadwal_sholat/src/models/prayer_schedule.dart';

void main() {
  const p = PrayerSchedule(
    imsak: "00:00",
    fajr: "00:00",
    sunrise: "00:00",
    dhuhr: "00:00",
    asr: "00:00",
    maghrib: "00:00",
    isha: "18:00",
  );

  test('Entries loop test', () {
    late String isha;

    for (var e in p.toJson().entries) {
      // print("${e.key}: ${e.value}");
      isha = e.value;
    }

    expect(isha, "18:00");
  });
}
