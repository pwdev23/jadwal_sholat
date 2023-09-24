import 'package:flutter_test/flutter_test.dart';

import 'package:jadwal_sholat/src/utils.dart' show parseDate;

void main() {
  final dentistAppointment = DateTime(2017, 11, 7, 17, 30);
  test('Date parser test', () {
    final parsed = parseDate(dentistAppointment);
    expect(parsed, '/2017/11/07');
  });
}
