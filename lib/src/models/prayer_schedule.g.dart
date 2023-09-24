// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PrayerSchedule _$$_PrayerScheduleFromJson(Map<String, dynamic> json) =>
    _$_PrayerSchedule(
      imsak: json['imsak'] as String,
      fajr: json['subuh'] as String,
      sunrise: json['terbit'] as String,
      dhuha: json['dhuha'] as String,
      dhuhr: json['dzuhur'] as String,
      asr: json['ashar'] as String,
      maghrib: json['maghrib'] as String,
      isha: json['isya'] as String,
    );

Map<String, dynamic> _$$_PrayerScheduleToJson(_$_PrayerSchedule instance) =>
    <String, dynamic>{
      'imsak': instance.imsak,
      'subuh': instance.fajr,
      'terbit': instance.sunrise,
      'dhuha': instance.dhuha,
      'dzuhur': instance.dhuhr,
      'ashar': instance.asr,
      'maghrib': instance.maghrib,
      'isya': instance.isha,
    };
