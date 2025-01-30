import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_mobile_interface/get_mobile_interface.dart';
import 'package:menu_app/custom_widgets/create_pin.dart';
import 'package:menu_app/models/get_auth_model.dart';
import 'package:menu_app/utilities/prefs_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:menu_app/utilities/constants.dart' as constants;
part '../generated/providers/get_auth_notifier.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  GetAuth build() {
    return GetAuth(sessionId: _fetchSessionId(), deviceId: _fetchDeviceId());
  }

  String? _fetchSessionId() {
    final prefs = PrefsService.instance;
    return prefs.getString('get_session_id');
  }

  String? _fetchDeviceId() {
    final prefs = PrefsService.instance;
    return prefs.getString('get_device_id');
  }

  Future<void> _setSessionId(String sessionId) async {
    final prefs = PrefsService.instance;
    await prefs.setString('get_session_id', sessionId);
    state = state.copyWith(sessionId: sessionId);
  }

  Future<void> _clearSessionId() async {
    final prefs = PrefsService.instance;
    await prefs.remove('get_session_id');
    state = state.copyWith(sessionId: null);
  }

  Future<void> _createDeviceId() async {
    var uuid = const Uuid();
    final deviceId = uuid.v4();
    await _setDeviceId(deviceId);
  }

  Future<void> _setDeviceId(String deviceId) async {
    final prefs = PrefsService.instance;
    await prefs.setString('get_device_id', deviceId);
    state = state.copyWith(deviceId: deviceId);
  }

  Future<void> _savePin(String pin) async {
    final prefs = PrefsService.instance;
    await prefs.setString('get_pin', pin);
  }

  String? _fetchPin() {
    final prefs = PrefsService.instance;
    return prefs.getString('get_pin');
  }

  Future<void> _clearPin() async {
    final prefs = PrefsService.instance;
    await prefs.remove('get_pin');
  }

  Future<void> _saveTime() async {
    final prefs = PrefsService.instance;
    final time = DateTime.now().toUtc().toIso8601String();
    await prefs.setString('last_get_auth', time);
  }

  Future<void> _clearTime() async {
    final prefs = PrefsService.instance;
    await prefs.remove('last_get_auth');
  }

  // Future<void> _clearEnableBioAuth() async {
  //   final prefs = PrefsService.instance;
  //   await prefs.remove('get_bio_auth_enabled');
  // }

  bool isPINEntryRequired() {
    final prefs = PrefsService.instance;
    final lastStringEntry = prefs.getString('last_get_auth');
    final allowedSeconds = prefs.getInt('get_pin_timeout_allowed') ??
        constants.defaultGetPinAllowedSeconds;
    //this is never case
    if (allowedSeconds == -1) {
      return false;
    }
    final lastEntry = lastStringEntry == null
        ? DateTime(0)
        : DateTime.parse(lastStringEntry).toLocal();
    final dif = DateTime.now().difference(lastEntry);
    return dif.inSeconds > allowedSeconds;
  }

  Future<void> _createPin(String pin) async {
    if (state.deviceId == null) {
      await _createDeviceId();
    }
    if(state.sessionId == null) {
      return;
    }
    try{
      await createPin(sessionId: state.sessionId!, pin: pin, deviceId: state.deviceId!);
    }catch (e) {
      logout();
    }
  }

  bool validatePin(String pin) {
    if (pin == _fetchPin()) {
      _saveTime();
      return true;
    }
    return false;
  }

  Future<void> authenticateWithPin() async {
    if (state.deviceId == null) {
      _clearSessionId();
      return;
    }
    final sessionId = await authenticatePin(pin: _fetchPin() ?? '', deviceId: state.deviceId!);
    if(sessionId != null) {
      await _setSessionId(sessionId);
    }
  }

  Future<void> _showBioPrompt(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Text('Enable Biometric Login?'),
        content: const Text(
            'Would you like to use fingerprint or face recognition to login?'),
        actions: [
          TextButton(
            onPressed: () async {
              final prefs = PrefsService.instance;
              await prefs.setBool('get_bio_auth_enabled', false);
              if (context.mounted) {
                Navigator.of(context, rootNavigator: true).pop();
              }
            },
            child: const Text('No'),
          ),
          FilledButton(
            onPressed: () async {
              final prefs = PrefsService.instance;
              await prefs.setBool('get_bio_auth_enabled', true);
              if (context.mounted) {
                Navigator.of(context, rootNavigator: true).pop();
              }
            },
            child: Text(
              'Yes',
              style: TextStyle(color: Theme.of(context).colorScheme.surface),
            ),
          ),
        ],
      ),
    );
  }

  Future<String?> _createPinDialog(BuildContext context) async {
    final ret = await showDialog<String>(
        context: context,
        useSafeArea: false,
        barrierColor: Colors.white,
        builder: (BuildContext dialogContext) {
          return const CreatePinDialog();
        });
    return ret;
  }

  Future<void> login(BuildContext context) async {
    final sessionId = await _showWebView(context);
    if (sessionId != null) {
      if (!context.mounted) {
        return;
      }
      final pin = await _createPinDialog(context);
      if(context.mounted) await _showBioPrompt(context);
      if (pin == null) {
        await logout();
        return;
      }
      await _setSessionId(sessionId);
      await Future.wait([_savePin(pin), _createPin(pin), _saveTime()]);
    }
  }

  Future<void> logout() async {
    final controller = WebViewController();
    await Future.wait([
      WebViewCookieManager().clearCookies(),
      controller.clearCache(),
      controller.clearLocalStorage(),
      _clearSessionId(),
      _clearPin(),
      _clearTime(),
    ]);
  }

  Future<String?> _showWebView(BuildContext context) async {
    final completer = Completer<String?>();
    final loadingNotifier = ValueNotifier<int>(0);

    final controller = WebViewController()
      ..setBackgroundColor(Colors.white)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            loadingNotifier.value = progress;
          },
          onPageFinished: (String url) {
            if (url.contains('mobileapp_login_validator.php')) {
              final uri = Uri.parse(url);
              final sessionId = uri.queryParameters['sessionId'];
              if (sessionId != null) {
                completer.complete(sessionId);
                Navigator.of(context, rootNavigator: true).pop();
              }
            }
          },
        ),
      )
      ..loadRequest(
          Uri.parse(getLoginUrl));

    await showDialog(
      context: context,
      useSafeArea: false,
      barrierColor: Colors.white,
      builder: (BuildContext dialogContext) {
        return ValueListenableBuilder<int>(
          valueListenable: loadingNotifier,
          builder: (context, progress, child) {
            return SafeArea(
              top: false,
              bottom: false,
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  title: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.primary,
                      fontFamily: 'Monoton',
                    ),
                  ),
                  automaticallyImplyLeading: false,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.of(dialogContext, rootNavigator: true).pop();
                    },
                    icon: Icon(Icons.arrow_back_ios_new_rounded,
                        color: Theme.of(context).colorScheme.secondary,
                        size: constants.backArrowSize),
                  ),
                ),
                body: Column(children: [
                  LinearProgressIndicator(
                    color: Theme.of(context).colorScheme.secondary,
                    value: progress / 100,
                    minHeight: 4,
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Stack(
                          children: [
                            WebViewWidget(controller: controller),
                            if (progress < 100)
                              Center(
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    // color: Colors.black.withValues(alpha: 0.5),
                                    // FIXME sorry had to change to deprecated withOpacity because i get same bug as https://github.com/mapbox/mapbox-maps-flutter/issues/811
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              ),
                          ],
                        )),
                  )
                ]),
              ),
            );
          },
        );
      },
    );
    return completer.future;
  }
}
