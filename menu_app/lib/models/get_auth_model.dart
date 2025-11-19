class GetAuth {
  final String? sessionId;
  final String? deviceId;
  const GetAuth({this.sessionId, this.deviceId});

  GetAuth copyWith({String? sessionId, String? deviceId}) {
    return GetAuth(
      sessionId: sessionId ?? this.sessionId,
      deviceId: deviceId ?? this.deviceId,
    );
  }
}
