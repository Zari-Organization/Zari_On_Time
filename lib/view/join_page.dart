import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:zari/language/app_language.dart';
import 'package:zari/model/core/category.dart';
import 'package:zari/model/core/city.dart';
import 'package:zari/model/core/country.dart';
import 'package:zari/model/core/region.dart';
import 'package:zari/model/service/api.dart';
import 'package:zari/prefs/pref_manager.dart';
import 'package:zari/util/Dimensions.dart';
import 'package:zari/util/style.dart';
import 'package:zari/widgets/custom_button.dart';
import 'package:zari/widgets/custom_field.dart';

import '../constants.dart';

class JoinPage extends StatefulWidget {
  const JoinPage({Key? key}) : super(key: key);

  @override
  State<JoinPage> createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController message = TextEditingController();

  List<Category>? categories;
  Category? selectedCategory;
  List<Country>? countries;
  Country? selectedCountry;
  List<City>? cities;
  City? selectedCity;
  List<Region>? regions;
  Region? selectedRegion;

  getCategories() async {
    await Api.getCategories(name: "").then((value) {
      setState(() => categories = value);
    });
  }

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

  bool loading = false;

  @override
  void initState() {
    getCategories();
    getCountries();
    super.initState();
  }

  @override

  ///To Do
  Widget build(BuildContext context) {
    final langProvider = Provider.of<AppLanguage>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          localize(context, "joinUs")!,
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
        opacity: 0,
        progressIndicator: Center(child: CircularProgressIndicator()),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        localize(context, "namebrand")!,
                        style: TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE),
                      )),
                  SizedBox(height: 5),
                  CustomField(
                    controller: name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return localize(context, "namebrandRequired");
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        localize(context, "Phone number")!,
                        style: TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE),
                      )),
                  SizedBox(height: 5),
                  CustomField(
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
                        style: TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE),
                      )),
                  SizedBox(height: 5),
                  CustomField(
                    controller: email,
                  ),
                  SizedBox(height: 10),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        localize(context, "category")!,
                        style: TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE),
                      )),
                  SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.CUSTOM_FEILD_GRAY,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: DropdownButton<Category>(
                      underline: Container(),
                      isExpanded: true,
                      icon: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: Colors.grey,
                      ),
                      dropdownColor: Colors.white,
                      elevation: 5,
                      value: selectedCategory,
                      hint: Text(
                        localize(context, "selectCategory")!,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      onChanged: (value) => setState(() {
                        selectedCategory = value;
                      }),
                      items: categories != null
                          ? categories!
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
                  // Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: Text(
                  //       localize(context, "selectCountry")!,
                  //       style: TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE),
                  //     )),
                  // SizedBox(height: 5),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: AppColors.CUSTOM_FEILD_GRAY,
                  //     borderRadius: BorderRadius.all(Radius.circular(10)),
                  //   ),
                  //   child: DropdownButton<Country>(
                  //     underline: Container(),
                  //     isExpanded: true,
                  //     icon: Icon(
                  //       Icons.keyboard_arrow_down_outlined,
                  //       color: Colors.grey,
                  //     ),
                  //     dropdownColor: Colors.white,
                  //     elevation: 5,
                  //     value: selectedCountry,
                  //     hint: Text(
                  //       localize(context, "selectCountry")!,
                  //       style: TextStyle(
                  //         color: Colors.grey,
                  //       ),
                  //     ),
                  //     onChanged: (value) => setState(() {
                  //       selectedCountry = value;
                  //       getCities(selectedCountry!.id);
                  //     }),
                  //     items: countries != null
                  //         ? countries!
                  //             .map(
                  //               (e) => DropdownMenuItem(
                  //                 child: Text(
                  //                   langProvider.appLanguage == "en"
                  //                       ? e.name!
                  //                       : e.arname!,
                  //                   style: TextStyle(
                  //                       color: AppColors.FONT_DROPDOWN),
                  //                 ),
                  //                 value: e,
                  //               ),
                  //             )
                  //             .toList()
                  //         : null,
                  //   ),
                  // ),
                  // SizedBox(height: 10),
                  // Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: Text(
                  //       localize(context, "selectCity")!,
                  //       style: TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE),
                  //     )),
                  // SizedBox(height: 5),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: AppColors.CUSTOM_FEILD_GRAY,
                  //     borderRadius: BorderRadius.all(Radius.circular(10)),
                  //   ),
                  //   child: DropdownButton<City>(
                  //     underline: Container(),
                  //     isExpanded: true,
                  //     icon: Icon(
                  //       Icons.keyboard_arrow_down_outlined,
                  //       color: Colors.grey,
                  //     ),
                  //     dropdownColor: Colors.white,
                  //     value: selectedCity,
                  //     hint: Text(
                  //       localize(context, "selectCity")!,
                  //       style: TextStyle(
                  //         color: Colors.grey,
                  //       ),
                  //     ),
                  //     onChanged: (value) => setState(() {
                  //       selectedCity = value;
                  //       getRegions(selectedCity!.id);
                  //     }),
                  //     items: cities != null
                  //         ? cities!
                  //             .map(
                  //               (e) => DropdownMenuItem(
                  //                 child: Text(
                  //                   langProvider.appLanguage == "en"
                  //                       ? e.name!
                  //                       : e.arname!,
                  //                   style: TextStyle(
                  //                       color: AppColors.FONT_DROPDOWN),
                  //                 ),
                  //                 value: e,
                  //               ),
                  //             )
                  //             .toList()
                  //         : null,
                  //   ),
                  // ),
                  // SizedBox(height: 10),
                  // Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: Text(
                  //       localize(context, "selectRegion")!,
                  //       style: TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE),
                  //     )),
                  // SizedBox(height: 5),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: AppColors.CUSTOM_FEILD_GRAY,
                  //     borderRadius: BorderRadius.all(Radius.circular(10)),
                  //   ),
                  //   child: DropdownButton<Region>(
                  //     underline: Container(),
                  //     isExpanded: true,
                  //     icon: Icon(
                  //       Icons.keyboard_arrow_down_outlined,
                  //       color: Colors.grey,
                  //     ),
                  //     dropdownColor: Colors.white,
                  //     value: selectedRegion,
                  //     hint: Text(
                  //       localize(context, "selectRegion")!,
                  //       style: TextStyle(
                  //         color: Colors.grey,
                  //       ),
                  //     ),
                  //     onChanged: (value) => setState(() {
                  //       selectedRegion = value;
                  //     }),
                  //     items: regions != null
                  //         ? regions!
                  //             .map(
                  //               (e) => DropdownMenuItem(
                  //                 child: Text(
                  //                   langProvider.appLanguage == "en"
                  //                       ? e.name!
                  //                       : e.arname!,
                  //                   style: TextStyle(
                  //                       color: AppColors.FONT_DROPDOWN),
                  //                 ),
                  //                 value: e,
                  //               ),
                  //             )
                  //             .toList()
                  //         : null,
                  //   ),
                  // ),
                  SizedBox(height: 10),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        localize(context, "description")!,
                        style: TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE),
                      )),
                  SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.CUSTOM_FEILD_GRAY,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextFormField(
                      controller: message,
                      maxLines: 6,
                      style: TextStyle(color: Colors.grey),
                      validator: (v) {
                        if (v!.isEmpty) {
                          return localize(context, "messageRequired");
                        }
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText:
                            localize(context, "enter your brand description"),
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  CustomButton(
                    title: localize(context, "joinUs"),
                    onClick: () {
                      join();
                    },
                    colors: 0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  join() async {
    if (formKey.currentState!.validate()) {
      print('selectedCategory!.id ${selectedCategory!.id}');
      String params;
      if (PrefManager.currentUser != null) {
        params = "name=${name.text}"
            "&mobile=${mobile.text}"
            "&email=${email.text}"
            "&catid=${selectedCategory!.id}"
            "&custid=${PrefManager.currentUser!.custId}"
            "&country=5"
            "&city=5"
            "&region=5"
            "&message=${message.text}";
      } else {
        params = "name=${name.text}"
            "&mobile=${mobile.text}"
            "&email=${email.text}"
            "&catid=${selectedCategory!.id}"
            "&country=5"
            "&city=5"
            "&region=5"
            "&message=${message.text}";
      }
      setState(() => loading = true);
      await Api.join(params).then((value) {
        setState(() => loading = false);
        if (value['status'] == true) {
          Fluttertoast.showToast(msg: localize(context, "messageSent")!);
          setState(() {
            name.clear();
            mobile.clear();
            email.clear();
            selectedCategory = null;
            selectedCountry = null;
            selectedCity = null;
            selectedRegion = null;
            message.clear();
          });
        }
      });
    }
  }
}
