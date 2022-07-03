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
import 'package:zari/view/change_password.dart';
import 'package:zari/view/history_page.dart';
import 'package:zari/view/personal_information_page.dart';
import 'package:zari/widgets/custom_button.dart';
import 'package:zari/widgets/custom_field.dart';
import 'package:zari/widgets/need_login_widget.dart';

import '../constants.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
          localize(context, "profile")!,
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
                      Center(
                          child: Text(
                        '${name1}',
                        style: TextStyle(
                            color: AppColors.YALLOW_BUTTON,
                            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE_TWENTY),
                      )),
                      SizedBox(height: 15),
                      Center(
                          child: Text(
                        '${email1}',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE_TWENTY),
                      )),
                      SizedBox(height: 15),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                        child: ListTile(
                          leading: SvgPicture.asset(
                            Images.time_circle,
                          ),
                          title: Text(
                            localize(context, "reservation history")!,
                            style: TextStyle(color: Colors.black),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => HistoryPage()),
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
                            Images.edit,
                          ),
                          title: Text(
                            localize(
                                context, "edit your personal information")!,
                            style: TextStyle(color: Colors.black),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => PersonalIformationPage()),
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
                            Images.change_password,
                          ),
                          title: Text(
                            localize(context, "changepassword")!,
                            style: TextStyle(color: Colors.black),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ChangePasswordPage()),
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
