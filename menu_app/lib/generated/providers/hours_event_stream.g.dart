// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../providers/hours_event_stream.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$hallHoursEventsHash() => r'9bb5eff713e6c0205b0491164506588ddf8fae68';

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

/// See also [hallHoursEvents].
@ProviderFor(hallHoursEvents)
const hallHoursEventsProvider = HallHoursEventsFamily();

/// See also [hallHoursEvents].
class HallHoursEventsFamily extends Family<AsyncValue<String>> {
  /// See also [hallHoursEvents].
  const HallHoursEventsFamily();

  /// See also [hallHoursEvents].
  HallHoursEventsProvider call(
    String hallName,
  ) {
    return HallHoursEventsProvider(
      hallName,
    );
  }

  @override
  HallHoursEventsProvider getProviderOverride(
    covariant HallHoursEventsProvider provider,
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
  String? get name => r'hallHoursEventsProvider';
}

/// See also [hallHoursEvents].
class HallHoursEventsProvider extends AutoDisposeStreamProvider<String> {
  /// See also [hallHoursEvents].
  HallHoursEventsProvider(
    String hallName,
  ) : this._internal(
          (ref) => hallHoursEvents(
            ref as HallHoursEventsRef,
            hallName,
          ),
          from: hallHoursEventsProvider,
          name: r'hallHoursEventsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$hallHoursEventsHash,
          dependencies: HallHoursEventsFamily._dependencies,
          allTransitiveDependencies:
              HallHoursEventsFamily._allTransitiveDependencies,
          hallName: hallName,
        );

  HallHoursEventsProvider._internal(
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
    Stream<String> Function(HallHoursEventsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HallHoursEventsProvider._internal(
        (ref) => create(ref as HallHoursEventsRef),
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
  AutoDisposeStreamProviderElement<String> createElement() {
    return _HallHoursEventsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HallHoursEventsProvider && other.hallName == hallName;
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
mixin HallHoursEventsRef on AutoDisposeStreamProviderRef<String> {
  /// The parameter `hallName` of this provider.
  String get hallName;
}

class _HallHoursEventsProviderElement
    extends AutoDisposeStreamProviderElement<String> with HallHoursEventsRef {
  _HallHoursEventsProviderElement(super.provider);

  @override
  String get hallName => (origin as HallHoursEventsProvider).hallName;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
