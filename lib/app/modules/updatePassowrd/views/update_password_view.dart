import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_task/app/components/TextInput.dart';
import 'package:getx_task/app/components/bottun_primary.dart';
import 'package:getx_task/app/components/my_widgets_animator.dart';
import 'package:getx_task/app/modules/updatePassowrd/controllers/update_password_controller.dart';

import '../../../../utils/constants.dart';

// ignore: must_be_immutable
class UpdatePasswordView extends GetView<UpdatePasswordController> {
  var formkey = GlobalKey<FormState>();

  UpdatePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          'Change Password',
          style: TextStyle(
            fontFamily: "AlexandriaFLF",
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
          child: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              40.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: Obx(() {
                  return TextInput(
                    controller: controller.oldPassController,
                    hint: "Current Paassword",
                    validator: validatePass,
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
              GetBuilder<UpdatePasswordController>(
                builder: (_) {
                  return MyWidgetsAnimator(
                    apiCallStatus: controller.apiCallStatus,
                    loadingWidget: () => const Center(
                      child: CupertinoActivityIndicator(),
                    ),
                    errorWidget: () => BottunPrimary(
                      onpressed: () {
                        if (formkey.currentState!.validate()) {
                          controller.updatePassword();
                        }
                      },
                      txt: 'Save',
                      background: AppColors.primary,
                    ),
                    successWidget: () => BottunPrimary(
                      onpressed: () {
                        if (formkey.currentState!.validate()) {
                          controller.updatePassword();
                        }
                      },
                      txt: 'Save',
                      background: AppColors.primary,
                    ),
                  );
                },
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

  String? validateisConfirmPass(String? value) {
    if (value!.length == 0) {
      return 'Please enter Confirm Password';
    } else if (value != controller.passController.text) {
      return "passwords not matched.";
    } else
      return null;
  }
}
