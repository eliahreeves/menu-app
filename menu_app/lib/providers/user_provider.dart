import 'package:get_mobile_interface/get_mobile_interface.dart';
import 'package:menu_app/providers/get_auth_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../generated/providers/user_provider.g.dart';

@riverpod
class GetUser extends _$GetUser {
  @override
  String? build() {
    _fetchName();
    return null;
  }

  Future<void> _fetchName() async {
    final sessionId = ref.watch(authNotifierProvider).sessionId;

    if (sessionId == null) {
      return;
    }

    final name = await getName(sessionId);
    if(name == null) return;
    state = name;
  }
}
