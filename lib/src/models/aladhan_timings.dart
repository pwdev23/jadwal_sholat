import 'package:freezed_annotation/freezed_annotation.dart';

part 'aladhan_timings.freezed.dart';
part 'aladhan_timings.g.dart';

@freezed
class AlAdhanTimings with _$AlAdhanTimings {
  const factory AlAdhanTimings({
    @JsonKey(name: 'Imsak') required String imsak,
    @JsonKey(name: 'Fajr') required String fajr,
    @JsonKey(name: 'Sunrise') required String sunrise,
    @JsonKey(name: 'Dhuhr') required String dhuhr,
    @JsonKey(name: 'Asr') required String asr,
    @JsonKey(name: 'Maghrib') required String maghrib,
    @JsonKey(name: 'Isha') required String isha,
  }) = _AlAdhanTimings;

  factory AlAdhanTimings.fromJson(Map<String, dynamic> json) =>
      _$AlAdhanTimingsFromJson(json);
}
