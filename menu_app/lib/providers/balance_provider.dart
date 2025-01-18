import 'dart:convert';
import 'dart:async';
import 'package:menu_app/providers/get_auth_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part '../generated/providers/balance_provider.g.dart';

class NoAccountException implements Exception {
  final String message;
  NoAccountException(this.message);

  @override
  String toString() => "NoAccountException: $message";
}

@riverpod
class GetBalance extends _$GetBalance {
  @override
  Future<double> build() async {
    final sessionId = ref.watch(authNotifierProvider).sessionId;
    if (sessionId == null) {
      throw Exception("No session ID found");
    }

    final url = Uri.parse(
        "https://services.get.cbord.com/GETServices/services/json/commerce");
    final headers = {
      "accept": "application/json",
      "content-type": "application/json",
    };
    final payload = jsonEncode({
      "method": "retrieveAccounts",
      "params": {
        "sessionId": sessionId,
      },
    });

    final response = await http.post(url, headers: headers, body: payload);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      if (data["response"] == null) {
        throw Exception(
            "Failed to retrieve balance. Status code: ${response.statusCode}");
      }

      List<dynamic> accounts = data["response"]["accounts"];
      dynamic account = accounts.firstWhere(
        (acc) => acc['accountDisplayName'] == 'Slug Points',
        orElse: () => null,
      );

      if (account != null) {
        return account["balance"].toDouble();
      } else {
        throw NoAccountException("No account found with the name 'Slug Points'");
      }

    }
    throw Exception("Failed to retrieve balance. Status code: ${response.statusCode}");
  }
}

