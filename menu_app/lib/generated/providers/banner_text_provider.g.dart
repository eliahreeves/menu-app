// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../providers/banner_text_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BannerText)
const bannerTextProvider = BannerTextProvider._();

final class BannerTextProvider
    extends $AsyncNotifierProvider<BannerText, String> {
  const BannerTextProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'bannerTextProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$bannerTextHash();

  @$internal
  @override
  BannerText create() => BannerText();
}

String _$bannerTextHash() => r'22ac4d6177981a38beeb34a67a23fb5408e74fde';

abstract class _$BannerText extends $AsyncNotifier<String> {
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
