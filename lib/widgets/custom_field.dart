import 'package:flutter/material.dart';
import 'package:zari/util/style.dart';

class CustomField extends StatelessWidget {
  final String? title;
  final TextEditingController? controller;
  final bool? obsecure;
  final TextInputType? inputType;
  final String? Function(String?)? validator;
  final void Function(String?)? search;
  final Widget? widget;
  final Widget? prewidget;

  CustomField({
    this.title,
    this.controller,
    this.obsecure = false,
    this.inputType = TextInputType.text,
    this.validator,
    this.search,
    this.widget,
    this.prewidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: AppColors.CUSTOM_FEILD_GRAY,
      ),
      child: TextFormField(
        validator: validator,
        controller: controller,
        obscureText: obsecure!,
        keyboardType: inputType,
        style: TextStyle(color: Colors.grey),
        onChanged: search,
        decoration: InputDecoration(
          hintText: title,
          prefixIcon: prewidget,
          suffixIcon: widget,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
