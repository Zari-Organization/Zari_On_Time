import 'package:flutter/material.dart';
import 'package:zari/util/Dimensions.dart';
import 'package:zari/util/style.dart';
import 'package:zari/view/login_page.dart';
import 'package:zari/widgets/custom_button.dart';

import '../constants.dart';

class NeedLoginWidget extends StatelessWidget {
  const NeedLoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Text(
              localize(context, "needLogin")!,
              style: TextStyle(
                fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 30),
            CustomButton(
              title: localize(context, "login")!,
              onClick: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LoginPage(),
                ),
              ),
              colors: 0,
            ),
            // MaterialButton(
            //   height: 45,
            //   minWidth: 200,
            //   color: AppColors.YALLOW_BUTTON,
            //   onPressed: () => Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (_) => LoginPage(),
            //     ),
            //   ),
            //   child: Text(
            //     localize(context, "login")!,
            //     style: TextStyle(
            //       color: Colors.black,
            //       fontSize: 18,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
