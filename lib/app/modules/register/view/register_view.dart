import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_task/app/components/TextInput.dart';
import 'package:getx_task/app/components/api_error_widget.dart';
import 'package:getx_task/app/components/bottun_primary.dart';
import 'package:getx_task/app/components/my_widgets_animator.dart';
import 'package:getx_task/app/modules/register/controllers/register_controller.dart';
import 'package:getx_task/app/routes/app_pages.dart';
import 'package:getx_task/config/translations/strings_enum.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../../../utils/constants.dart';

// ignore: must_be_immutable
class RegisterView extends GetView<RegisterController> {
  var formkey = GlobalKey<FormState>();

  RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              60.verticalSpace,
              Image.asset("assets/images/logo.png", height: 120.h),
              20.verticalSpace,
              Text(
                'Register',
                style: TextStyle(
                    fontFamily: "AlexandriaFLF",
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary),
              ),
              40.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: TextInput(
                  controller: controller.nameController,
                  hint: "Full Name",
                  validator: validateName,
                ),
              ),
              20.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: textInputWithCountrycode(controller),
              ),
              20.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: TextInput(
                  controller: controller.emailController,
                  hint: "Email Address",
                  validator: validateEmail,
                ),
              ),
              20.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: Obx(() {
                  return TextInput(
                    controller: controller.passController,
                    hint: "Paassword",
                    validator: validatePass,
                    ispassword: controller.ispass.value,
                    suffixIcon: controller.ispass.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                    suffixPressed: () {
                      controller.ispass.value = !controller.ispass.value;
                    },
                  );
                }),
              ),
              20.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: Obx(() {
                  return TextInput(
                    controller: controller.confirmPassController,
                    hint: "Confirm Paassword",
                    validator: validateisConfirmPass,
                    ispassword: controller.isConfirmPass.value,
                    suffixIcon: controller.isConfirmPass.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                    suffixPressed: () {
                      controller.isConfirmPass.value =
                          !controller.isConfirmPass.value;
                    },
                  );
                }),
              ),
              50.verticalSpace,
              GetBuilder<RegisterController>(
                builder: (_) {
                  return MyWidgetsAnimator(
                    apiCallStatus: controller.apiCallStatus,
                    loadingWidget: () => const Center(
                      child: CupertinoActivityIndicator(),
                    ),
                    errorWidget: () => BottunPrimary(
                      onpressed: () {
                        if (formkey.currentState!.validate()) {
                          controller.register();
                        }
                      },
                      txt: 'Register',
                      background: AppColors.primary,
                    ),
                    successWidget: () => BottunPrimary(
                      onpressed: () {
                        if (formkey.currentState!.validate()) {
                          controller.register();
                        }
                      },
                      txt: 'Register',
                      background: AppColors.primary,
                    ),
                  );
                },
              ),
              20.verticalSpace,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 12.h),
                    child: Text(
                      "Don't have an account?",
                      style: TextStyle(
                          fontFamily: "AlexandriaFLF",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.offAndToNamed(Routes.LoginView);
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 12.h),
                      child: Text(
                        ' Login',
                        style: TextStyle(
                            fontFamily: "AlexandriaFLF",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary),
                      ),
                    ),
                  ),
                ],
              ),
              50.verticalSpace,
            ],
          ),
        ),
      )),
    );
  }

  String? validatePass(String? value) {
    if (value!.length == 0)
      return 'Please enter Password';
    else if (value.length < 8 || value.length > 32) {
      return 'Password value range 8-32 char';
    } else
      return null;
  }

  String? validateName(String? value) {
    if (value!.length == 0) {
      return 'Please enter Full Name';
    } else {
      return null;
    }
  }

  String? validateisConfirmPass(String? value) {
    if (value!.length == 0) {
      return 'Please enter Confirm Password';
    } else if (value != controller.passController.text) {
      return "passwords not matched.";
    } else
      return null;
  }

  String? validateEmail(String? value) {
    if (value!.length == 0) return 'Please enter email address';
    const pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+";

    final regex = RegExp(pattern);

    return value.isNotEmpty && !regex.hasMatch(value)
        ? 'Please enter email address'
        : null;
  }

  Widget textInputWithCountrycode(RegisterController controller) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: IntlPhoneField(
        flagsButtonPadding: EdgeInsets.symmetric(horizontal: 12.w),
        dropdownIcon: const Icon(null),
        initialCountryCode: "TR",
        dropdownTextStyle: TextStyle(fontSize: 12.w),
        style: TextStyle(fontSize: 12.w),
        showDropdownIcon: false,
        showCountryFlag: true,
        onCountryChanged: (c) {
          controller.countryCode.value = '+${c.dialCode}';
        },
        onChanged: (PhoneNumber phoneNumber) {
          controller.countryCode.value = phoneNumber.countryCode;
          controller.mobile.value = phoneNumber.number;
        },
        autovalidateMode: AutovalidateMode.always,
        validator: (PhoneNumber? v) {
          if (v?.number == "") {
            return "Please verify the phone number";
          }
          return null;
        },
        controller: controller.phoneController,
        invalidNumberMessage: "Please verify the phone number",
        decoration: InputDecoration(
            hintTextDirection: TextDirection.rtl,
            alignLabelWithHint: true,
            hintText: '5555555555',
            hintStyle: TextStyle(
                fontFamily: "AlexandriaFLF",
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey),
            contentPadding: EdgeInsets.symmetric(
              vertical: 15.h,
              horizontal: 10.w,
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: 2, style: BorderStyle.solid, color: AppColors.primary),
              borderRadius: BorderRadius.all(
                Radius.circular(14.r),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: 2, style: BorderStyle.solid, color: AppColors.primary),
              borderRadius: BorderRadius.all(
                Radius.circular(14.r),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: 1, style: BorderStyle.solid, color: AppColors.primary),
              borderRadius: BorderRadius.all(
                Radius.circular(14.r),
              ),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelStyle: TextStyle(
              fontSize: 14.h,
            ),
            errorStyle: TextStyle(fontSize: 14.h),
            fillColor: Colors.white70),
      ),
    );
  }
}
