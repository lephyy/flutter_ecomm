import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../main_screen.dart';
import '../page/admin/home_screen.dart';
import '../page/details/detail_screen.dart';
import '../page/login/signin_screen.dart';
import '../page/login/signup_screen.dart';
import '../models/all_products_model.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.signUp, page: () => SignUpScreen()),
    GetPage(name: AppRoutes.signIn, page: () => SigninScreen()),
    GetPage(name: AppRoutes.homeMain, page: () => const HomeMain()),
    GetPage(name: AppRoutes.adminHome, page: () => const AdminHome()),
    GetPage(
      name: AppRoutes.productDetail,
      page: () {
        final args = Get.arguments as AllProductsModel?;
        return ProductDetail(productDetail: args);
      },
    ),
  ];
}
