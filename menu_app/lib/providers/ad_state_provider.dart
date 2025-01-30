import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../generated/providers/ad_state_provider.g.dart';

class AdState {
  final bool isEnabled;
  final BannerAd? bannerAd;
  final bool isLoaded;
  AdState(
      {required this.bannerAd,
      required this.isEnabled,
      required this.isLoaded});

  AdState copyWith({
    bool? isEnabled,
    BannerAd? bannerAd,
    bool? isLoaded,
  }) {
    return AdState(
      bannerAd: bannerAd ?? this.bannerAd,
      isEnabled: isEnabled ?? this.isEnabled,
      isLoaded: isLoaded ?? this.isLoaded,
    );
  }
}

@riverpod
class AdStateNotifier extends _$AdStateNotifier {
  @override
  AdState build() {
    return AdState(bannerAd: null, isEnabled: true, isLoaded: false);
  }

  void updateAdState({
    bool? isEnabled,
    BannerAd? bannerAd,
    bool? isLoaded,
  }) {

    state = state.copyWith(
        bannerAd: bannerAd, isEnabled: isEnabled, isLoaded: isLoaded);
  }
}

// class AdStateProvider extends StateProvider
// final adStateProvider = StateProvider<AdState>(
//     (ref) => AdState(bannerAd: null, isEnabled: true, isLoaded: false));
