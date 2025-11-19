// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../providers/update_time_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UpdateTime)
const updateTimeProvider = UpdateTimeProvider._();

final class UpdateTimeProvider
    extends $AsyncNotifierProvider<UpdateTime, String> {
  const UpdateTimeProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'updateTimeProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$updateTimeHash();

  @$internal
  @override
  UpdateTime create() => UpdateTime();
}

String _$updateTimeHash() => r'f3378d9f8a2d25760752ab28d965970127843577';

abstract class _$UpdateTime extends $AsyncNotifier<String> {
  FutureOr<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<String>, String>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<String>, String>,
        AsyncValue<String>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
