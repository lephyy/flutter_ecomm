import 'package:flutter/material.dart';
import 'package:flutter_ecomm/main_screen.dart';
import 'package:flutter_ecomm/page/login/signin_screen.dart';
import 'package:flutter_ecomm/controllers/auth_controller.dart';
import 'package:flutter_ecomm/controllers/theme_controller.dart';
import 'package:flutter_ecomm/utils/app_themes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async{
  await GetStorage.init();
  Get.put(ThemeController());
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: SigninScreen(),
    );
  }
}