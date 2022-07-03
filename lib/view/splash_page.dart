import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zari/prefs/pref_manager.dart';

import 'package:zari/util/style.dart';

import 'package:zari/view/onboarding_page.dart';
import 'package:zari/view/welcome_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    if (PrefManager.currentUser == null) {
      Timer(
        Duration(seconds: 2),
        () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => OnBoardingPage()),
            (_) => false,
          );
        },
      );
    } else {
      Timer(
        Duration(seconds: 3),
        () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => WelcomePage()),
            (_) => false,
          );
        },
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BACK_GROUND_BLACK,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image.asset(
          "assets/images/splash.png",
        ),
      ),
    );
  }
}
