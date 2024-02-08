// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$citiesHash() => r'431b576807d35895afd9d007a40785e61755e5b0';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [cities].
@ProviderFor(cities)
const citiesProvider = CitiesFamily();

/// See also [cities].
class CitiesFamily extends Family<AsyncValue<List<City>>> {
  /// See also [cities].
  const CitiesFamily();

  /// See also [cities].
  CitiesProvider call({
    required String cityName,
  }) {
    return CitiesProvider(
      cityName: cityName,
    );
  }

  @override
  CitiesProvider getProviderOverride(
    covariant CitiesProvider provider,
  ) {
    return call(
      cityName: provider.cityName,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'citiesProvider';
}

/// See also [cities].
class CitiesProvider extends AutoDisposeFutureProvider<List<City>> {
  /// See also [cities].
  CitiesProvider({
    required String cityName,
  }) : this._internal(
          (ref) => cities(
            ref as CitiesRef,
            cityName: cityName,
          ),
          from: citiesProvider,
          name: r'citiesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$citiesHash,
          dependencies: CitiesFamily._dependencies,
          allTransitiveDependencies: CitiesFamily._allTransitiveDependencies,
          cityName: cityName,
        );

  CitiesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.cityName,
  }) : super.internal();

  final String cityName;

  @override
  Override overrideWith(
    FutureOr<List<City>> Function(CitiesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CitiesProvider._internal(
        (ref) => create(ref as CitiesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        cityName: cityName,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<City>> createElement() {
    return _CitiesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CitiesProvider && other.cityName == cityName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, cityName.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CitiesRef on AutoDisposeFutureProviderRef<List<City>> {
  /// The parameter `cityName` of this provider.
  String get cityName;
}

class _CitiesProviderElement
    extends AutoDisposeFutureProviderElement<List<City>> with CitiesRef {
  _CitiesProviderElement(super.provider);

  @override
  String get cityName => (origin as CitiesProvider).cityName;
}

String _$prayerScheduleHash() => r'8a79ab15b3f60b20dbe4773702c632ececd5dcae';

/// See also [prayerSchedule].
@ProviderFor(prayerSchedule)
const prayerScheduleProvider = PrayerScheduleFamily();

/// See also [prayerSchedule].
class PrayerScheduleFamily extends Family<AsyncValue<PrayerSchedule>> {
  /// See also [prayerSchedule].
  const PrayerScheduleFamily();

  /// See also [prayerSchedule].
  PrayerScheduleProvider call({
    required String cityId,
    required DateTime date,
  }) {
    return PrayerScheduleProvider(
      cityId: cityId,
      date: date,
    );
  }

  @override
  PrayerScheduleProvider getProviderOverride(
    covariant PrayerScheduleProvider provider,
  ) {
    return call(
      cityId: provider.cityId,
      date: provider.date,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'prayerScheduleProvider';
}

/// See also [prayerSchedule].
class PrayerScheduleProvider extends AutoDisposeFutureProvider<PrayerSchedule> {
  /// See also [prayerSchedule].
  PrayerScheduleProvider({
    required String cityId,
    required DateTime date,
  }) : this._internal(
          (ref) => prayerSchedule(
            ref as PrayerScheduleRef,
            cityId: cityId,
            date: date,
          ),
          from: prayerScheduleProvider,
          name: r'prayerScheduleProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$prayerScheduleHash,
          dependencies: PrayerScheduleFamily._dependencies,
          allTransitiveDependencies:
              PrayerScheduleFamily._allTransitiveDependencies,
          cityId: cityId,
          date: date,
        );

  PrayerScheduleProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.cityId,
    required this.date,
  }) : super.internal();

  final String cityId;
  final DateTime date;

  @override
  Override overrideWith(
    FutureOr<PrayerSchedule> Function(PrayerScheduleRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PrayerScheduleProvider._internal(
        (ref) => create(ref as PrayerScheduleRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        cityId: cityId,
        date: date,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<PrayerSchedule> createElement() {
    return _PrayerScheduleProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PrayerScheduleProvider &&
        other.cityId == cityId &&
        other.date == date;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, cityId.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PrayerScheduleRef on AutoDisposeFutureProviderRef<PrayerSchedule> {
  /// The parameter `cityId` of this provider.
  String get cityId;

  /// The parameter `date` of this provider.
  DateTime get date;
}

class _PrayerScheduleProviderElement
    extends AutoDisposeFutureProviderElement<PrayerSchedule>
    with PrayerScheduleRef {
  _PrayerScheduleProviderElement(super.provider);

  @override
  String get cityId => (origin as PrayerScheduleProvider).cityId;
  @override
  DateTime get date => (origin as PrayerScheduleProvider).date;
}

String _$cityHash() => r'c5a9b6b31a501014795188323b9e8d3efd66b016';

/// See also [city].
@ProviderFor(city)
const cityProvider = CityFamily();

/// See also [city].
class CityFamily extends Family<AsyncValue<City>> {
  /// See also [city].
  const CityFamily();

  /// See also [city].
  CityProvider call({
    required String id,
  }) {
    return CityProvider(
      id: id,
    );
  }

  @override
  CityProvider getProviderOverride(
    covariant CityProvider provider,
  ) {
    return call(
      id: provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'cityProvider';
}

/// See also [city].
class CityProvider extends AutoDisposeFutureProvider<City> {
  /// See also [city].
  CityProvider({
    required String id,
  }) : this._internal(
          (ref) => city(
            ref as CityRef,
            id: id,
          ),
          from: cityProvider,
          name: r'cityProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$cityHash,
          dependencies: CityFamily._dependencies,
          allTransitiveDependencies: CityFamily._allTransitiveDependencies,
          id: id,
        );

  CityProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<City> Function(CityRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CityProvider._internal(
        (ref) => create(ref as CityRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<City> createElement() {
    return _CityProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CityProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CityRef on AutoDisposeFutureProviderRef<City> {
  /// The parameter `id` of this provider.
  String get id;
}

class _CityProviderElement extends AutoDisposeFutureProviderElement<City>
    with CityRef {
  _CityProviderElement(super.provider);

  @override
  String get id => (origin as CityProvider).id;
}

String _$timingsHash() => r'65826707e77093d04773edbe026b6ce2b5ccb542';

/// See also [timings].
@ProviderFor(timings)
const timingsProvider = TimingsFamily();

/// See also [timings].
class TimingsFamily extends Family<AsyncValue<AlAdhanTimings>> {
  /// See also [timings].
  const TimingsFamily();

  /// See also [timings].
  TimingsProvider call({
    required double lat,
    required double lng,
    required int method,
  }) {
    return TimingsProvider(
      lat: lat,
      lng: lng,
      method: method,
    );
  }

  @override
  TimingsProvider getProviderOverride(
    covariant TimingsProvider provider,
  ) {
    return call(
      lat: provider.lat,
      lng: provider.lng,
      method: provider.method,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'timingsProvider';
}

/// See also [timings].
class TimingsProvider extends AutoDisposeFutureProvider<AlAdhanTimings> {
  /// See also [timings].
  TimingsProvider({
    required double lat,
    required double lng,
    required int method,
  }) : this._internal(
          (ref) => timings(
            ref as TimingsRef,
            lat: lat,
            lng: lng,
            method: method,
          ),
          from: timingsProvider,
          name: r'timingsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$timingsHash,
          dependencies: TimingsFamily._dependencies,
          allTransitiveDependencies: TimingsFamily._allTransitiveDependencies,
          lat: lat,
          lng: lng,
          method: method,
        );

  TimingsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.lat,
    required this.lng,
    required this.method,
  }) : super.internal();

  final double lat;
  final double lng;
  final int method;

  @override
  Override overrideWith(
    FutureOr<AlAdhanTimings> Function(TimingsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TimingsProvider._internal(
        (ref) => create(ref as TimingsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        lat: lat,
        lng: lng,
        method: method,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<AlAdhanTimings> createElement() {
    return _TimingsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TimingsProvider &&
        other.lat == lat &&
        other.lng == lng &&
        other.method == method;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, lat.hashCode);
    hash = _SystemHash.combine(hash, lng.hashCode);
    hash = _SystemHash.combine(hash, method.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TimingsRef on AutoDisposeFutureProviderRef<AlAdhanTimings> {
  /// The parameter `lat` of this provider.
  double get lat;

  /// The parameter `lng` of this provider.
  double get lng;

  /// The parameter `method` of this provider.
  int get method;
}

class _TimingsProviderElement
    extends AutoDisposeFutureProviderElement<AlAdhanTimings> with TimingsRef {
  _TimingsProviderElement(super.provider);

  @override
  double get lat => (origin as TimingsProvider).lat;
  @override
  double get lng => (origin as TimingsProvider).lng;
  @override
  int get method => (origin as TimingsProvider).method;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
