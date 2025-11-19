// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../providers/meal_album_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MealAlbum)
const mealAlbumProvider = MealAlbumFamily._();

final class MealAlbumProvider
    extends $AsyncNotifierProvider<MealAlbum, List<FoodCategory>> {
  const MealAlbumProvider._(
      {required MealAlbumFamily super.from,
      required (
        String,
        String, {
        String cat,
        String day,
      })
          super.argument})
      : super(
          retry: null,
          name: r'mealAlbumProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$mealAlbumHash();

  @override
  String toString() {
    return r'mealAlbumProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  MealAlbum create() => MealAlbum();

  @override
  bool operator ==(Object other) {
    return other is MealAlbumProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$mealAlbumHash() => r'f56d1a3cb7b940ec53907a289cbcd2ba0b2c0ed8';

final class MealAlbumFamily extends $Family
    with
        $ClassFamilyOverride<
            MealAlbum,
            AsyncValue<List<FoodCategory>>,
            List<FoodCategory>,
            FutureOr<List<FoodCategory>>,
            (
              String,
              String, {
              String cat,
              String day,
            })> {
  const MealAlbumFamily._()
      : super(
          retry: null,
          name: r'mealAlbumProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: false,
        );

  MealAlbumProvider call(
    String college,
    String mealTime, {
    String cat = '',
    String day = 'Today',
  }) =>
      MealAlbumProvider._(argument: (
        college,
        mealTime,
        cat: cat,
        day: day,
      ), from: this);

  @override
  String toString() => r'mealAlbumProvider';
}

abstract class _$MealAlbum extends $AsyncNotifier<List<FoodCategory>> {
  late final _$args = ref.$arg as (
    String,
    String, {
    String cat,
    String day,
  });
  String get college => _$args.$1;
  String get mealTime => _$args.$2;
  String get cat => _$args.cat;
  String get day => _$args.day;

  FutureOr<List<FoodCategory>> build(
    String college,
    String mealTime, {
    String cat = '',
    String day = 'Today',
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      _$args.$1,
      _$args.$2,
      cat: _$args.cat,
      day: _$args.day,
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
