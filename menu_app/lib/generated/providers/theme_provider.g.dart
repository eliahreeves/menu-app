// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../providers/theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ThemeNotifier)
const themeProvider = ThemeNotifierProvider._();

final class ThemeNotifierProvider
    extends $NotifierProvider<ThemeNotifier, AppThemeData> {
  const ThemeNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'themeProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$themeNotifierHash();

  @$internal
  @override
  ThemeNotifier create() => ThemeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppThemeData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppThemeData>(value),
    );
  }
}

String _$themeNotifierHash() => r'769b86a1c81dcc60d7d73beb7480827e3e979bcd';

abstract class _$ThemeNotifier extends $Notifier<AppThemeData> {
  AppThemeData build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AppThemeData, AppThemeData>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AppThemeData, AppThemeData>,
        AppThemeData,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
