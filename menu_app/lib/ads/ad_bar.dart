import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:menu_app/providers/ad_state_provider.dart';
import 'package:menu_app/ads/consent_manager.dart';

// ignore: unused_element, non_constant_identifier_names
final String _banner_ad_unit_ID =
    Platform.isAndroid ? 'e1fa1a7321d6419f' : '0de5490ded2e98f7';

class AdBar extends ConsumerStatefulWidget {
  const AdBar({super.key});

  @override
  ConsumerState<AdBar> createState() => _AdBarState();
}

class _AdBarState extends ConsumerState<AdBar> {
  final _consentManager = ConsentManager();
  var _isMobileAdsInitializeCalled = false;
  // ignore: unused_field
  var _isPrivacyOptionsRequired = false;

  final _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-1893777311600512/8265461657'
      : 'ca-app-pub-1893777311600512/1538409384';

  @override
  void initState() {
    super.initState();

    _consentManager.gatherConsent((consentGatheringError) {
      if (consentGatheringError != null) {
        // Consent not obtained in current session.
        debugPrint(
            "${consentGatheringError.errorCode}: ${consentGatheringError.message}");
      }

      // Check if a privacy options entry point is required.
      _getIsPrivacyOptionsRequired();

      // Attempt to initialize the Mobile Ads SDK.
      _initializeMobileAdsSDK();
    });

    // This sample attempts to load ads using consent obtained in the previous session.
    _initializeMobileAdsSDK();
  }

  /// Loads a banner ad.
  @override
  Widget build(BuildContext context) {
    final adState = ref.watch(adStateNotifierProvider);
    return (adState.bannerAd != null && adState.isLoaded)
        ? SizedBox(
            width: adState.bannerAd!.size.width.toDouble(),
            height: adState.bannerAd!.size.height.toDouble(),
            child: AdWidget(ad: adState.bannerAd!),
          )
        : const SizedBox();
  }

  void _loadAd() async {
    // Only load an ad if the Mobile Ads SDK has gathered consent aligned with
    // the app's configured messages.
    var canRequestAds = await _consentManager.canRequestAds();
    if (!canRequestAds) {
      return;
    }

    if (!mounted) {
      return;
    }

    // Get an AnchoredAdaptiveBannerAdSize before loading the ad.
    final size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
        MediaQuery.sizeOf(context).width.truncate());

    if (size == null) {
      // Unable to get width of anchored banner.
      return;
    }

    BannerAd(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      size: size,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          ref
              .read(adStateNotifierProvider.notifier)
              .updateAdState(bannerAd: ad as BannerAd, isLoaded: true);

          // setState(() {
          //   _bannerAd = ad as BannerAd;
          //   _isLoaded = true;
          // });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) {},
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) {},
      ),
    ).load();
  }

  /// Redraw the app bar actions if a privacy options entry point is required.
  void _getIsPrivacyOptionsRequired() async {
    if (await _consentManager.isPrivacyOptionsRequired()) {
      setState(() {
        _isPrivacyOptionsRequired = true;
      });
    }
  }

  /// Initialize the Mobile Ads SDK if the SDK has gathered consent aligned with
  /// the app's configured messages.
  void _initializeMobileAdsSDK() async {
    if (_isMobileAdsInitializeCalled) {
      return;
    }

    if (await _consentManager.canRequestAds()) {
      _isMobileAdsInitializeCalled = true;

      // Initialize the Mobile Ads SDK.
      MobileAds.instance.initialize();

      // Load an ad.
      _loadAd();
    }
  }
}
