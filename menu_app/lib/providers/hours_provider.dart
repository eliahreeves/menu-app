import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:menu_app/models/menus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../generated/providers/hours_provider.g.dart';

@Riverpod(keepAlive: true)
Future<Map<String, List<HoursEvent>>> hallHours(Ref ref, String hallName) async {
  return await fetchEventHours(hallName);
}