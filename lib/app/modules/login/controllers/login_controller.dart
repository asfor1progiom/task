import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_task/app/data/local/my_shared_pref.dart';
import 'package:getx_task/app/routes/app_pages.dart';
import 'package:getx_task/app/services/api_call_status.dart';
import 'package:getx_task/app/services/base_client.dart';
import 'package:getx_task/utils/constants.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  var ispass = false.obs;
  ApiCallStatus apiCallStatus = ApiCallStatus.success;
  login() async {
    await BaseClient.safeApiCall(
      Constants.loginApiUrl,
      RequestType.post,
      data: {
        "email": emailController.text,
        "password": passController.text,
      },
      onLoading: () {
        apiCallStatus = ApiCallStatus.loading;
        update();
      },
      onSuccess: (response) async {
        await MySharedPref.setToken(response.data["data"]["token"]);
        await MySharedPref.setUserId(response.data["data"]["id"]);
        apiCallStatus = ApiCallStatus.success;
        Get.offAllNamed(Routes.HOME);
        update();
      },
      onError: (error) {
        BaseClient.handleApiError(error);
        apiCallStatus = ApiCallStatus.error;
        update();
      },
    );
  }
}
