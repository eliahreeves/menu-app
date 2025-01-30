import 'package:menu_app/utilities/prefs_service.dart';

bool getAdBool() {
  final prefs = PrefsService.instance;
  bool? adBool = prefs.getBool('showAd');

  return adBool ?? true;
}
