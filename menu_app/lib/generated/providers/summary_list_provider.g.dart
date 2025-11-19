// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../providers/summary_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SummaryListData)
const summaryListDataProvider = SummaryListDataFamily._();

final class SummaryListDataProvider
    extends $AsyncNotifierProvider<SummaryListData, List<FoodCategory>> {
  const SummaryListDataProvider._(
      {required SummaryListDataFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'summaryListDataProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$summaryListDataHash();

  @override
  String toString() {
    return r'summaryListDataProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SummaryListData create() => SummaryListData();

  @override
  bool operator ==(Object other) {
    return other is SummaryListDataProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$summaryListDataHash() => r'e26335913dd7ece77485bd471e174b7dd08a62bb';

final class SummaryListDataFamily extends $Family
    with
        $ClassFamilyOverride<SummaryListData, AsyncValue<List<FoodCategory>>,
            List<FoodCategory>, FutureOr<List<FoodCategory>>, String> {
  const SummaryListDataFamily._()
      : super(
          retry: null,
          name: r'summaryListDataProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: false,
        );

  SummaryListDataProvider call(
    String mealTime,
  ) =>
      SummaryListDataProvider._(argument: mealTime, from: this);

  @override
  String toString() => r'summaryListDataProvider';
}

abstract class _$SummaryListData extends $AsyncNotifier<List<FoodCategory>> {
  late final _$args = ref.$arg as String;
  String get mealTime => _$args;

  FutureOr<List<FoodCategory>> build(
    String mealTime,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      _$args,
    );
    final ref =
        this.ref as $Ref<AsyncValue<List<FoodCategory>>, List<FoodCategory>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<FoodCategory>>, List<FoodCategory>>,
        AsyncValue<List<FoodCategory>>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
