import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:BieDaalt/screens/main_menu_screen.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  @override
  State<Splash> createState() => _SplashState();
  static String routeName = '/splash';
}

class _SplashState extends State<Splash> {
  late final Future<LottieComposition> _composition1;
  late final Future<LottieComposition> _composition2;

  @override
  void initState() {
    super.initState();
    _composition1 = NetworkLottie(
            'https://lottie.host/6e5b242c-015b-4c75-80e1-c766187c4685/1NfHDEBsFY.json')
        .load();
    _composition2 = NetworkLottie(
            'https://lottie.host/0dcd046d-f0a4-4cf8-815f-7c8d70e0d06a/7isL5Rq2tD.json')
        .load();
    startTimer();
  }

  startTimer() {
    var duration = Duration(seconds: 4);
    return Timer(duration, route);
  }

  void route() {
    Navigator.pushReplacementNamed(context, MainMenuScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: content(),
    );
  }

  Widget content() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder<LottieComposition>(
            future: _composition1,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error loading animation'));
                } else {
                  return Lottie(composition: snapshot.data!);
                }
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
          SizedBox(height: 20),
          FutureBuilder<LottieComposition>(
            future: _composition2,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error loading animation'));
                } else {
                  return Lottie(composition: snapshot.data!);
                }
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}
