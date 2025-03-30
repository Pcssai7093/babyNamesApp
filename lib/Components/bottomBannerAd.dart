import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class bottomBannerAd extends StatefulWidget {
  const bottomBannerAd({super.key});

  @override
  State<bottomBannerAd> createState() => _bottomBannerAdState();
}

class _bottomBannerAdState extends State<bottomBannerAd> {

  bool _bannearAdLoaded = false;

  BannerAd? _bannerAd;
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      initialize();
    });
  }


  void initialize() async{
    final size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
        MediaQuery.sizeOf(context).width.truncate());
    _bannerAd = BannerAd(
      adUnitId: "ca-app-pub-3940256099942544/9214589741",
      request: const AdRequest(),
      size: size!,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          setState(() {
            _bannearAdLoaded = true;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) {},
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) {},
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) {},
      ),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      // left: 20,
      // right: 20,
      // bottom: MediaQuery.of(context).viewPadding.bottom, //
      bottom: 0,
      child: Column(
        children: [
          _bannearAdLoaded ? Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: SizedBox(
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd!),
              ),
            ),
          ) : Text("")
        ],
      ),
    );
  }
}
