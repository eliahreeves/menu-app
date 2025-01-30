// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../providers/summary_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$summaryListDataHash() => r'e26335913dd7ece77485bd471e174b7dd08a62bb';

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

abstract class _$SummaryListData
    extends BuildlessAsyncNotifier<List<FoodCategory>> {
  late final String mealTime;

  FutureOr<List<FoodCategory>> build(
    String mealTime,
  );
}

/// See also [SummaryListData].
@ProviderFor(SummaryListData)
const summaryListDataProvider = SummaryListDataFamily();

/// See also [SummaryListData].
class SummaryListDataFamily extends Family<AsyncValue<List<FoodCategory>>> {
  /// See also [SummaryListData].
  const SummaryListDataFamily();

  /// See also [SummaryListData].
  SummaryListDataProvider call(
    String mealTime,
  ) {
    return SummaryListDataProvider(
      mealTime,
    );
  }

  @override
  SummaryListDataProvider getProviderOverride(
    covariant SummaryListDataProvider provider,
  ) {
    return call(
      provider.mealTime,
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
  String? get name => r'summaryListDataProvider';
}

/// See also [SummaryListData].
class SummaryListDataProvider
    extends AsyncNotifierProviderImpl<SummaryListData, List<FoodCategory>> {
  /// See also [SummaryListData].
  SummaryListDataProvider(
    String mealTime,
  ) : this._internal(
          () => SummaryListData()..mealTime = mealTime,
          from: summaryListDataProvider,
          name: r'summaryListDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$summaryListDataHash,
          dependencies: SummaryListDataFamily._dependencies,
          allTransitiveDependencies:
              SummaryListDataFamily._allTransitiveDependencies,
          mealTime: mealTime,
        );

  SummaryListDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.mealTime,
  }) : super.internal();

  final String mealTime;

  @override
  FutureOr<List<FoodCategory>> runNotifierBuild(
    covariant SummaryListData notifier,
  ) {
    return notifier.build(
      mealTime,
    );
  }

  @override
  Override overrideWith(SummaryListData Function() create) {
    return ProviderOverride(
      origin: this,
      override: SummaryListDataProvider._internal(
        () => create()..mealTime = mealTime,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        mealTime: mealTime,
      ),
    );
  }

  @override
  AsyncNotifierProviderElement<SummaryListData, List<FoodCategory>>
      createElement() {
    return _SummaryListDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SummaryListDataProvider && other.mealTime == mealTime;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, mealTime.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SummaryListDataRef on AsyncNotifierProviderRef<List<FoodCategory>> {
  /// The parameter `mealTime` of this provider.
  String get mealTime;
}

class _SummaryListDataProviderElement
    extends AsyncNotifierProviderElement<SummaryListData, List<FoodCategory>>
    with SummaryListDataRef {
  _SummaryListDataProviderElement(super.provider);

  @override
  String get mealTime => (origin as SummaryListDataProvider).mealTime;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
