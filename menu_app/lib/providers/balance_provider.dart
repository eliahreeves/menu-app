import 'dart:async';
import 'package:menu_app/providers/get_auth_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:get_mobile_interface/get_mobile_interface.dart';

part '../generated/providers/balance_provider.g.dart';



@riverpod
class GetBalance extends _$GetBalance {
  @override
  Future<double> build() async {
    final sessionId = ref.watch(authNotifierProvider).sessionId;
    if (sessionId == null) {
      throw Exception("No session ID found");
    }
    return await getBalance(sessionId);
  }
}

