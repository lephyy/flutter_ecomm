import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';
import '../main_screen.dart';
import '../page/admin/dashboard.dart';
import '../page/admin/home_screen.dart';

class AuthenticationController extends GetxController {
  final isLoading = false.obs;
  final token = ''.obs;

  static AuthenticationController? _instance;
  static AuthenticationController get instance {
    _instance ??= Get.put(AuthenticationController(), permanent: true);
    return _instance!;
  }

  @override
  void onInit() {
    super.onInit();
    _initializeSession();
  }

  Future<void> _initializeSession() async {
    final storedToken = await getToken();
    if (storedToken != null && storedToken.isNotEmpty) {
      token.value = storedToken;
      debugPrint('✅ Loaded token: $storedToken');

      final userInfo = await fetchUserInfo(storedToken);
      if (userInfo != null) {
        final String? role = userInfo['role'];
        if (role == 'admin') {
          Get.offAll(() => AdminApp());
        } else {
          Get.offAll(() => const HomeMain());
        }
        return;
      }
    }

    Get.offAllNamed('/signIn');
  }

  Future<void> saveToken(String newToken) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', newToken);
      token.value = newToken;
      debugPrint('✅ Token saved successfully: ${newToken.substring(0, 10)}...');
    } catch (e) {
      debugPrint('❌ Error saving token: $e');
      throw e;
    }
  }

  Future<String?> getToken() async {
    try {
      if (token.value.isNotEmpty) {
        debugPrint('🔐 Token from memory: ${token.value.substring(0, 10)}...');
        return token.value;
      }

      final prefs = await SharedPreferences.getInstance();
      final storedToken = prefs.getString('jwt_token');

      if (storedToken != null && storedToken.isNotEmpty) {
        token.value = storedToken;
        debugPrint('🔐 Token from SharedPreferences: ${storedToken.substring(0, 10)}...');
        return storedToken;
      }

      debugPrint('⚠️ No token found');
      return null;
    } catch (e) {
      debugPrint('❌ Error getting token: $e');
      return null;
    }
  }

  Future<void> clearToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('jwt_token');
      token.value = '';
      debugPrint('✅ Token cleared successfully');
    } catch (e) {
      debugPrint('❌ Error clearing token: $e');
    }
  }

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
        Uri.parse(baseUrl + 'register'),
        headers: {'Accept': 'application/json'},
        body: data,
      );

      isLoading.value = false;

      final jsonResponse = json.decode(response.body);
      debugPrint('📦 Register response: ${response.body}');

      if (response.statusCode == 201) {
        // FIXED: Extract token from the correct nested path
        final newToken = jsonResponse['authorization']?['token'] ??
            jsonResponse['token'] ??
            jsonResponse['access_token'] ??
            jsonResponse['data']?['token'] ??
            '';

        if (newToken.isNotEmpty) {
          await saveToken(newToken);
          debugPrint('✅ Registration successful, token saved');

          final String? role = jsonResponse['user']?['role'];
          if (role == 'admin') {
            Get.offAll(() => AdminApp());
          } else {
            Get.offAll(() => const HomeMain());
          }
        } else {
          showError('Registration successful but no token received');
        }
      } else {
        final msg = jsonResponse['message'] ?? 'Registration failed';
        showError(msg);
      }
    } catch (e) {
      isLoading.value = false;
      showError(e.toString());
    }
  }

  Future login({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      var data = {'email': email, 'password': password};

      var response = await http.post(
        Uri.parse(baseUrl + 'login'),
        headers: {'Accept': 'application/json'},
        body: data,
      );

      isLoading.value = false;

      final jsonResponse = json.decode(response.body);
      debugPrint('📦 Login response: ${response.body}');

      if (response.statusCode == 200) {
        // FIXED: Extract token from the correct nested path
        final newToken = jsonResponse['authorization']?['token'] ??
            jsonResponse['token'] ??
            jsonResponse['access_token'] ??
            jsonResponse['data']?['token'] ??
            '';

        if (newToken.isNotEmpty) {
          await saveToken(newToken);
          debugPrint('✅ Login successful, token saved');

          final String? role = jsonResponse['user']?['role'];
          if (role == 'admin') {
            Get.offAll(() => AdminApp());
          } else {
            Get.offAll(() => const HomeMain());
          }
        } else {
          debugPrint("❌ No token found in login response: $jsonResponse");
          showError('Login successful but no token received');
        }
      } else {
        final msg = jsonResponse['message'] ?? 'Login failed';
        showError(msg);
      }
    } catch (e) {
      isLoading.value = false;
      showError(e.toString());
    }
  }

  Future<void> logout() async {
    await clearToken();
    Get.offAllNamed('/signIn');
  }

  void showError(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    debugPrint('❌ $message');
  }

  Future<Map<String, dynamic>?> fetchUserInfo(String token) async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl + 'user'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return jsonResponse['user'] ?? {};
      } else {
        debugPrint('⚠️ Invalid token or session expired');
        return null;
      }
    } catch (e) {
      debugPrint('❌ fetchUserInfo error: $e');
      return null;
    }
  }
}