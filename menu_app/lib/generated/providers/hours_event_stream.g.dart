// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../providers/hours_event_stream.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(hallHoursEvents)
const hallHoursEventsProvider = HallHoursEventsFamily._();

final class HallHoursEventsProvider
    extends $FunctionalProvider<AsyncValue<String>, String, Stream<String>>
    with $FutureModifier<String>, $StreamProvider<String> {
  const HallHoursEventsProvider._(
      {required HallHoursEventsFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'hallHoursEventsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$hallHoursEventsHash();

  @override
  String toString() {
    return r'hallHoursEventsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<String> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<String> create(Ref ref) {
    final argument = this.argument as String;
    return hallHoursEvents(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is HallHoursEventsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$hallHoursEventsHash() => r'9bb5eff713e6c0205b0491164506588ddf8fae68';

final class HallHoursEventsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<String>, String> {
  const HallHoursEventsFamily._()
      : super(
          retry: null,
          name: r'hallHoursEventsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  HallHoursEventsProvider call(
    String hallName,
  ) =>
      HallHoursEventsProvider._(argument: hallName, from: this);

  @override
  String toString() => r'hallHoursEventsProvider';
}
