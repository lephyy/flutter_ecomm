
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../main_screen.dart';
import '../page/admin/home_screen.dart';
import '../page/login/signin_screen.dart';
import '../page/login/signup_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.signUp, page: () => SignUpScreen()),
    GetPage(name: AppRoutes.signIn, page: () => SigninScreen()),
    GetPage(name: AppRoutes.homeMain, page: () => HomeMain()),
    GetPage(name: AppRoutes.adminHome, page: () => AdminHome()),
  ];
}