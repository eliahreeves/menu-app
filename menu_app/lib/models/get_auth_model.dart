import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part '../generated/models/get_auth_model.freezed.dart';

@freezed
class GetAuth with _$GetAuth {
  factory GetAuth({
    required String? sessionId,
    required String? deviceId,
  }) = _GetAuth;
}
