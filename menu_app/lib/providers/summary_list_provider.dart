import 'dart:async';

import 'package:menu_app/providers/college_list_provider.dart';
import 'package:menu_app/utilities/constants.dart' as c;
import 'package:menu_app/models/menus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../generated/providers/summary_list_provider.g.dart';

@Riverpod(keepAlive: true)
class SummaryListData extends _$SummaryListData {
  Timer? _timer;

  @override
  Future<List<FoodCategory>> build(String mealTime) async {
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
    final collegesList =
        ref.watch(collegeListProvider).map((item) => item.id).toList();
    return await fetchSummaryList(collegesList, mealTime);
  }
}
