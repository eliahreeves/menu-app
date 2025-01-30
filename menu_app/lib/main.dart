// MAIN program.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gma_mediation_applovin/gma_mediation_applovin.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:menu_app/ads/ad_helper.dart';
import 'package:menu_app/providers/theme_provider.dart';
import 'package:menu_app/ads/ad_bar.dart';
import 'package:menu_app/providers/ad_state_provider.dart';
import 'package:menu_app/utilities/prefs_service.dart';
import 'package:menu_app/utilities/router.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:menu_app/firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GmaMediationApplovin().setDoNotSell(true);
  
  await Future.wait([
    PrefsService.init(),
  
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]),
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ).then(
        (_) => FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true)),
    MobileAds.instance.initialize(),
  ]);
  runApp(
    ProviderScope(
        child: MyApp(
      showAds: getAdBool(),
    )),
  );
}

class MyApp extends ConsumerWidget {
  final bool showAds;
  const MyApp({super.key, required this.showAds});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adState = ref.watch(adStateNotifierProvider);
    final theme = ref.watch(themeNotifierProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        top: false,
        bottom: (showAds &&
            adState.isEnabled &&
            adState.isLoaded &&
            adState.bannerAd != null),
        child: Column(
          children: [
            Expanded(
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                // Ignores IOS set to bold text
                builder: (context, child) => MediaQuery(
                  data: MediaQuery.of(context).copyWith(boldText: false),
                  child: child!,
                ),
                theme: ThemeData(
                  useMaterial3: true,
                  colorScheme: theme.colorScheme,
                  buttonTheme: const ButtonThemeData(
                    colorScheme: ColorScheme.dark(),
                  ),
                ),
                routerConfig: goRouter,
              ),
            ),
            if (showAds && adState.isEnabled) const AdBar()
          ],
        ),
      ),
    );
  }
}
