import 'package:get/get.dart';
import 'package:getx_task/app/data/local/my_shared_pref.dart';
import 'package:getx_task/app/data/models/user_model.dart';

import '../../../../utils/constants.dart';
import '../../../services/api_call_status.dart';
import '../../../services/base_client.dart';

class HomeController extends GetxController {
  UserModel? data;
  ApiCallStatus apiCallStatus = ApiCallStatus.holding;

  getUserData() async {
    await BaseClient.safeApiCall(
      Constants.getUserApiUrl + "${MySharedPref.getUserId()}",
      RequestType.get,
      headers: {'Authorization': 'Bearer ${MySharedPref.getToken()}'},
      onLoading: () {
        apiCallStatus = ApiCallStatus.loading;
        update();
      },
      onSuccess: (response) {
        data = UserModel.fromJson(response.data);
        apiCallStatus = ApiCallStatus.success;
        update();
      },
      onError: (error) {
        BaseClient.handleApiError(error);
        apiCallStatus = ApiCallStatus.error;
        update();
      },
    );
  }

  deleteAccount() async {
    await BaseClient.safeApiCall(
      Constants.deleteAccount,
      RequestType.delete,
      headers: {'Authorization': 'Bearer ${MySharedPref.getToken()}'},
      onLoading: () {
        apiCallStatus = ApiCallStatus.loading;
        update();
      },
      onSuccess: (response) {
        apiCallStatus = ApiCallStatus.success;
        update();
      },
      onError: (error) {
        BaseClient.handleApiError(error);
        apiCallStatus = ApiCallStatus.error;
        update();
      },
    );
  }

  @override
  void onInit() {
    getUserData();
    super.onInit();
  }
}
