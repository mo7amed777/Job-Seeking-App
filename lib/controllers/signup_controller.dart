import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eservices/utils/ui_helper.dart';

import '../services/api_caller.dart';
import '../services/urls.dart';

class SignupController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  Map<String, String?> validationErrors = {};

  bool signupInProgress = false;
  bool verifyOtpInProgress = false;

  Future<bool> signup() async {
    signupInProgress = true;
    update();

    final response = await ApiCaller().postRequest(Urls.signup, body: {
      'name': nameController.text.trim(),
      'email': emailController.text.trim(),
      'phone': phoneController.text.trim(),
      'password': passwordController.text,
      'password_confirmation': cPasswordController.text,
    });

    if (response.isSuccess) {
      signupInProgress = false;
      update();
      UiHelper.showSnackBar(text: response.responseData['message']);
      return true;
    } else {
      if (response.statusCode == 422 &&
          response.responseData is Map<String, dynamic>) {
        // Extract validation errors from responseData['data']
        validationErrors = (response.responseData as Map<String, dynamic>).map(
          (key, value) => MapEntry(key, (value as List<dynamic>).join(', ')),
        );
      } else {
        // Handle general errors
        UiHelper.showSnackBar(
            text: response.errorMessage ?? 'An unknown error occurred',
            error: true);
      }
      signupInProgress = false;
      update();
      return false;
    }
  }

  Future<bool> verifySignup() async {
    verifyOtpInProgress = true;
    update();

    final response = await ApiCaller().postRequest(Urls.verifySignup, body: {
      'token': otpController.text.trim(),
      'email': emailController.text.trim(),
    });

    var responseData = await response.responseData;
    if (response.isSuccess && responseData['success'] == true) {
      verifyOtpInProgress = false;
      update();
      UiHelper.showSnackBar(text: response.responseData['message']);
      return true;
    } else {
      if (response.statusCode == 422 &&
          response.responseData is Map<String, dynamic>) {
        // Extract validation errors from responseData['data']
        validationErrors = (response.responseData as Map<String, dynamic>).map(
          (key, value) => MapEntry(key, (value as List<dynamic>).join(', ')),
        );
      } else {
        // Handle general errors
        UiHelper.showSnackBar(
            text: response.errorMessage ?? 'An unknown error occurred',
            error: true);
      }
      verifyOtpInProgress = false;
      update();
      return false;
    }
  }
}
