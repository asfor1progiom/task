import 'package:get/get.dart';
import 'package:getx_task/app/modules/login/bindings/login_binding.dart';
import 'package:getx_task/app/modules/login/view/login_view.dart';
import 'package:getx_task/app/modules/register/bindings/register_binding.dart';
import 'package:getx_task/app/modules/register/view/register_view.dart';
import 'package:getx_task/app/modules/updateInformation/bindings/update_information_binding.dart';
import 'package:getx_task/app/modules/updateInformation/views/update_information_view.dart';
import 'package:getx_task/app/modules/updatePassowrd/bindings/update_password_binding.dart';
import 'package:getx_task/app/modules/updatePassowrd/views/update_password_view.dart';
import 'package:getx_task/app/modules/welcome/view/welcome_view.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIALWelcome = Routes.Welcome;
  static const INITIALHOME = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.LoginView,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.RegisterView,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.UpdateInformationView,
      page: () => UpdateInformationView(),
      binding: UpdateInformationBinding(),
    ),
    GetPage(
      name: Routes.UpdatePasswordView,
      page: () => UpdatePasswordView(),
      binding: UpdatePasswordBinding(),
    ),
    GetPage(
      name: Routes.Welcome,
      page: () => WelcomeView(),
    ),
  ];
}
