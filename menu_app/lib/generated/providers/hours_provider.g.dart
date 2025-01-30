// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../providers/hours_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$hallHoursHash() => r'5402355ab53bf604d7293987c19c5f9cdcb489d4';

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

/// See also [hallHours].
@ProviderFor(hallHours)
const hallHoursProvider = HallHoursFamily();

/// See also [hallHours].
class HallHoursFamily
    extends Family<AsyncValue<Map<String, List<HoursEvent>>>> {
  /// See also [hallHours].
  const HallHoursFamily();

  /// See also [hallHours].
  HallHoursProvider call(
    String hallName,
  ) {
    return HallHoursProvider(
      hallName,
    );
  }

  @override
  HallHoursProvider getProviderOverride(
    covariant HallHoursProvider provider,
  ) {
    return call(
      provider.hallName,
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
  String? get name => r'hallHoursProvider';
}

/// See also [hallHours].
class HallHoursProvider extends FutureProvider<Map<String, List<HoursEvent>>> {
  /// See also [hallHours].
  HallHoursProvider(
    String hallName,
  ) : this._internal(
          (ref) => hallHours(
            ref as HallHoursRef,
            hallName,
          ),
          from: hallHoursProvider,
          name: r'hallHoursProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$hallHoursHash,
          dependencies: HallHoursFamily._dependencies,
          allTransitiveDependencies: HallHoursFamily._allTransitiveDependencies,
          hallName: hallName,
        );

  HallHoursProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.hallName,
  }) : super.internal();

  final String hallName;

  @override
  Override overrideWith(
    FutureOr<Map<String, List<HoursEvent>>> Function(HallHoursRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HallHoursProvider._internal(
        (ref) => create(ref as HallHoursRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        hallName: hallName,
      ),
    );
  }

  @override
  FutureProviderElement<Map<String, List<HoursEvent>>> createElement() {
    return _HallHoursProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HallHoursProvider && other.hallName == hallName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, hallName.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin HallHoursRef on FutureProviderRef<Map<String, List<HoursEvent>>> {
  /// The parameter `hallName` of this provider.
  String get hallName;
}

class _HallHoursProviderElement
    extends FutureProviderElement<Map<String, List<HoursEvent>>>
    with HallHoursRef {
  _HallHoursProviderElement(super.provider);

  @override
  String get hallName => (origin as HallHoursProvider).hallName;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
