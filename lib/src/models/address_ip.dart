import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_ip.freezed.dart';
part 'address_ip.g.dart';

@freezed
class AddressIP with _$AddressIP {
  const factory AddressIP({
    required String query,
    required String status,
    required String? continent,
    required String? continentCode,
    required String country,
    required String countryCode,
    required String region,
    required String regionName,
    required String city,
    required String? district,
    required String zip,
    required double lat,
    @JsonKey(name: 'lon') required double lng,
    required String timezone,
    required int? offset,
    required String? currency,
    required String isp,
    required String org,
    required String as,
    required String? asname,
    required bool? mobile,
    required bool? proxy,
    required bool? hosting,
  }) = _AddressIP;

  factory AddressIP.fromJson(Map<String, dynamic> json) =>
      _$AddressIPFromJson(json);
}
