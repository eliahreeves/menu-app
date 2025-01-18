import 'dart:async';

import 'package:menu_app/models/menus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:menu_app/utilities/constants.dart' as c;
part '../generated/providers/banner_text_provider.g.dart';
@Riverpod(keepAlive: true)
class BannerText extends _$BannerText {
  Timer? _timer;
  @override
  Future<String> build() async {
    ref.onDispose(() {
      _timer?.cancel();
    });

    ref.onCancel(() {
      _timer = Timer(const Duration(minutes: c.provTTL), () {
        ref.invalidateSelf();
      });
    });

    ref.onResume(() {
      _timer?.cancel();
    });
    return await fetchBanner();
  }
}