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
