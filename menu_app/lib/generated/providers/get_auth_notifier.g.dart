// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../providers/get_auth_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AuthNotifier)
const authProvider = AuthNotifierProvider._();

final class AuthNotifierProvider
    extends $NotifierProvider<AuthNotifier, GetAuth> {
  const AuthNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'authProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$authNotifierHash();

  @$internal
  @override
  AuthNotifier create() => AuthNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetAuth value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetAuth>(value),
    );
  }
}

String _$authNotifierHash() => r'130ab49ea90af8aa206600809db672ad74dcdb73';

abstract class _$AuthNotifier extends $Notifier<GetAuth> {
  GetAuth build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<GetAuth, GetAuth>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<GetAuth, GetAuth>, GetAuth, Object?, Object?>;
    element.handleValue(ref, created);
  }
}
