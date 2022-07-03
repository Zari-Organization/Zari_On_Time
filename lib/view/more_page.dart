import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:zari/language/app_language.dart';
import 'package:zari/model/core/city.dart';
import 'package:zari/model/core/country.dart';
import 'package:zari/model/core/region.dart';
import 'package:zari/model/service/api.dart';
import 'package:zari/prefs/pref_manager.dart';
import 'package:zari/util/Images.dart';
import 'package:zari/util/Dimensions.dart';
import 'package:zari/util/style.dart';
import 'package:zari/view/about_us_page.dart';
import 'package:zari/view/change_password.dart';
import 'package:zari/view/contact_page.dart';
import 'package:zari/view/history_page.dart';
import 'package:zari/view/join_page.dart';
import 'package:zari/view/personal_information_page.dart';

import 'package:zari/widgets/need_login_widget.dart';

import '../constants.dart';
import 'login_page.dart';

class MorePage extends StatefulWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  GlobalKey<FormState> formKey = GlobalKey();
  String? name1;
  String? email1;
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  bool loading = false;

  @override
  void initState() {
    if (PrefManager.currentUser != null) {
      name1 = PrefManager.currentUser!.fullName ?? "";
      email1 = PrefManager.currentUser!.email ?? "";
      mobile.text = PrefManager.currentUser!.mobile ?? "";
      // getCountries().then((value) {
      //   selectedCountry = countries!
      //       .firstWhere((e) => e.id == PrefManager.currentUser!.countryid);
      // });
      // getCities(PrefManager.currentUser!.countryid).then((value) {
      //   selectedCity =
      //       cities!.firstWhere((e) => e.id == PrefManager.currentUser!.cityid);
      // });
      // getRegions(PrefManager.currentUser!.cityid).then((value) {
      //   selectedRegion = regions!
      //       .firstWhere((e) => e.id == PrefManager.currentUser!.regionid);
      // });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<AppLanguage>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          localize(context, "more")!,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: AppColors.GRAY_APPBAR,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: LoadingOverlay(
        isLoading: loading,
        opacity: 0.3,
        progressIndicator: Center(child: CircularProgressIndicator()),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: PrefManager.currentUser != null
                ? Column(
                    children: [
                      SizedBox(height: 15),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                        child: ListTile(
                          leading: SvgPicture.asset(
                            Images.users_group,
                          ),
                          title: Text(
                            localize(context, "joinUs")!,
                            style: TextStyle(color: Colors.black),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => JoinPage()),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                        child: ListTile(
                          leading: SvgPicture.asset(
                            Images.langauge,
                          ),
                          title: Text(
                            localize(context, "app language")!,
                            style: TextStyle(color: Colors.black),
                          ),
                          trailing: TextButton(
                            onPressed: () {
                              if (langProvider.appLanguage == "en") {
                                langProvider.changeLanguage(Locale("ar"));
                              } else {
                                langProvider.changeLanguage(Locale("en"));
                              }
                            },
                            child: Text(
                              langProvider.appLanguage == "en"
                                  ? "العربية"
                                  : "English",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                        child: ListTile(
                          leading: SvgPicture.asset(
                            Images.about_us,
                          ),
                          title: Text(
                            localize(context, "aboutus")!,
                            style: TextStyle(color: Colors.black),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => AboutUsPage()),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                        child: ListTile(
                          leading: SvgPicture.asset(
                            Images.message,
                          ),
                          title: Text(
                            localize(context, "contact us")!,
                            style: TextStyle(color: Colors.black),
                          ),
                          onTap: () {
                            // if (PrefManager.currentUser != null) {
                            //   PrefManager.setCurrentUser(null).then((value) {
                            //     Navigator.pushAndRemoveUntil(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (contaxt) => ContactPage()),
                            //       (route) => false,
                            //     );
                            //   });
                            // }
                            // else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => ContactPage()),
                            );
                            //    }
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                        child: ListTile(
                          leading: SvgPicture.asset(
                            Images.log_out,
                          ),
                          title: Text(
                            localize(context, "logout")!,
                            style: TextStyle(color: Colors.black),
                          ),
                          onTap: () {
                            if (PrefManager.currentUser != null) {
                              PrefManager.setCurrentUser(null).then((value) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => LoginPage()),
                                  (route) => false,
                                );
                              });
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => LoginPage()),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  )
                : NeedLoginWidget(),
          ),
        ),
      ),
    );
  }

  List<Country>? countries;
  Country? selectedCountry;
  List<City>? cities;
  City? selectedCity;
  List<Region>? regions;
  Region? selectedRegion;

  Future getCountries() async {
    await Api.getCountries().then((value) {
      setState(() {
        countries = value;
      });
    });
  }

  Future getCities(countryID) async {
    await Api.getCities(countryID).then((value) {
      setState(() {
        cities = value;
      });
    });
  }

  Future getRegions(cityID) async {
    await Api.getRegions(cityID).then((value) {
      setState(() => regions = value);
    });
  }

  updateProfile() async {
    if (formKey.currentState!.validate()) {
      if (selectedCountry == null) {
        Fluttertoast.showToast(msg: localize(context, "countryRequired")!);
        return;
      }

      if (selectedCity == null) {
        Fluttertoast.showToast(msg: localize(context, "cityRequired")!);
        return;
      }

      if (selectedRegion == null) {
        Fluttertoast.showToast(msg: localize(context, "regionRequired")!);
        return;
      }

      String params = "custid=${PrefManager.currentUser!.custId}"
          "&name=${name.text}"
          "&mobile=${mobile.text}"
          "&email=${email.text}"
          "&password=${password.text}"
          "&country=${selectedCountry!.id}"
          "&city=${selectedCity!.id}"
          "&region=${selectedRegion!.id}";

      setState(() => loading = true);
      await Api.updateProfile(params).then((value) {
        if (value.statusCode == 200) {
          Fluttertoast.showToast(msg: value.data['msg']);
        }
        setState(() => loading = false);
      });
    }
  }
}
