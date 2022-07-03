import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:zari/language/app_language.dart';

import 'package:zari/providers/pages_provider.dart';
import 'package:zari/util/Dimensions.dart';
import 'package:zari/util/Images.dart';
import 'package:zari/util/Utils.dart';

import 'package:zari/util/style.dart';
import 'package:zari/widgets/custom_button.dart';

import '../constants.dart';
import 'menu_page.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage();

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int _define = 4;
  int generalIndex = 5;
  List<String> images = [
    Images.booking_welcome,
    Images.offer_welcome,
    Images.party_welcome,
    Images.thinking_welcome,
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          localize(context, "welcome")!,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: AppColors.GRAY_APPBAR,
        elevation: 1,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25),
            Center(
              child: Text(
                localize(context, "welcometozariontime")!,
                style: TextStyle(
                    color: AppColors.YALLOW_BUTTON,
                    fontSize: Dimensions.FONT_SIZE_DEFAULT),
              ),
            ),
            SizedBox(height: 25),
            Center(
              child: Text(
                localize(context, "choosethefeature")!,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE_TWENTY,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 25),
            Container(
              height: 350,
              child: GridView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 250,
                      childAspectRatio: 2.5 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: 4,
                  itemBuilder: (BuildContext context, index) => _buildWelecome(
                      images[index], Utils.list_welcom(context, index), index)),
            ),
            SizedBox(height: 25),
            CustomButton(
              title: localize(context, "start"),
              colors: _define != generalIndex ? 1 : 0,
              //  onClick: route(generalIndex),
              onClick: () {
                Utils.route(generalIndex, context);
              },
            ),
          ],
        ),
      ),
    );
  }

  _buildWelecome(String url, String title, int index) {
    final langProvider = Provider.of<AppLanguage>(context, listen: false);
    final pagesProvider = Provider.of<PagesProvider>(context, listen: false);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _define = index;
            generalIndex = index;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.GRAY_APPBAR,
            border: Border.all(
                color: _define != index
                    ? Colors.transparent
                    : AppColors.YALLOW_BUTTON),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  // border: Border.all(color: yellowColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Image.asset(
                    url,
                    scale: 2.25,
                    color: _define != index
                        ? Colors.black
                        : AppColors.YALLOW_BUTTON,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: _define != index
                          ? Colors.black
                          : AppColors.YALLOW_BUTTON,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
