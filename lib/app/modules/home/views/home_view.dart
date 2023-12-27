import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_task/app/components/api_error_widget.dart';
import 'package:getx_task/app/components/my_widgets_animator.dart';
import 'package:getx_task/app/data/local/my_shared_pref.dart';
import 'package:getx_task/app/routes/app_pages.dart';
import 'package:getx_task/config/translations/strings_enum.dart';
import 'package:getx_task/utils/constants.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Home Page',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "AlexandriaFLF",
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: GetBuilder<HomeController>(
        builder: (_) {
          return MyWidgetsAnimator(
            apiCallStatus: controller.apiCallStatus,
            loadingWidget: () => const Center(
              child: CupertinoActivityIndicator(),
            ),
            errorWidget: () => ApiErrorWidget(
              message: Strings.internetError.tr,
              retryAction: () => controller.getUserData(),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
            ),
            successWidget: () => Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.person_2_outlined,
                          size: 25.w, color: AppColors.primary),
                      20.horizontalSpace,
                      Text(
                        controller.data!.data!.name ?? "",
                        style: TextStyle(
                            fontFamily: "AlexandriaFLF",
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      )
                    ],
                  ),
                  20.verticalSpace,
                  Row(
                    children: [
                      Icon(Icons.phone_android,
                          size: 25.w, color: AppColors.primary),
                      20.horizontalSpace,
                      Text(
                        (controller.data!.data!.countryCode ?? "") +
                            " " +
                            (controller.data!.data!.phone ?? ""),
                        style: TextStyle(
                            fontFamily: "AlexandriaFLF",
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      )
                    ],
                  ),
                  20.verticalSpace,
                  Row(
                    children: [
                      Icon(Icons.mail_outline,
                          size: 25.w, color: AppColors.primary),
                      20.horizontalSpace,
                      Text(
                        controller.data!.data!.email ?? "",
                        style: TextStyle(
                            fontFamily: "AlexandriaFLF",
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      )
                    ],
                  ),
                  40.verticalSpace,
                  InkWell(
                    onTap: onTapUpdateInformation,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Update Information',
                          style: TextStyle(
                              fontFamily: "AlexandriaFLF",
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary),
                        ),
                        Icon(Icons.arrow_forward_ios,
                            size: 25.w, color: AppColors.primary),
                      ],
                    ),
                  ),
                  8.verticalSpace,
                  const Divider(color: AppColors.primary),
                  16.verticalSpace,
                  InkWell(
                    onTap: onTapChangePassword,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Change Password',
                          style: TextStyle(
                              fontFamily: "AlexandriaFLF",
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary),
                        ),
                        Icon(Icons.arrow_forward_ios,
                            size: 25.w, color: AppColors.primary),
                      ],
                    ),
                  ),
                  8.verticalSpace,
                  const Divider(color: AppColors.primary),
                  16.verticalSpace,
                  InkWell(
                    onTap: onTapDeleteAccount,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Delete Account',
                          style: TextStyle(
                              fontFamily: "AlexandriaFLF",
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary),
                        ),
                        Icon(Icons.arrow_forward_ios,
                            size: 25.w, color: AppColors.primary),
                      ],
                    ),
                  ),
                  8.verticalSpace,
                  const Divider(color: AppColors.primary),
                  16.verticalSpace,
                  InkWell(
                    onTap: onTapLogout,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Logout',
                          style: TextStyle(
                              fontFamily: "AlexandriaFLF",
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary),
                        ),
                        Icon(Icons.arrow_forward_ios,
                            size: 25.w, color: AppColors.primary),
                      ],
                    ),
                  ),
                  8.verticalSpace,
                  const Divider(color: AppColors.primary),
                  16.verticalSpace,
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void onTapDeleteAccount() {
    Get.defaultDialog(
      title: "Delete Account",
      textConfirm: "yes",
      buttonColor: AppColors.primary,
      confirmTextColor: Colors.white,
      cancelTextColor: AppColors.primary,
      onConfirm: () async {
        controller.deleteAccount();
        await MySharedPref.clear();
        Get.offAllNamed(Routes.Welcome);
      },
      onCancel: () {},
      middleText: "Are you sure you want to delete account ?",
    );
  }

  void onTapLogout() {
    Get.defaultDialog(
      title: "Logout",
      textConfirm: "yes",
      buttonColor: AppColors.primary,
      confirmTextColor: Colors.white,
      cancelTextColor: AppColors.primary,
      onConfirm: () async {
        await MySharedPref.clear();
        Get.offAllNamed(Routes.Welcome);
      },
      onCancel: () {},
      middleText: "Are you sure you want to logout ?",
    );
  }

  Future<void> onTapUpdateInformation() async {
    var data = await Get.toNamed(Routes.UpdateInformationView,
        arguments: {'data': controller.data!.data!});
    if (data == "Success") {
      Get.snackbar(
        "Success",
        "Your infomation is update successfully",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        barBlur: 20,
        isDismissible: true,
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 4),
      );
      controller.getUserData();
    }
  }

  Future<void> onTapChangePassword() async {
    var data = await Get.toNamed(
      Routes.UpdatePasswordView,
    );
    if (data == "Success") {
      Get.snackbar(
        "Success",
        "Your password is update successfully",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        barBlur: 20,
        isDismissible: true,
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 4),
      );
      controller.getUserData();
    }
  }
}
