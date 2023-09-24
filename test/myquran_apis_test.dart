import 'package:flutter_test/flutter_test.dart';

import 'package:jadwal_sholat/src/myquran_apis.dart';

void main() {
  final api = MyQuranApis();
  final someday = DateTime(2023, 9, 23, 17, 30);
  test('Get schedule test', () async {
    late String fajr;

    final prayerScedule = await api.getPrayerSchedulePerDay(
      cityId: '1609',
      date: someday,
    );

    fajr = prayerScedule.fajr;

    expect(fajr, '04:06');
  });
}
