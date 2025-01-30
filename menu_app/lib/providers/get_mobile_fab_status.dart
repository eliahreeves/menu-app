import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:menu_app/utilities/prefs_service.dart';
part '../generated/providers/get_mobile_fab_status.g.dart';

@Riverpod(keepAlive: true)
class GetMobileFabStatus extends _$GetMobileFabStatus {
  @override
  bool build() {
    return PrefsService.instance.getBool('get_mobile_fab_status') ?? true;
  }

  void setBool(bool val) {
    state = val;
    PrefsService.instance.setBool('get_mobile_fab_status', val);
  }
}
