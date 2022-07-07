import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:zari/language/app_language.dart';
import 'package:zari/model/core/city.dart';
import 'package:zari/model/core/country.dart';
import 'package:zari/model/core/region.dart';
import 'package:zari/model/core/user.dart';
import 'package:zari/model/service/api.dart';
import 'package:zari/prefs/pref_manager.dart';
import 'package:zari/util/Dimensions.dart';
import 'package:zari/util/style.dart';
import 'package:zari/widgets/custom_button.dart';
import 'package:zari/widgets/custom_field.dart';

import '../constants.dart';
import 'main_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  bool loading = false;

  @override
  void initState() {
    getCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<AppLanguage>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          localize(context, "sign up")!,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: AppColors.GRAY_APPBAR,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: LoadingOverlay(
        isLoading: loading,
        opacity: 0.3,
        progressIndicator: Center(child: CircularProgressIndicator()),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //   Image.asset("assets/images/logo.png", height: 100),
                      SizedBox(height: 20),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            localize(context, "name")!,
                            style:
                                TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE),
                          )),
                      SizedBox(height: 5),
                      CustomField(
                        //  title: localize(context, "name"),
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
                            localize(context, "mobile")!,
                            style:
                                TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE),
                          )),
                      SizedBox(height: 5),
                      CustomField(
                        //    title: localize(context, "mobile"),
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
                            style:
                                TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE),
                          )),
                      SizedBox(height: 5),
                      CustomField(
                        //     title: localize(context, "email"),
                        controller: email,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return localize(context, "emailRequired");
                          }
                          if (!value.contains("@")) {
                            return localize(context, "emailError");
                          }
                        },
                      ),
                      SizedBox(height: 10),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            localize(context, "selectCountry")!,
                            style:
                                TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE),
                          )),
                      SizedBox(height: 5),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.CUSTOM_FEILD_GRAY,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: DropdownButton<Country>(
                          underline: Container(),
                          isExpanded: true,
                          icon: Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Colors.grey,
                          ),
                          dropdownColor: Colors.white,
                          // elevation: 5,
                          value: selectedCountry,
                          hint: Text(
                            localize(context, "selectCountry")!,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          onChanged: (value) => setState(() {
                            selectedCountry = value;
                            getCities(selectedCountry!.id);
                          }),
                          items: countries != null
                              ? countries!
                                  .map(
                                    (e) => DropdownMenuItem(
                                      child: Text(
                                        langProvider.appLanguage == "en"
                                            ? e.name!
                                            : e.arname!,
                                        style: TextStyle(
                                            color: AppColors.FONT_DROPDOWN),
                                      ),
                                      value: e,
                                    ),
                                  )
                                  .toList()
                              : null,
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            localize(context, "selectCity")!,
                            style:
                                TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE),
                          )),
                      SizedBox(height: 5),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.CUSTOM_FEILD_GRAY,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: DropdownButton<City>(
                          underline: Container(),
                          isExpanded: true,
                          icon: Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Colors.grey,
                          ),
                          dropdownColor: AppColors.CUSTOM_FEILD_GRAY,
                          value: selectedCity,
                          hint: Text(
                            localize(context, "selectCity")!,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          onChanged: (value) => setState(() {
                            selectedCity = value;
                            getRegions(selectedCity!.id);
                          }),
                          items: cities != null
                              ? cities!
                                  .map(
                                    (e) => DropdownMenuItem(
                                      child: Text(
                                        langProvider.appLanguage == "en"
                                            ? e.name!
                                            : e.arname!,
                                        style: TextStyle(
                                            color: AppColors.FONT_DROPDOWN),
                                      ),
                                      value: e,
                                    ),
                                  )
                                  .toList()
                              : null,
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            localize(context, "selectRegion")!,
                            style:
                                TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE),
                          )),
                      SizedBox(height: 5),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.CUSTOM_FEILD_GRAY,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: DropdownButton<Region>(
                          underline: Container(),
                          isExpanded: true,
                          icon: Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Colors.grey,
                          ),
                          dropdownColor: AppColors.CUSTOM_FEILD_GRAY,
                          value: selectedRegion,
                          hint: Text(
                            localize(context, "selectRegion")!,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          onChanged: (value) => setState(() {
                            selectedRegion = value;
                          }),
                          items: regions != null
                              ? regions!
                                  .map(
                                    (e) => DropdownMenuItem(
                                      child: Text(
                                        langProvider.appLanguage == "en"
                                            ? e.name!
                                            : e.arname!,
                                        style: TextStyle(
                                            color: AppColors.FONT_DROPDOWN),
                                      ),
                                      value: e,
                                    ),
                                  )
                                  .toList()
                              : null,
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            localize(context, "password")!,
                            style:
                                TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE),
                          )),
                      SizedBox(height: 5),
                      CustomField(
                        //    title: localize(context, "password"),
                        controller: password,
                        obsecure: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return localize(context, "passwordRequired");
                          }
                        },
                      ),
                      SizedBox(height: 10),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            localize(context, "confirmPassword")!,
                            style:
                                TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE),
                          )),
                      SizedBox(height: 5),
                      CustomField(
                        //           title: localize(context, "confirmPassword"),
                        controller: confirmPassword,
                        obsecure: true,
                        validator: (value) {
                          if (value != password.text) {
                            return localize(context, "passwordMismatch");
                          }
                        },
                      ),
                      SizedBox(height: 50),

                      CustomButton(
                        title: localize(context, "register"),
                        onClick: register,
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            localize(context, "don\'t have an account?")!,
                            style: TextStyle(color: Colors.grey),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              localize(context, "login")!,
                              style: TextStyle(
                                color: AppColors.YALLOW_BUTTON,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
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

  getCountries() async {
    await Api.getCountries().then((value) {
      setState(() => countries = value);
    });
  }

  getCities(countryID) async {
    await Api.getCities(countryID).then((value) {
      setState(() => cities = value);
    });
  }

  getRegions(cityID) async {
    await Api.getRegions(cityID).then((value) {
      setState(() => regions = value);
    });
  }

  register() async {
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

      String params = "name=${name.text}"
          "&mobile=${mobile.text}"
          "&email=${email.text}"
          "&password=${password.text}"
          "&country=${selectedCountry!.id}"
          "&city=${selectedCity!.id}"
          "&region=${selectedRegion!.id}";

      setState(() => loading = true);
      await Api.register(params).then((value) {
        print(value);
        if (value.statusCode == 200) {
          Fluttertoast.showToast(msg: localize(context, "userCreated")!);
          login();
        }
      });
    }
  }

  login() async {
    String params = "mobile=${mobile.text}" "&password=${password.text}";

    await Api.login(params).then((value) {
      if (value['status'] != false) {
        User user = User.fromJson(value);
        PrefManager.setCurrentUser(user).then((value2) {
          setState(() => loading = false);
          Fluttertoast.showToast(
              msg: localize(context, "loggedInSuccessfully")!);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => MainPage()),
            (route) => false,
          );
        });
      } else {
        setState(() => loading = false);
        Fluttertoast.showToast(msg: value['msg']);
      }
    });
  }
}
