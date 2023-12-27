import 'package:get/get.dart';
import 'package:getx_task/app/data/local/my_shared_pref.dart';

import '../../../../utils/constants.dart';
import '../../../services/api_call_status.dart';
import '../../../services/base_client.dart';

import 'package:flutter/material.dart';

class UpdatePasswordController extends GetxController {
  TextEditingController passController = TextEditingController();
  TextEditingController oldPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  var ispass = false.obs;
  var isConfirmPass = false.obs;
  var isOldpass = false.obs;

  ApiCallStatus apiCallStatus = ApiCallStatus.success;

  updatePassword() async {
    await BaseClient.safeApiCall(
      Constants.updatePassword,
      RequestType.post,
      headers: {'Authorization': 'Bearer ${MySharedPref.getToken()}'},
      data: {
        "current_password": oldPassController.text,
        "password": passController.text,
        "password_confirm": confirmPassController.text,
      },
      onLoading: () {
        apiCallStatus = ApiCallStatus.loading;
        update();
      },
      onSuccess: (response) async {
        apiCallStatus = ApiCallStatus.success;
        Get.back(result: "Success");

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
