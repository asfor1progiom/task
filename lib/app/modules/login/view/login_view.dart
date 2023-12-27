import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_task/app/components/TextInput.dart';

import 'package:getx_task/app/components/bottun_primary.dart';
import 'package:getx_task/app/components/my_widgets_animator.dart';
import 'package:getx_task/app/modules/login/controllers/login_controller.dart';
import 'package:getx_task/app/routes/app_pages.dart';

import '../../../../utils/constants.dart';

// ignore: must_be_immutable
class LoginView extends GetView<LoginController> {
  var formkey = GlobalKey<FormState>();

  LoginView({super.key});

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
                'Login',
                style: TextStyle(
                    fontFamily: "AlexandriaFLF",
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary),
              ),
              140.verticalSpace,
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
              50.verticalSpace,
              GetBuilder<LoginController>(
                builder: (_) {
                  return MyWidgetsAnimator(
                    apiCallStatus: controller.apiCallStatus,
                    loadingWidget: () => const Center(
                      child: CupertinoActivityIndicator(),
                    ),
                    errorWidget: () => BottunPrimary(
                      onpressed: () {
                        if (formkey.currentState!.validate()) {
                          controller.login();
                        }
                      },
                      txt: 'Login',
                      background: AppColors.primary,
                    ),
                    successWidget: () => BottunPrimary(
                      onpressed: () {
                        if (formkey.currentState!.validate()) {
                          controller.login();
                        }
                      },
                      txt: 'Login',
                      background: AppColors.primary,
                    ),
                  );
                },
              ),
              100.verticalSpace,
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
                      Get.offAndToNamed(Routes.RegisterView);
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 12.h),
                      child: Text(
                        ' Register',
                        style: TextStyle(
                            fontFamily: "AlexandriaFLF",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary),
                      ),
                    ),
                  ),
                ],
              )
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

  String? validateEmail(String? value) {
    if (value!.length == 0) return 'Please enter email address';
    const pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+";
    final regex = RegExp(pattern);

    return value.isNotEmpty && !regex.hasMatch(value)
        ? 'Please enter email address'
        : null;
  }
}
