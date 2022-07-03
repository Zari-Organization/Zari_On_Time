import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:zari/model/service/api.dart';
import 'package:zari/util/Dimensions.dart';
import 'package:zari/util/style.dart';
import 'package:zari/view/login_page.dart';
import 'package:zari/widgets/custom_button.dart';
import 'package:zari/widgets/custom_field.dart';

import '../constants.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  bool isVisiblePassword = true;
  _toggle() {
    setState(() {
      isVisiblePassword = !isVisiblePassword;
    });
  }

  bool isVisible_CWpassword = true;
  _toggle_cW() {
    setState(() {
      isVisible_CWpassword = !isVisible_CWpassword;
    });
  }

  bool loading = false;
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          localize(context, "resetpassword")!,
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
            padding: EdgeInsets.all(25),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 60),

                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        localize(context, "set your new password")!,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    //   Image.asset("assets/images/logo.png", height: 100),
                    SizedBox(height: 50),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          localize(context, "newPassword")!,
                          style:
                              TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE),
                        )),
                    SizedBox(height: 5),
                    CustomField(
                      title: localize(context, "newPassword"),
                      controller: password,
                      obsecure: isVisiblePassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return localize(context, "passwordRequired");
                        }
                      },
                      widget: InkWell(
                        child: Icon(
                          isVisiblePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onTap: _toggle,
                      ),
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
                      obsecure: isVisible_CWpassword,
                      validator: (value) {
                        if (value != password.text) {
                          return localize(context,
                              "password and  confirm password didn't match");
                        }
                      },
                      widget: InkWell(
                        child: Icon(
                          isVisible_CWpassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onTap: _toggle_cW,
                      ),
                    ),
                    SizedBox(height: 50),
                    CustomButton(
                      title: localize(context, "reset"),
                      onClick: resetPassword,
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

  resetPassword() async {
    if (formKey.currentState!.validate()) {
      //   if (password.text == confirmPassword.text) {
      setState(() => loading = true);
      String params = "mobile=${password.text}";
      await Api.forgetPassword(params).then((value) {
        setState(() => loading = false);
        if (value['status'] == true) {
          Fluttertoast.showToast(msg: value['msg']);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => LoginPage(),
            ),
            (r) => false,
          );
        }
      });
    }
  }
}
