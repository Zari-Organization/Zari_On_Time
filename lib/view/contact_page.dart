import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:zari/model/service/api.dart';
import 'package:zari/prefs/pref_manager.dart';
import 'package:zari/util/Dimensions.dart';
import 'package:zari/util/Images.dart';
import 'package:zari/util/style.dart';
import 'package:zari/view/main_page.dart';
import 'package:zari/view/message_page.dart';
import 'package:zari/widgets/custom_button.dart';
import 'package:zari/widgets/custom_field.dart';

import '../constants.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController message = TextEditingController();

  bool loading = false;

  var contactData;

  getContactData() async {
    await Api.getContact().then((value) {
      setState(() => contactData = value);
    });
  }

  @override
  void initState() {
    getContactData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localize(context, "contact us")!,
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
      backgroundColor: Colors.white,
      body: contactData != null
          ? LoadingOverlay(
              isLoading: loading,
              opacity: 0,
              progressIndicator: Center(child: CircularProgressIndicator()),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              localize(context, "name")!,
                              style: TextStyle(
                                  fontSize: Dimensions.FONT_SIZE_LARGE),
                            )),
                        SizedBox(height: 5),
                        CustomField(
                          //   title: localize(context, "name"),
                          controller: name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return localize(context, "nameRequired");
                            }
                          },
                        ),
                        SizedBox(height: 10),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              localize(context, "Phone number")!,
                              style: TextStyle(
                                  fontSize: Dimensions.FONT_SIZE_LARGE),
                            )),
                        SizedBox(height: 5),
                        CustomField(
                          //   title: localize(context, "Phone number"),
                          controller: mobile,
                          inputType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return localize(context, "phoneRequired");
                            }
                            if (value.length != 11) {
                              return localize(context, "phoneLengthError");
                            }
                          },
                        ),
                        SizedBox(height: 10),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              localize(context, "email")!,
                              style: TextStyle(
                                  fontSize: Dimensions.FONT_SIZE_LARGE),
                            )),
                        SizedBox(height: 5),
                        CustomField(
                          //      title: localize(context, "email"),
                          controller: email,
                        ),
                        SizedBox(height: 10),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              localize(context, "messages")!,
                              style: TextStyle(
                                  fontSize: Dimensions.FONT_SIZE_LARGE),
                            )),
                        SizedBox(height: 5),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: AppColors.CUSTOM_FEILD_GRAY,
                          ),
                          child: TextFormField(
                            controller: message,
                            maxLines: 5,
                            style: TextStyle(color: Colors.grey),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return localize(context, "messageRequired");
                              }
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: localize(context, "yourmessage"),
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        CustomButton(
                          title: localize(context, "sendmessage"),
                          onClick: contact,
                          colors: 0,
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Divider(
                                indent: 20.0,
                                endIndent: 10.0,
                                thickness: 1,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "OR",
                              style: TextStyle(color: Colors.black),
                            ),
                            Expanded(
                              child: Divider(
                                indent: 10.0,
                                endIndent: 20.0,
                                thickness: 1,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () async {
                                await launch(contactData['facebook']);
                              },
                              child: Card(
                                elevation: 2,
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
                            ),
                            InkWell(
                              onTap: () async {
                                await launch(contactData['linkedin']);
                              },
                              child: Card(
                                elevation: 2,
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
                            ),
                            InkWell(
                              onTap: () async {
                                await launch(contactData['instagram']);
                              },
                              child: Card(
                                elevation: 2,
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
                            ),
                            InkWell(
                              onTap: () async {
                                WhatsAppUnilink link = WhatsAppUnilink(
                                  phoneNumber: contactData['whatsaapp'],
                                  text: "",
                                );

                                await launch("$link");
                              },
                              child: Card(
                                elevation: 2,
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
                            ),
                            InkWell(
                              onTap: () async {
                                await launch(contactData['linkedin']);
                              },
                              child: Card(
                                elevation: 2,
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
                            ),
                            // MaterialButton(
                            //   height: 60,
                            //   minWidth: 60,
                            //   padding: EdgeInsets.all(0),
                            //   shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(60),
                            //   ),
                            //   onPressed: () async {
                            //     await launch(contactData['facebook']);
                            //   },
                            //   child: Image.asset(
                            //     "assets/images/facebook.png",
                            //     height: 60,
                            //   ),
                            // ),
                            // SizedBox(height: 10),
                            // MaterialButton(
                            //   height: 60,
                            //   minWidth: 60,
                            //   padding: EdgeInsets.all(0),
                            //   shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(60),
                            //   ),
                            //   onPressed: () async {
                            //     await launch(contactData['instagram']);
                            //   },
                            //   // color: Color(0xff8a3ab9),
                            //   child: Image.asset(
                            //     "assets/images/instagram.png",
                            //     height: 60,
                            //   ),
                            // ),
                            // SizedBox(height: 10),
                            // MaterialButton(
                            //   height: 60,
                            //   minWidth: 60,
                            //   padding: EdgeInsets.all(0),
                            //   shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(60),
                            //   ),
                            //   onPressed: () async {
                            //     await launch(contactData['linkedin']);
                            //   },
                            //   child: Image.asset(
                            //     "assets/images/linkedin.png",
                            //     height: 60,
                            //   ),
                            // ),
                            // SizedBox(height: 10),
                            // MaterialButton(
                            //   height: 60,
                            //   minWidth: 60,
                            //   padding: EdgeInsets.all(0),
                            //   shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(60),
                            //   ),
                            //   onPressed: () async {
                            //     WhatsAppUnilink link = WhatsAppUnilink(
                            //       phoneNumber: contactData['whatsaapp'],
                            //       text: "",
                            //     );

                            //     await launch("$link");
                            //   },
                            //   child: Image.asset(
                            //     "assets/images/whatsapp.png",
                            //     height: 60,
                            //   ),
                            // ),
                          ],
                        ),
                        SizedBox(height: 40),
                        InkWell(
                          onTap: () async {
                            await launch(contactData['website']);
                          },
                          child: Text(
                            contactData['website'],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          contactData['email'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () async {
                            await launch("tel: ${contactData['phone']}");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.phone, color: Colors.black),
                              SizedBox(width: 15),
                              Text(
                                contactData['phone'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () => openMapsSheet(
                            context,
                            contactData['lat'],
                            contactData['long'],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.location_on, color: Colors.white),
                              SizedBox(width: 15),
                              Text(
                                contactData['address'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  contact() async {
    if (formKey.currentState!.validate()) {
      String params;
      if (PrefManager.currentUser != null) {
        params = "name=${name.text}"
            "&mobile=${mobile.text}"
            "&email=${email.text}"
            "&custid=${PrefManager.currentUser!.custId}"
            "&message=${message.text}";
      } else {
        params = "name=${name.text}"
            "&mobile=${mobile.text}"
            "&email=${email.text}"
            "&message=${message.text}";
      }
      setState(() => loading = true);

      await Api.contactUs(params).then((value) {
        setState(() => loading = false);
        if (value['status'] == true) {
          Fluttertoast.showToast(msg: localize(context, "messageSent")!);
          name.clear();
          mobile.clear();
          email.clear();
          message.clear();
        }
      }).then((value) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => MessagePage()));
      });
    }
  }

  openMapsSheet(context, lat, lng) async {
    try {
      final coords = Coords(lat, lng);
      final title = "";
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => map.showMarker(
                          coords: coords,
                          title: title,
                        ),
                        title: Text(map.mapName),
                        leading: SvgPicture.asset(
                          map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
