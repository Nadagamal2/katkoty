import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({Key? key}) : super(key: key);

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  final AdSize adSize = AdSize.banner;
  late BannerAd myBanner;

  @override
  void initState() {
    _createBanner();
    super.initState();
  }

  _createBanner() {
    //ca-app-pub-1264835814900584/2605958713
    myBanner = BannerAd(
      adUnitId: Platform.isAndroid
          ? "0000"
          : "ca-app-pub-1264835814900584/5608801666",
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(onAdLoaded: (ad) {
        setState(() {});
      }, onAdFailedToLoad: (add, error) {
        setState(() {});
      }),
    );
    myBanner.load();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: adSize.width.toDouble(),
      height: adSize.height.toDouble(),
      child: AdWidget(
        ad: myBanner,
      ),
    );
  }
}
