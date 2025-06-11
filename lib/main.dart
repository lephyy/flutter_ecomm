import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'controllers/authentication.dart';
import 'controllers/cart_controller.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetStorage before anything else
  // await GetStorage.init();

  // Put CartController in memory (GetX)
  Get.put(CartController());

  // Register the AuthenticationController globally so it can be found anywhere
  Get.put(AuthenticationController(), permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter E-Commerce',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        fontFamily: 'Poppins',
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      //initial route
      initialRoute: AppRoutes.signIn,

      getPages: AppPages.pages,
    );
  }
}
