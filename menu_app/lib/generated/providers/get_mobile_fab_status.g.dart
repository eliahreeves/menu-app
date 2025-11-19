// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../providers/get_mobile_fab_status.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GetMobileFabStatus)
const getMobileFabStatusProvider = GetMobileFabStatusProvider._();

final class GetMobileFabStatusProvider
    extends $NotifierProvider<GetMobileFabStatus, bool> {
  const GetMobileFabStatusProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'getMobileFabStatusProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$getMobileFabStatusHash();

  @$internal
  @override
  GetMobileFabStatus create() => GetMobileFabStatus();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$getMobileFabStatusHash() =>
    r'91f9afa6ea3f699c6606aa90a7a97f3058ab0ce4';

abstract class _$GetMobileFabStatus extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<bool, bool>, bool, Object?, Object?>;
    element.handleValue(ref, created);
  }
}
