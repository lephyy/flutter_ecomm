import 'package:dio/dio.dart';

class ApiException implements Exception {
  String? message;
  Response<dynamic>? response; // now this is Dio's Response

  ApiException(this.message, this.response) {
    if (message == 'Failed to authenticate.') {
      message = 'Password or Email is incorrect';
    }
    if (message == 'Failed to create record.') {
      if (response?.data is Map) { // using Dio's response.data
        final responseBody = response?.data as Map<String, dynamic>;
        if (responseBody['data'] is Map) {
          final data = responseBody['data'] as Map<String, dynamic>;
          if (data['username'] is Map &&
              data['username']['message'] == 'The username is invalid or already in use.') {
            message = 'Username is already in use.';
          }
          if (data['email'] is Map &&
              data['email']['message'] == 'The Email is invalid or already in use.') {
            message = 'Email is already in use.';
          }
        }
      }
    }
  }
}
