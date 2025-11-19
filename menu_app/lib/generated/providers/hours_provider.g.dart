// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../providers/hours_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(hallHours)
const hallHoursProvider = HallHoursFamily._();

final class HallHoursProvider extends $FunctionalProvider<
        AsyncValue<Map<String, List<HoursEvent>>>,
        Map<String, List<HoursEvent>>,
        FutureOr<Map<String, List<HoursEvent>>>>
    with
        $FutureModifier<Map<String, List<HoursEvent>>>,
        $FutureProvider<Map<String, List<HoursEvent>>> {
  const HallHoursProvider._(
      {required HallHoursFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'hallHoursProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$hallHoursHash();

  @override
  String toString() {
    return r'hallHoursProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Map<String, List<HoursEvent>>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, List<HoursEvent>>> create(Ref ref) {
    final argument = this.argument as String;
    return hallHours(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is HallHoursProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$hallHoursHash() => r'5402355ab53bf604d7293987c19c5f9cdcb489d4';

final class HallHoursFamily extends $Family
    with
        $FunctionalFamilyOverride<FutureOr<Map<String, List<HoursEvent>>>,
            String> {
  const HallHoursFamily._()
      : super(
          retry: null,
          name: r'hallHoursProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: false,
        );

  HallHoursProvider call(
    String hallName,
  ) =>
      HallHoursProvider._(argument: hallName, from: this);

  @override
  String toString() => r'hallHoursProvider';
}
