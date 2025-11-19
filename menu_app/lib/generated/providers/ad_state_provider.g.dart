// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../providers/ad_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AdStateNotifier)
const adStateProvider = AdStateNotifierProvider._();

final class AdStateNotifierProvider
    extends $NotifierProvider<AdStateNotifier, AdState> {
  const AdStateNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'adStateProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$adStateNotifierHash();

  @$internal
  @override
  AdStateNotifier create() => AdStateNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdState>(value),
    );
  }
}

String _$adStateNotifierHash() => r'b02c5dce3b80a78a9feb94bf8eb40e82cdb3e95a';

abstract class _$AdStateNotifier extends $Notifier<AdState> {
  AdState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AdState, AdState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AdState, AdState>, AdState, Object?, Object?>;
    element.handleValue(ref, created);
  }
}
