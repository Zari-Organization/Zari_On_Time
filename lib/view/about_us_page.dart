import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:zari/language/app_language.dart';
import 'package:zari/model/service/api.dart';
import 'package:zari/prefs/pref_manager.dart';
import 'package:zari/util/Dimensions.dart';
import 'package:zari/util/Images.dart';
import 'package:zari/util/style.dart';

import '../constants.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  var aboutData;

  getAboutData() async {
    await Api.getAbout().then((value) {
      print(value);
      setState(() => aboutData = value);
    });
  }

  var contactData;

  getContactData() async {
    await Api.getContact().then((value) {
      setState(() => contactData = value);
    });
  }
////

  @override
  void initState() {
    getAboutData();
    getContactData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<AppLanguage>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          localize(context, "aboutus")!,
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.GRAY_APPBAR,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: (aboutData != null && contactData != null)
          ? Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      Images.logo_image,
                      height: 140,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    langProvider.appLanguage == "en"
                        ? aboutData['title']
                        : aboutData['title_ar'],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    langProvider.appLanguage == "en"
                        ? aboutData['details']
                        : aboutData['details_ar'],
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 20),
                  Text(
                    localize(context, "follow us")!,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  //// To Do
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    margin: EdgeInsets.all(8.0),
                                    decoration:
                                        BoxDecoration(shape: BoxShape.circle),
                                    child: SvgPicture.asset(
                                      Images.facebook_icon,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                TextButton(
                                  onPressed: () async {
                                    await launch(contactData['facebook']);
                                  },
                                  child: Text(
                                    'ZARI Commerce',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    margin: EdgeInsets.all(8.0),
                                    decoration:
                                        BoxDecoration(shape: BoxShape.circle),
                                    child: SvgPicture.asset(
                                      Images.whatsup_icon,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                TextButton(
                                  onPressed: () async {
                                    WhatsAppUnilink link = WhatsAppUnilink(
                                      phoneNumber: contactData['whatsaapp'],
                                      text: "",
                                    );

                                    await launch("$link");
                                  },
                                  child: Text(
                                    '+201151300876',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  ///First Row
                  SizedBox(height: 10),
                  //// To Do
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    margin: EdgeInsets.all(8.0),
                                    decoration:
                                        BoxDecoration(shape: BoxShape.circle),
                                    child: SvgPicture.asset(
                                      Images.twitter_icon,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                TextButton(
                                  onPressed: () async {
                                    await launch(contactData['twitter']);
                                  },
                                  child: Text(
                                    'ZARI.Egypt',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    margin: EdgeInsets.all(8.0),
                                    decoration:
                                        BoxDecoration(shape: BoxShape.circle),
                                    child: SvgPicture.asset(
                                      Images.call_icon,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                TextButton(
                                  onPressed: () async {
                                    await launch(
                                        "tel: ${contactData['phone']}");
                                  },
                                  child: Text(
                                    '+201151300876',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  ///Second Row
                  SizedBox(height: 10),
                  //// To Do
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    margin: EdgeInsets.all(8.0),
                                    decoration:
                                        BoxDecoration(shape: BoxShape.circle),
                                    child: Image.asset(
                                      Images.instagram_icon,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                TextButton(
                                  onPressed: () async {
                                    await launch(contactData['instagram']);
                                  },
                                  child: Text(
                                    'ZARI.Commerce',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    margin: EdgeInsets.all(8.0),
                                    decoration:
                                        BoxDecoration(shape: BoxShape.circle),
                                    child: SvgPicture.asset(
                                      Images.langauge,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 2),
                                TextButton(
                                  onPressed: () async {
                                    await launch(contactData['website']);
                                  },
                                  child: Text(
                                    contactData['website'],
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          Dimensions.FONT_SIZE_DEFAULT - 2,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  ///Third Row
                  SizedBox(height: 10),
                  //// To Do
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    margin: EdgeInsets.all(8.0),
                                    decoration:
                                        BoxDecoration(shape: BoxShape.circle),
                                    child: SvgPicture.asset(
                                      Images.linkedin_icon,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                TextButton(
                                  onPressed: () async {
                                    await launch(contactData['linkedin']);
                                  },
                                  child: Text(
                                    'ZARI.Egypt',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    margin: EdgeInsets.all(8.0),
                                    decoration:
                                        BoxDecoration(shape: BoxShape.circle),
                                    child: SvgPicture.asset(
                                      Images.message,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                TextButton(
                                  onPressed: () async {
                                    await launch(contactData['email']);
                                  },
                                  child: Text(
                                    contactData['email'],
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          Dimensions.FONT_SIZE_DEFAULT - 2,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  ///Forth Row
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
