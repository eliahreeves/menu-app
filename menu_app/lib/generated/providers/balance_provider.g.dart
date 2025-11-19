// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../providers/balance_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GetBalance)
const getBalanceProvider = GetBalanceProvider._();

final class GetBalanceProvider
    extends $AsyncNotifierProvider<GetBalance, double> {
  const GetBalanceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'getBalanceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$getBalanceHash();

  @$internal
  @override
  GetBalance create() => GetBalance();
}

String _$getBalanceHash() => r'd54dee938f7ab51cf6cf8caa908284a286e42a0f';

abstract class _$GetBalance extends $AsyncNotifier<double> {
  FutureOr<double> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<double>, double>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<double>, double>,
        AsyncValue<double>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
