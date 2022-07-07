import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:zari/language/app_language.dart';
import 'package:zari/model/core/city.dart';
import 'package:zari/model/core/country.dart';
import 'package:zari/model/core/region.dart';
import 'package:zari/model/service/api.dart';
import 'package:zari/prefs/pref_manager.dart';
import 'package:zari/util/Dimensions.dart';
import 'package:zari/util/style.dart';
import 'package:zari/widgets/custom_button.dart';
import 'package:zari/widgets/custom_field.dart';
import 'package:zari/widgets/need_login_widget.dart';

import '../constants.dart';
import 'login_page.dart';

class PersonalIformationPage extends StatefulWidget {
  const PersonalIformationPage({Key? key}) : super(key: key);

  @override
  State<PersonalIformationPage> createState() => _PersonalIformationPageState();
}

class _PersonalIformationPageState extends State<PersonalIformationPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  bool loading = false;

  @override
  void initState() {
    if (PrefManager.currentUser != null) {
      name.text = PrefManager.currentUser!.fullName ?? "";
      email.text = PrefManager.currentUser!.email ?? "";
      mobile.text = PrefManager.currentUser!.mobile ?? "";
      getCountries().then((value) {
        selectedCountry = countries!
            .firstWhere((e) => e.id == PrefManager.currentUser!.countryid);
      });
      getCities(PrefManager.currentUser!.countryid).then((value) {
        selectedCity =
            cities!.firstWhere((e) => e.id == PrefManager.currentUser!.cityid);
      });
      getRegions(PrefManager.currentUser!.cityid).then((value) {
        selectedRegion = regions!
            .firstWhere((e) => e.id == PrefManager.currentUser!.regionid);
      });
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
          localize(context, "personal information")!,
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
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            localize(context, "name")!,
                            style:
                                TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE),
                          )),
                      SizedBox(height: 5),
                      CustomField(
                        title: localize(context, "name"),
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
                            style:
                                TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE),
                          )),
                      SizedBox(height: 5),
                      CustomField(
                        title: localize(context, "Phone number"),
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
                        title: localize(context, "email"),
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
                          dropdownColor: Colors.grey,
                          elevation: 5,
                          value: selectedCountry,
                          hint: Text(
                            localize(context, "selectCountry")!,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          onChanged: (value) => setState(() {
                            selectedCity = null;
                            selectedRegion = null;
                            cities = null;
                            regions = null;
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
                          dropdownColor: Colors.grey,
                          value: selectedCity,
                          hint: Text(
                            localize(context, "selectCity")!,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          onChanged: (value) => setState(() {
                            selectedRegion = null;
                            regions = null;
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
                          dropdownColor: Colors.grey,
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
                                  .map((e) => DropdownMenuItem(
                                        child: Text(
                                          langProvider.appLanguage == "en"
                                              ? e.name!
                                              : e.arname!,
                                          style: TextStyle(
                                              color: AppColors.FONT_DROPDOWN),
                                        ),
                                        value: e,
                                      ))
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
                        title: localize(context, "password"),
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
                        title: localize(context, "confirmPassword"),
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
                        title: localize(context, "save"),
                        onClick: updateProfile,
                        colors: 0,
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
