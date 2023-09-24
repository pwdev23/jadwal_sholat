import 'package:freezed_annotation/freezed_annotation.dart';

part 'prayer_schedule.freezed.dart';
part 'prayer_schedule.g.dart';

@freezed
class PrayerSchedule with _$PrayerSchedule {
  const factory PrayerSchedule({
    required String imsak,
    @JsonKey(name: 'subuh') required String fajr,
    @JsonKey(name: 'terbit') required String sunrise,
    required String dhuha,
    @JsonKey(name: 'dzuhur') required String dhuhr,
    @JsonKey(name: 'ashar') required String asr,
    required String maghrib,
    @JsonKey(name: 'isya') required String isha,
  }) = _PrayerSchedule;

  factory PrayerSchedule.fromJson(Map<String, dynamic> json) =>
      _$PrayerScheduleFromJson(json);
}
