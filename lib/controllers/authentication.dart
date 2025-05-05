import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

import '../constants/constants.dart';
import '../main_screen.dart';
import '../page/admin/home_screen.dart';

class AuthenticationController extends GetxController {
  final isLoading = false.obs;
  final token = ''.obs;

  final box = GetStorage();

  Future register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'name': name,
        'email': email,
        'password': password,
        'confirm_password': confirmPassword,
      };

      var response = await http.post(
        Uri.parse(url + 'register'),
        headers: {'Accept': 'application/json'},
        body: data,
      );

      if (response.statusCode == 201) {
        isLoading.value = false;

        final jsonResponse = json.decode(response.body);
        token.value = jsonResponse['token'] ?? '';
        box.write('token', token.value);

        // Safely access user role with null check
        final user = jsonResponse['user'];
        final String? role = user != null ? user['role'] : null;

        if (role == 'admin') {
          Get.offAll(() => const AdminHome());
        } else {
          Get.offAll(() => const HomeMain());
        }
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'] ?? 'Registration failed',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        debugPrint(json.decode(response.body).toString());
      }
    } catch (e) {
      isLoading.value = false;
      print('Register error: ${e.toString()}');
    }
  }

  Future login({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'email': email,
        'password': password,
      };

      var response = await http.post(
        Uri.parse(url + 'login'),
        headers: {'Accept': 'application/json'},
        body: data,
      );

      if (response.statusCode == 200) {
        isLoading.value = false;

        // Parse the response once and store it
        final jsonResponse = json.decode(response.body);
        debugPrint('Login response: $jsonResponse');

        // Safely access token with null check
        token.value = jsonResponse['token'] ?? '';
        box.write('token', token.value);

        // Safely access user role with null checks
        final user = jsonResponse['user'];
        if (user == null) {
          debugPrint('User data is null in response');
          Get.offAll(() => const HomeMain()); // Default route if user info missing
          return;
        }

        final String? role = user['role'];
        debugPrint('User role: $role');

        if (role == 'admin') {
          Get.offAll(() => const AdminHome());
        } else {
          Get.offAll(() => const HomeMain());
        }
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'] ?? 'Login failed',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        debugPrint('Error response: ${json.decode(response.body)}');
      }
    } catch (e) {
      isLoading.value = false;
      print('Login error: ${e.toString()}');
    }
  }
}