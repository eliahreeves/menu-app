// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../providers/meal_album_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$mealAlbumHash() => r'f56d1a3cb7b940ec53907a289cbcd2ba0b2c0ed8';

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

abstract class _$MealAlbum extends BuildlessAsyncNotifier<List<FoodCategory>> {
  late final String college;
  late final String mealTime;
  late final String cat;
  late final String day;

  FutureOr<List<FoodCategory>> build(
    String college,
    String mealTime, {
    String cat = "",
    String day = "Today",
  });
}

/// See also [MealAlbum].
@ProviderFor(MealAlbum)
const mealAlbumProvider = MealAlbumFamily();

/// See also [MealAlbum].
class MealAlbumFamily extends Family<AsyncValue<List<FoodCategory>>> {
  /// See also [MealAlbum].
  const MealAlbumFamily();

  /// See also [MealAlbum].
  MealAlbumProvider call(
    String college,
    String mealTime, {
    String cat = "",
    String day = "Today",
  }) {
    return MealAlbumProvider(
      college,
      mealTime,
      cat: cat,
      day: day,
    );
  }

  @override
  MealAlbumProvider getProviderOverride(
    covariant MealAlbumProvider provider,
  ) {
    return call(
      provider.college,
      provider.mealTime,
      cat: provider.cat,
      day: provider.day,
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
  String? get name => r'mealAlbumProvider';
}

/// See also [MealAlbum].
class MealAlbumProvider
    extends AsyncNotifierProviderImpl<MealAlbum, List<FoodCategory>> {
  /// See also [MealAlbum].
  MealAlbumProvider(
    String college,
    String mealTime, {
    String cat = "",
    String day = "Today",
  }) : this._internal(
          () => MealAlbum()
            ..college = college
            ..mealTime = mealTime
            ..cat = cat
            ..day = day,
          from: mealAlbumProvider,
          name: r'mealAlbumProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$mealAlbumHash,
          dependencies: MealAlbumFamily._dependencies,
          allTransitiveDependencies: MealAlbumFamily._allTransitiveDependencies,
          college: college,
          mealTime: mealTime,
          cat: cat,
          day: day,
        );

  MealAlbumProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.college,
    required this.mealTime,
    required this.cat,
    required this.day,
  }) : super.internal();

  final String college;
  final String mealTime;
  final String cat;
  final String day;

  @override
  FutureOr<List<FoodCategory>> runNotifierBuild(
    covariant MealAlbum notifier,
  ) {
    return notifier.build(
      college,
      mealTime,
      cat: cat,
      day: day,
    );
  }

  @override
  Override overrideWith(MealAlbum Function() create) {
    return ProviderOverride(
      origin: this,
      override: MealAlbumProvider._internal(
        () => create()
          ..college = college
          ..mealTime = mealTime
          ..cat = cat
          ..day = day,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        college: college,
        mealTime: mealTime,
        cat: cat,
        day: day,
      ),
    );
  }

  @override
  AsyncNotifierProviderElement<MealAlbum, List<FoodCategory>> createElement() {
    return _MealAlbumProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MealAlbumProvider &&
        other.college == college &&
        other.mealTime == mealTime &&
        other.cat == cat &&
        other.day == day;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, college.hashCode);
    hash = _SystemHash.combine(hash, mealTime.hashCode);
    hash = _SystemHash.combine(hash, cat.hashCode);
    hash = _SystemHash.combine(hash, day.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MealAlbumRef on AsyncNotifierProviderRef<List<FoodCategory>> {
  /// The parameter `college` of this provider.
  String get college;

  /// The parameter `mealTime` of this provider.
  String get mealTime;

  /// The parameter `cat` of this provider.
  String get cat;

  /// The parameter `day` of this provider.
  String get day;
}

class _MealAlbumProviderElement
    extends AsyncNotifierProviderElement<MealAlbum, List<FoodCategory>>
    with MealAlbumRef {
  _MealAlbumProviderElement(super.provider);

  @override
  String get college => (origin as MealAlbumProvider).college;
  @override
  String get mealTime => (origin as MealAlbumProvider).mealTime;
  @override
  String get cat => (origin as MealAlbumProvider).cat;
  @override
  String get day => (origin as MealAlbumProvider).day;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
