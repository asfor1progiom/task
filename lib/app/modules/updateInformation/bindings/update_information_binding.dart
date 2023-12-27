import 'package:get/get.dart';

import '../controllers/update_information_controller.dart';

class UpdateInformationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateInformationController>(
      () => UpdateInformationController(),
    );
  }
}
