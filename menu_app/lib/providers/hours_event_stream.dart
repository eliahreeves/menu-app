

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:menu_app/models/menus.dart';
import 'package:menu_app/providers/hours_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../generated/providers/hours_event_stream.g.dart';

@riverpod
Stream<String> hallHoursEvents(Ref ref, String hallName) async* {
  //inner funtions
  int getEventIndex(DateTime now, List<HoursEvent> events) {
    if (now.hour < events[0].time.hour ||
        (now.hour == events[0].time.hour &&
            now.minute < events[0].time.minute)) {
      return events.length - 1;
    }
    for (int i = 0; i < events.length - 1; i++) {
      final event = events[i + 1];

      if (now.hour < event.time.hour) {
        return i;
      } else if (now.hour == event.time.hour &&
          now.minute < event.time.minute) {
        return i;
      }
    }
    return events.length - 1;
  }

  String getText(Map<String, List<HoursEvent>>? hours) {
    if (hours != null) {
      final DateTime now = DateTime.now();
      final String dayName = DateFormat('EEEE').format(now);
      final events = hours[dayName];
      if (events != null) {
        final currentPhaseIndex = getEventIndex(now, events);
        final nextPhaseIndex = currentPhaseIndex == (events.length - 1)
            ? 0
            : currentPhaseIndex + 1;
        final timeDif = DateTime(
                now.year,
                now.month,
                now.day,
                events[nextPhaseIndex].time.hour,
                events[nextPhaseIndex].time.minute)
            .difference(now);
        if (timeDif <= const Duration(minutes: 30) && !timeDif.isNegative) {
          final eventName =
              events[nextPhaseIndex].name.startsWith("Continuous Dining")
                  ? "Continuous Dining"
                  : events[nextPhaseIndex].name;
          return "${timeDif.inMinutes}m to $eventName";
        }
        final eventName =
            events[currentPhaseIndex].name.startsWith("Continuous Dining")
                ? "Continuous Dining"
                : events[currentPhaseIndex].name;
        return eventName;
      }
    } else {
      return "Error";
    }
    return "Closed";
  }

  //logic
  yield "Loading...";
  final hours = await ref.watch(hallHoursProvider(hallName).future);

  while (true) {
    yield getText(hours);
    await Future.delayed(Duration(seconds: (60 - DateTime.now().second) + 60));
  }
}

