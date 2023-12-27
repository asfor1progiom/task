import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_task/app/components/bottun.dart';

import 'package:getx_task/app/components/bottun_primary.dart';
import 'package:getx_task/app/routes/app_pages.dart';

import '../../../../utils/constants.dart';

class WelcomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          60.verticalSpace,
          Image.asset("assets/images/logo.png", height: 120.h),
          20.verticalSpace,
          Text(
            'Welcome to the app',
            style: TextStyle(
                fontFamily: "AlexandriaFLF",
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primary),
          ),
          300.verticalSpace,
          BottunPrimary(
            onpressed: () {
              Get.toNamed(Routes.LoginView);
            },
            txt: 'Login',
            background: AppColors.primary,
          ),
          20.verticalSpace,
          Bottun(
            onpressed: () {
              Get.toNamed(Routes.RegisterView);
            },
            txt: 'Register',
            background: AppColors.primary,
          ),
        ],
      )),
    );
  }
}
