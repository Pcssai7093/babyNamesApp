import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class nativeAdMedium extends StatefulWidget {
  const nativeAdMedium({super.key});

  @override
  State<nativeAdMedium> createState() => _nativeAdMediumState();
}

class _nativeAdMediumState extends State<nativeAdMedium> {
  bool _nativeAdIsLoaded = false;
  NativeAd? _nativeAd;

  bool _bannearAdLoaded = false;
  BannerAd? _bannerAd;

  void initState() {
    super.initState();
    _nativeAd = NativeAd(
        adUnitId: "ca-app-pub-2071196384129241/4756310685",
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            print('$NativeAd loaded.');
            setState(() {
              _nativeAdIsLoaded = true;
            });
          },
          onAdFailedToLoad: (ad, error) async {
            print('$NativeAd failedToLoad: $error');
            final size =
                await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
                    MediaQuery.sizeOf(context).width.truncate());
            _bannerAd = BannerAd(
              adUnitId: "ca-app-pub-2071196384129241/6828130207",
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
          },
        ),
        request: const AdRequest(),
        nativeTemplateStyle: NativeTemplateStyle(
            templateType: TemplateType.medium,
            mainBackgroundColor: const Color(0xfffffbed),
            callToActionTextStyle: NativeTemplateTextStyle(
                textColor: Colors.white,
                style: NativeTemplateFontStyle.monospace,
                size: 16.0),
            primaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.black,
                style: NativeTemplateFontStyle.bold,
                size: 16.0),
            secondaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.black,
                style: NativeTemplateFontStyle.italic,
                size: 16.0),
            tertiaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.black,
                style: NativeTemplateFontStyle.normal,
                size: 16.0)))
      ..load();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _nativeAdIsLoaded
            ? ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 320,
                  minHeight: 100,
                  maxWidth: 400,
                  maxHeight: 200,
                ),
                child: AdWidget(ad: _nativeAd!),
              )
            : Text(""),
        _bannearAdLoaded
            ? Align(
                alignment: Alignment.bottomCenter,
                child: SafeArea(
                  child: SizedBox(
                    width: _bannerAd!.size.width.toDouble(),
                    height: _bannerAd!.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd!),
                  ),
                ),
              )
            : Text(""),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nativeAd?.dispose();
  }
}
