import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:zari/constants.dart';
import 'package:zari/util/Images.dart';
import 'package:zari/util/style.dart';
import 'package:zari/view/main_page.dart';
import 'package:zari/view/welcome_page.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => WelcomePage()),
    );
  }

  // Widget _buildFullscreenImage() {
  //   return Image.asset(
  //     'assets/fullscreen.jpg',
  //     fit: BoxFit.cover,
  //     height: double.infinity,
  //     width: double.infinity,
  //     alignment: Alignment.center,
  //   );
  // }

  // Widget _buildImage(String assetName, [double width = 350]) {
  //   return Image.asset('assets/$assetName', width: width);
  // }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,

      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 16, right: 16),
            child: Text(localize(context, "skip")!),
          ),
        ),
      ),
      pages: [
        PageViewModel(
          title: localize(context, "don't waste your")!,
          body: localize(context, "your time is so important")!,
          image: SvgPicture.asset(Images.onboard_Waiting),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: localize(context, "booking your")!,
          body: localize(context, "You can book an appointment")!,
          image: SvgPicture.asset(Images.onboard_Event),
          decoration: pageDecoration,
        ),
      ],

      onDone: () => _onIntroEnd(context),
      // onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      // showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      //rtl: true, // Display as right-to-left
      back: Row(
        children: [
          Icon(
            Icons.arrow_back_ios,
            color: AppColors.YALLOW_BUTTON,
            size: 15,
          ),
          Text(
            localize(context, "back")!,
            style: TextStyle(color: AppColors.YALLOW_BUTTON),
          ),
        ],
      ),
      skip: Text(localize(context, "skip")!,
          style: TextStyle(fontWeight: FontWeight.w600)),
      next: Row(
        children: [
          Text(
            localize(context, "next")!,
            style: TextStyle(color: AppColors.YALLOW_BUTTON),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: AppColors.YALLOW_BUTTON,
            size: 15,
          ),
        ],
      ),
      done: Text(localize(context, "done")!,
          style: TextStyle(
              fontWeight: FontWeight.w600, color: AppColors.YALLOW_BUTTON)),
      curve: Curves.fastLinearToSlowEaseIn,
      // controlsMargin: const EdgeInsets.all(16),
      // controlsPadding: kIsWeb
      //     ? const EdgeInsets.all(12.0)
      //     : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: AppColors.YALLOW_BUTTON,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      // nextStyle:ButtonStyle(backgroundColor: AppColors.BACK_GROUND_BLACK) ,
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(child: Text("This is the screen after Introduction")),
    );
  }
}
