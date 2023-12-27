import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_task/app/components/TextInput.dart';
import 'package:getx_task/app/components/api_error_widget.dart';
import 'package:getx_task/app/components/bottun_primary.dart';
import 'package:getx_task/app/components/my_widgets_animator.dart';
import 'package:getx_task/app/modules/updateInformation/controllers/update_information_controller.dart';
import 'package:getx_task/config/translations/strings_enum.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../../../utils/constants.dart';

// ignore: must_be_immutable
class UpdateInformationView extends GetView<UpdateInformationController> {
  var formkey = GlobalKey<FormState>();

  UpdateInformationView({super.key});

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
          'Update Information',
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
              50.verticalSpace,
              GetBuilder<UpdateInformationController>(
                builder: (_) {
                  return MyWidgetsAnimator(
                    apiCallStatus: controller.apiCallStatus,
                    loadingWidget: () => const Center(
                      child: CupertinoActivityIndicator(),
                    ),
                    errorWidget: () => BottunPrimary(
                      onpressed: () {
                        if (formkey.currentState!.validate()) {
                          controller.updateInformation();
                        }
                      },
                      txt: 'Save',
                      background: AppColors.primary,
                    ),
                    successWidget: () => BottunPrimary(
                      onpressed: () {
                        if (formkey.currentState!.validate()) {
                          controller.updateInformation();
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

  String? validateName(String? value) {
    if (value!.length == 0) {
      return 'Please enter Full Name';
    } else {
      return null;
    }
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

  Widget textInputWithCountrycode(UpdateInformationController controller) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: IntlPhoneField(
        flagsButtonPadding: EdgeInsets.symmetric(horizontal: 12.w),
        dropdownIcon: const Icon(null),
        initialCountryCode: controller.countryCodeIsoCode.value,
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
