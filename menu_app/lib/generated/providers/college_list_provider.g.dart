// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../providers/college_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CollegeList)
const collegeListProvider = CollegeListProvider._();

final class CollegeListProvider
    extends $NotifierProvider<CollegeList, List<c.Colleges>> {
  const CollegeListProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'collegeListProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$collegeListHash();

  @$internal
  @override
  CollegeList create() => CollegeList();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<c.Colleges> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<c.Colleges>>(value),
    );
  }
}

String _$collegeListHash() => r'3d91c29c962dd20ad810a511cafb8d90a2c2ea5a';

abstract class _$CollegeList extends $Notifier<List<c.Colleges>> {
  List<c.Colleges> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<c.Colleges>, List<c.Colleges>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<List<c.Colleges>, List<c.Colleges>>,
        List<c.Colleges>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
