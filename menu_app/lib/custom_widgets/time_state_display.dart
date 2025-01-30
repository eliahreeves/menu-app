
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:menu_app/providers/hours_event_stream.dart';

class WaitzIndicator extends StatelessWidget {
  const WaitzIndicator({
    super.key,
    this.number,
  });
  final num? number;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (number != null)
          const SizedBox(
            height: 4,
          ),
        if (number != null)
          SizedBox(
            width: 80,
            child: LinearProgressIndicator(
              backgroundColor: Theme.of(context).colorScheme.surface,
              // Use the busyness data for this college
              value: number!.toDouble() / 100,
              color: number! < 40
                  ? Colors.green
                  : (number! < 75 ? Colors.orange : Colors.red),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        if (number != null)
          const SizedBox(
            height: 10,
          ),
      ],
    );
  }
}



class TimeStateDisplay extends ConsumerWidget {
  final String name;
  final num? waitzNum;
  const TimeStateDisplay({
    super.key,
    required this.name,
    required this.waitzNum,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeState = ref.watch(hallHoursEventsProvider(name));
    return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Text(
        timeState.value ?? "Loading...",
        style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary, fontSize: 14),
      ),
      if (timeState.value != "Closed" && waitzNum != 0)
        WaitzIndicator(
          number: waitzNum,
        )
    ]);
  }
}
