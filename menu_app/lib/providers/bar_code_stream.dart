import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:get_mobile_interface/get_mobile_interface.dart';

final barCodeStream =
    StreamProvider.autoDispose.family<String, String?>((ref, session) async* {
  while (true) {
    yield await getBarcode(session);
    await Future<void>.delayed(const Duration(seconds: 5));
  }
});
