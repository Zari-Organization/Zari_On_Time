import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:zari/model/service/api.dart';
import 'package:zari/util/Dimensions.dart';
import 'package:zari/util/style.dart';
import 'package:zari/view/code_page.dart';
import 'package:zari/widgets/custom_button.dart';
import 'package:zari/widgets/custom_field.dart';

import '../constants.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  bool loading = false;
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController mobile = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          localize(context, "forgetPassword")!,
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
                  //  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 60),

                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        localize(context, "enter your phone")!,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    //  Image.asset("assets/images/logo.png", height: 100),
                    SizedBox(height: 60),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          localize(context, "Phone number")!,
                          style:
                              TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE),
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
                          return localize(context, "phoneLengthError");
                        }
                      },
                    ),
                    SizedBox(height: 50),
                    CustomButton(
                      title: localize(context, "sendCode"),
                      onClick: sendCode,
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

  sendCode() async {
    if (formKey.currentState!.validate()) {
      if (mobile.text.isNotEmpty) {
        setState(() => loading = true);
        String params = "mobile=${mobile.text}";
        await Api.forgetPassword(params).then((value) {
          setState(() => loading = false);
          if (value['status'] == true) {
            Fluttertoast.showToast(msg: value['msg']);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CodePage(mobile: mobile.text),
              ),
            );
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(localize(context, "mobileRequired")!),
          ),
        );
        // Fluttertoast.showToast(msg: localize(context, "mobileRequired")!,);
      }
    }
  }
}
