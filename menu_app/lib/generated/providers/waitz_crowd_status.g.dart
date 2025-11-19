// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../providers/waitz_crowd_status.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WaitzCrowdStatus)
const waitzCrowdStatusProvider = WaitzCrowdStatusProvider._();

final class WaitzCrowdStatusProvider
    extends $AsyncNotifierProvider<WaitzCrowdStatus, Map<String, int>> {
  const WaitzCrowdStatusProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'waitzCrowdStatusProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$waitzCrowdStatusHash();

  @$internal
  @override
  WaitzCrowdStatus create() => WaitzCrowdStatus();
}

String _$waitzCrowdStatusHash() => r'95b3767c852570f9e2c7f736fae1c1edf8167444';

abstract class _$WaitzCrowdStatus extends $AsyncNotifier<Map<String, int>> {
  FutureOr<Map<String, int>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<Map<String, int>>, Map<String, int>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<Map<String, int>>, Map<String, int>>,
        AsyncValue<Map<String, int>>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
