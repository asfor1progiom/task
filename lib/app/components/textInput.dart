import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getx_task/utils/constants.dart';

class TextInput extends StatelessWidget {
  TextInput(
      {Key? key,
      required this.controller,
      required this.hint,
      this.validator,
      this.txttype,
      this.onChanged,
      this.ispassword,
      this.suffixIcon,
      this.suffixPressed});

  TextEditingController controller;
  String? hint;
  String? Function(String?)? validator;
  TextInputType? txttype;
  Function(String)? onChanged;
  IconData? suffixIcon;
  bool? ispassword = false;
  VoidCallback? suffixPressed;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      textAlign: TextAlign.center,
      keyboardType: txttype,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: hint,
        hintStyle: TextStyle(
            fontFamily: "AlexandriaFLF",
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.grey),
        contentPadding:
            EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 10.0.w),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14.r)),
            borderSide: const BorderSide(color: AppColors.primary, width: 2)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14.r)),
            borderSide: const BorderSide(color: AppColors.primary, width: 2)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14.r)),
            borderSide: const BorderSide(color: AppColors.primary, width: 2)),
        suffixIcon: suffixIcon != null
            ? IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: Icon(
                  suffixIcon,
                  color: Colors.grey,
                ),
                color: Colors.black,
                onPressed: suffixPressed)
            : null,
      ),
      obscureText: ispassword ?? false,
      controller: controller,
    );
  }
}
