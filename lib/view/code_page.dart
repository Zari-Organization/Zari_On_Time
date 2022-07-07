import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:zari/model/service/api.dart';
import 'package:zari/util/style.dart';
import 'package:zari/view/reset_password_page.dart';
import 'package:zari/widgets/custom_button.dart';
import 'package:zari/widgets/custom_field.dart';

import '../constants.dart';

class CodePage extends StatefulWidget {
  final String? mobile;

  CodePage({this.mobile});

  @override
  State<CodePage> createState() => _CodePageState();
}

class _CodePageState extends State<CodePage> {
  bool loading = false;
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController code = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          localize(context, "confirmCode")!,
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
                        localize(context, "enter4digit")!,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    //  Image.asset("assets/images/logo.png", height: 100),
                    SizedBox(height: 60),
                    CustomField(
                      //  title: localize(context, "code"),
                      controller: code,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return localize(context, "codeRequired");
                        }
                      },
                    ),
                    SizedBox(height: 50),
                    CustomButton(
                      title: localize(context, "confirmCode"),
                      onClick: checkCode,
                      colors: 0,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: () => resendCode,
                      child: Text(
                        localize(context, "resend")!,
                        style: TextStyle(color: Colors.black),
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

  checkCode() async {
    if (code.text.isNotEmpty) {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (_) => ResetPasswordPage(),
      //   ),
      // );
      setState(() => loading = true);
      String params = "mobile=${widget.mobile}" "&code=${code.text}";
      await Api.checkOtp(params).then((value) {
        setState(() => loading = false);
        Fluttertoast.showToast(msg: value['msg']);
        if (value['status'] == true) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ResetPasswordPage(),
            ),
          );
        }
      });
    } else {
      Fluttertoast.showToast(msg: localize(context, "codeRequired")!);
    }
  }

  resendCode() async {
    setState(() => loading = true);
    String params = "mobile=${widget.mobile!}";
    await Api.forgetPassword(params).then((value) {
      setState(() => loading = false);
      if (value['status'] == true) {
        Fluttertoast.showToast(msg: value['msg']);
      }
    });
  }
}
