// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_ip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddressIPImpl _$$AddressIPImplFromJson(Map<String, dynamic> json) =>
    _$AddressIPImpl(
      query: json['query'] as String,
      status: json['status'] as String,
      continent: json['continent'] as String?,
      continentCode: json['continentCode'] as String?,
      country: json['country'] as String,
      countryCode: json['countryCode'] as String,
      region: json['region'] as String,
      regionName: json['regionName'] as String,
      city: json['city'] as String,
      district: json['district'] as String?,
      zip: json['zip'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lon'] as num).toDouble(),
      timezone: json['timezone'] as String,
      offset: json['offset'] as int?,
      currency: json['currency'] as String?,
      isp: json['isp'] as String,
      org: json['org'] as String,
      as: json['as'] as String,
      asname: json['asname'] as String?,
      mobile: json['mobile'] as bool?,
      proxy: json['proxy'] as bool?,
      hosting: json['hosting'] as bool?,
    );

Map<String, dynamic> _$$AddressIPImplToJson(_$AddressIPImpl instance) =>
    <String, dynamic>{
      'query': instance.query,
      'status': instance.status,
      'continent': instance.continent,
      'continentCode': instance.continentCode,
      'country': instance.country,
      'countryCode': instance.countryCode,
      'region': instance.region,
      'regionName': instance.regionName,
      'city': instance.city,
      'district': instance.district,
      'zip': instance.zip,
      'lat': instance.lat,
      'lon': instance.lng,
      'timezone': instance.timezone,
      'offset': instance.offset,
      'currency': instance.currency,
      'isp': instance.isp,
      'org': instance.org,
      'as': instance.as,
      'asname': instance.asname,
      'mobile': instance.mobile,
      'proxy': instance.proxy,
      'hosting': instance.hosting,
    };
