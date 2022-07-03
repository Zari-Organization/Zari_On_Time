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

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool isVisibleOldPassword = true;
  _toggle_old() {
    setState(() {
      isVisibleOldPassword = !isVisibleOldPassword;
    });
  }

  bool isVisibleNewPassword = true;
  _toggle_new() {
    setState(() {
      isVisibleNewPassword = !isVisibleNewPassword;
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
  TextEditingController old_password = TextEditingController();
  TextEditingController new_password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          localize(context, "changepassword")!,
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
                    //   Image.asset("assets/images/logo.png", height: 100),
                    SizedBox(height: 50),

                    /// To Do
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          localize(context, "oldPassword")!,
                          style:
                              TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE),
                        )),
                    SizedBox(height: 5),
                    CustomField(
                      title: localize(context, "oldPassword"),
                      controller: old_password,
                      obsecure: isVisibleOldPassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return localize(context, "passwordRequired");
                        }
                      },
                      widget: InkWell(
                        child: Icon(
                          isVisibleOldPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onTap: _toggle_old,
                      ),
                    ),
                    SizedBox(height: 15),
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
                      controller: new_password,
                      obsecure: isVisibleNewPassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return localize(context, "passwordRequired");
                        }
                      },
                      widget: InkWell(
                        child: Icon(
                          isVisibleNewPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onTap: _toggle_new,
                      ),
                    ),

                    SizedBox(height: 15),
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
                        if (value != old_password.text) {
                          return localize(context,
                              "newpasswordandconfirm password didn't match");
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
                    SizedBox(height: 60),
                    CustomButton(
                      title: localize(context, "changepassword"),
                      onClick: resetPassword,
                      colors: 0,
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
      String params = "mobile=${old_password.text}";
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
