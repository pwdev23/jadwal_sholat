import 'package:flutter_test/flutter_test.dart';

void main() {
  var data = {
    "cityId": "1212",
    "notifications": {
      "imsak": false,
      "fajr": false,
      "sunrise": false,
      "dhuha": false,
      "dhuhr": false,
      "asr": false,
      "maghrib": false,
      "isha": false,
    }
  };

  test('Nested map test', () {
    var notifications = data['notifications'] as Map<String, dynamic>;
    final fajr = notifications['fajr'];
    expect(fajr, false);
  });
}
