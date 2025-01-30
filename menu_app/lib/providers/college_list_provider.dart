import 'package:menu_app/utilities/constants.dart' as c;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:menu_app/utilities/prefs_service.dart';
part '../generated/providers/college_list_provider.g.dart';

@Riverpod(keepAlive: true)
class CollegeList extends _$CollegeList {
  @override
  List<c.Colleges> build() {
    const colleges = c.Colleges.values;
    final prefs = PrefsService.instance;
    final order = prefs.getStringList('colleges_order');

    if (order == null) {
      return colleges;
    }
    return order
        .map((item) => colleges.firstWhere((col) => col.id == item))
        .toList(growable: false);
  }

  void reorderData(int oldindex, int newindex) {
    if (newindex > oldindex) {
      newindex -= 1;
    }
    final stateCopy = [...state];
    final items = stateCopy.removeAt(oldindex);
    stateCopy.insert(newindex, items);
    state = stateCopy;
    PrefsService.instance.setStringList(
        'colleges_order', stateCopy.map((item) => item.id).toList());
  }
}
