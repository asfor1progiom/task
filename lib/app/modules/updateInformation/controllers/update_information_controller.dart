import 'package:get/get.dart';
import 'package:getx_task/app/data/local/my_shared_pref.dart';
import 'package:getx_task/app/data/models/user_model.dart';

import '../../../../utils/constants.dart';
import '../../../services/api_call_status.dart';
import '../../../services/base_client.dart';
import 'package:country_pickers/country_pickers.dart';

import 'package:flutter/material.dart';

class UpdateInformationController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  var countryCode = ''.obs;
  var countryCodeIsoCode = ''.obs;
  var mobile = ''.obs;
  ApiCallStatus apiCallStatus = ApiCallStatus.success;
  @override
  void onInit() {
    Data args = Get.arguments['data'];
    nameController.text = args.name ?? "";
    countryCodeIsoCode.value = CountryPickerUtils.getCountryByPhoneCode(
            args.countryCode?.substring(1) ?? '')
        .isoCode;
    mobile.value = args.phone ?? '';
    countryCode.value = args.countryCode ?? '';
    phoneController.text = args.phone ?? '';

    emailController.text = args.email ?? "";
    super.onInit();
  }

  updateInformation() async {
    await BaseClient.safeApiCall(
      Constants.updateInformation,
      RequestType.post,
      headers: {'Authorization': 'Bearer ${MySharedPref.getToken()}'},
      data: {
        "email": emailController.text,
        "name": nameController.text,
        "phone": mobile.value,
        "country_code": countryCode.value,
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
