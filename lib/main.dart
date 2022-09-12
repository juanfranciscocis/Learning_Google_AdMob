import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main(){

  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MyApp());

}

class MyApp extends StatefulWidget{


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late InterstitialAd _interstitialAd;

  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    // Load ads.
    _initAd();
  }

  void _initAd(){
    print('init ad');
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3104071700346749/2972082735',
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: onAdLoaded,
          onAdFailedToLoad: (error){
            print('Ad failed to load: $error');
          }
      ),
    );

  }

  void onAdLoaded(InterstitialAd ad) {
    _interstitialAd = ad;
    _isAdLoaded = true;
    print('Ad loaded.');
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 10), () {
      print('SHOWING AD');
      _interstitialAd.show();
    });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LEARNING ADMOB',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('LEARNING ADMOB'),
        ),
        body: Center(
          child: Text('PLEASE WAIT FOR 10 SECONDS'),
        ),
      ),
    );
  }
}