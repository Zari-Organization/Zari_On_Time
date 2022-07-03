import 'package:flutter/material.dart';
import 'package:zari/util/Dimensions.dart';
import 'package:zari/util/style.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onClick;
  final int? colors;
  final int? colorText;
  CustomButton({this.title, this.onClick, this.colors, this.colorText});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: colors == 0 ? AppColors.YALLOW_BUTTON : Colors.white,
      height: 50,
      minWidth: MediaQuery.of(context).size.width,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(7),

      // ),
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: AppColors.YALLOW_BUTTON,
              width: 1,
              style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(7)),
      onPressed: onClick,
      child: Text(
        title!,
        style: TextStyle(
            color: colorText == 0 ? AppColors.YALLOW_BUTTON : Colors.black,
            fontSize: Dimensions.FONT_SIZE_LARGE),
      ),
    );
  }
}
