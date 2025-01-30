import 'dart:async';
import 'dart:convert';
import 'package:menu_app/utilities/constants.dart' as c;
import 'package:http/http.dart';
import 'package:menu_app/models/menus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../generated/providers/waitz_crowd_status.g.dart';

@Riverpod(keepAlive: true)
class WaitzCrowdStatus extends _$WaitzCrowdStatus {
  Timer? _timer;
  @override
  Future<Map<String, int>> build() async {
    ref.onDispose(() {
      _timer?.cancel();
    });

    ref.onCancel(() {
      _timer = Timer(const Duration(minutes: c.provTTL), () {
        ref.invalidateSelf();
      });
    });

    ref.onResume(() {
      _timer?.cancel();
    });

    final response = await get(Uri.parse('https://waitz.io/live/ucsc'));
    Map<String, String> locations = await fetchWaitzMap();
    Map<String, int> waitz = {};

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<dynamic> waitzJson = jsonData['data'];

      for (final waitzData in waitzJson) {
        WaitzData loc = WaitzData.fromJson(waitzData);
        waitz[loc.name] = loc.busyness;
      }
      Map<String, int> busyness = {};
      for (final college in c.Colleges.values) {
        busyness[college.id] = waitz[locations[college.id]!]!;
      }
      return busyness;
    } else {
      throw Exception('Failed to load waitz');
    }
  }
}
