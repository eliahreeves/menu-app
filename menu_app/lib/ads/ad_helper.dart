import 'package:shared_preferences/shared_preferences.dart';

Future<bool> getAdBool() async {
  final prefs = await SharedPreferences.getInstance();
  bool? adBool = prefs.getBool('showAd');

  return adBool ?? true;
}