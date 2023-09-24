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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
