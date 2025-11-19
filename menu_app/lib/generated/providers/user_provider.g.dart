// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../providers/user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GetUser)
const getUserProvider = GetUserProvider._();

final class GetUserProvider extends $NotifierProvider<GetUser, String?> {
  const GetUserProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'getUserProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$getUserHash();

  @$internal
  @override
  GetUser create() => GetUser();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$getUserHash() => r'048b49e4be8043b3c1f59387805e64660eb58ce4';

abstract class _$GetUser extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String?, String?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<String?, String?>, String?, Object?, Object?>;
    element.handleValue(ref, created);
  }
}
