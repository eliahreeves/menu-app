import 'dart:async';
import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

final barCodeStream =
    StreamProvider.autoDispose.family<String, String?>((ref, session) async* {
  Future<String> fetchBarcode(String? sessionId) async {
    if (sessionId == null) {
      return '';
    }
    final url = Uri.parse(
        "https://services.get.cbord.com/GETServices/services/json/authentication");
    final headers = {
      "accept": "application/json",
      "content-type": "application/json",
    };
    final payload = jsonEncode({
      "method": "retrievePatronBarcodePayload",
      "params": {
        "sessionId": sessionId,
      },
    });

    try {
      final response = await http.post(url, headers: headers, body: payload);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return data["response"] as String;
      } else {
        throw Exception(
            "Failed to retrieve barcode. Status code: ${response.statusCode}");
      }
    } catch (e) {
      return '';
    }
  }

  while (true) {
    yield await fetchBarcode(session);
    await Future<void>.delayed(const Duration(seconds: 5));
  }
});
