import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Timer(
        Duration(seconds: 3),
        () {
          Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(builder: (context) => new WelcomePage()),
            (_) => false,
          );
        },
      );
    } else {
      Timer(
        Duration(seconds: 2),
        () async {
          await prefs.setBool('seen', true);
          Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(builder: (context) => new OnBoardingPage()),
            (_) => false,
          );
        },
      );
    }
  }

  @override
  void initState() {
    checkFirstSeen();
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
