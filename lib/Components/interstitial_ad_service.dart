import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdService {
  static final InterstitialAdService _instance = InterstitialAdService._internal();
  factory InterstitialAdService() => _instance;

  InterstitialAdService._internal();

  InterstitialAd? _interstitialAd;

  DateTime _lastAdTime = DateTime.now().add(const Duration(minutes: 1)); // allow first ad immediately

  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-2071196384129241/6784688169' // Test ad unit
      : 'ca-app-pub-3940256099942544/4411468910';

  void loadAd() async {
    List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();

    if (!(connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.ethernet)) {
      print("--------no net-------");
      return;
    }
    InterstitialAd.load(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (ad) => debugPrint('Ad shown.'),
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _interstitialAd = null;
              _lastAdTime = DateTime.now();
              loadAd(); // Preload next
            },
            onAdFailedToShowFullScreenContent: (ad, err) {
              ad.dispose();
              _interstitialAd = null;
              debugPrint('intersttis t---------------Ad failed to show: $err');
              loadAd();
            },
          );

          _interstitialAd = ad;
          debugPrint('Interstitial ad loaded.');
        },
        onAdFailedToLoad: (error) {
          debugPrint('----------------Interstitia--------- failed to load: $error');
          loadAd();
        },
      ),
    );
  }

  void showAd(Function onAdComplete) {
    final now = DateTime.now();
    print("inshow ad");
    print(_interstitialAd != null);
    if (_interstitialAd != null &&
        now.difference(_lastAdTime) >= const Duration(minutes: 4)) {
      _interstitialAd!.show();
      _interstitialAd = null;
      _lastAdTime = now;
      onAdComplete(); // continue after ad
    } else {
      loadAd();
      onAdComplete(); // skip ad, continue immediately
    }
  }
}





