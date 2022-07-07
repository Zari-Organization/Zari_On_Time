import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:zari/constants.dart';
import 'package:zari/model/core/user.dart';
import 'package:zari/model/service/api.dart';
import 'package:zari/prefs/pref_manager.dart';
import 'package:zari/util/Dimensions.dart';
import 'package:zari/util/Utils.dart';
import 'package:zari/util/style.dart';
import 'package:zari/view/forget_password_page.dart';
import 'package:zari/view/home_page.dart';
import 'package:zari/view/register_page.dart';
import 'package:zari/view/welcome_page.dart';
import 'package:zari/widgets/custom_button.dart';
import 'package:zari/widgets/custom_field.dart';

import 'main_page.dart';

class LoginPage extends StatefulWidget {
  String? routePage;
  LoginPage(this.routePage);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isVisible = true;
  _toggle() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          localize(context, "login")!,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: AppColors.GRAY_APPBAR,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            if (PrefManager.currentUser == null) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => WelcomePage()),
              );
            } else {
              Navigator.of(context).pop();
            }
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        actions: [
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => MainPage()),
                (r) => false,
              ),
              child: Text(
                localize(context, "skip")!,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
      body: LoadingOverlay(
        isLoading: loading,
        opacity: 0.3,
        progressIndicator: Center(child: CircularProgressIndicator()),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(25),
            child: Form(
              key: formKey,
              child: Center(
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/logo-about.png",
                                height: 140,
                              ),
                              SizedBox(height: 60),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    localize(context, "Phone number")!,
                                    style: TextStyle(
                                        fontSize: Dimensions.FONT_SIZE_LARGE),
                                  )),
                              SizedBox(height: 5),
                              CustomField(
                                title: localize(context, "mobile"),
                                controller: mobile,
                                inputType: TextInputType.phone,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return localize(context, "phoneRequired");
                                  }
                                  if (value.length != 11) {
                                    return localize(
                                        context, "phoneLengthError");
                                  }
                                },
                              ),
                              SizedBox(height: 10),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    localize(context, "password")!,
                                    style: TextStyle(
                                        fontSize: Dimensions.FONT_SIZE_LARGE),
                                  )),
                              SizedBox(height: 5),
                              CustomField(
                                title: localize(context, "password"),
                                controller: password,
                                obsecure: isVisible,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return localize(
                                        context, "passwordRequired");
                                  }
                                },
                                widget: InkWell(
                                  child: Icon(
                                    isVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                  onTap: _toggle,
                                ),
                              ),
                              SizedBox(height: 15),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ForgetPasswordPage(),
                                    ),
                                  ),
                                  child: Text(
                                    localize(context, "forgetPassword")! +
                                        localize(context, "?")!,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              CustomButton(
                                title: localize(context, "login"),
                                onClick: login,
                              ),
                              SizedBox(height: 25),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    localize(
                                        context, "don\'t have an account?")!,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        pushToPage(context, RegisterPage()),
                                    child: Text(
                                      localize(context, "sign up")!,
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    if (formKey.currentState!.validate()) {
      setState(() => loading = true);
      String params = "mobile=${mobile.text}" "&password=${password.text}";

      await Api.login(params).then((value) {
        if (value['status'] != false) {
          User user = User.fromJson(value);
          PrefManager.setCurrentUser(user).then((value2) {
            setState(() => loading = false);
            /*Fluttertoast.showToast(
                msg: localize(context, "loggedInSuccessfully")!);*/
            Utils.route_Login(widget.routePage ?? '', context);
            //   Navigator.pop(context, true);
            // Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(builder: (_) => MainPage()),
            //   (route) => false,
            // );
          });
        } else {
          setState(() => loading = false);
          Fluttertoast.showToast(msg: localize(context, "customerNotFound")!);
        }
      });
    }
  }
}
