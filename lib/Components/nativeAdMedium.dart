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

  void initState() {
    super.initState();
    _nativeAd = NativeAd(
        adUnitId: "ca-app-pub-3940256099942544/2247696110",
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            print('$NativeAd loaded.');
            setState(() {
              _nativeAdIsLoaded = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            print('$NativeAd failedToLoad: $error');
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
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 320,
        minHeight: 100,
        maxWidth: 400,
        maxHeight: 200,
      ),
      child: _nativeAdIsLoaded ? AdWidget(ad: _nativeAd!) : Text("helo"),
    );
  }

  @override
  void dispose(){
    super.dispose();
    _nativeAd?.dispose();
  }
}
