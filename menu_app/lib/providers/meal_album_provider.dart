import 'dart:async';

import 'package:menu_app/utilities/constants.dart' as c;
import 'package:menu_app/models/menus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part '../generated/providers/meal_album_provider.g.dart';

@Riverpod(keepAlive: true)
class MealAlbum extends _$MealAlbum {
  Timer? _timer;

  @override
  Future<List<FoodCategory>> build(String college, String mealTime,
      {String cat = "", String day = "Today"}) async {
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

    return await fetchAlbum(college, mealTime, cat: cat, day: day);
  }
}
