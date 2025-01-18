import 'dart:convert';

import 'package:menu_app/providers/get_auth_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

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

    final url = Uri.parse(
        "https://services.get.cbord.com/GETServices/services/json/user");
    final headers = {
      "accept": "application/json",
      "content-type": "application/json",
    };
    final payload = jsonEncode({
      "method": "retrieve",
      "params": {
        "sessionId": sessionId,
      },
    });

    final response = await http.post(url, headers: headers, body: payload);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      // List<dynamic> firstName = data["response"]["firstName"];
      // List<dynamic> lastName = data["response"]["lastName"];
      if (data["response"] == null) {
        return;
      }
      state =
          "${data["response"]["firstName"]} ${data["response"]["lastName"]}";
    }
  }
}
