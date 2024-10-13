import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:eservices/utils/ui_helper.dart';

import '../services/api_caller.dart';
import '../services/urls.dart';

class ResetPasswordController extends GetxController {
  bool sendOtpInProgress = false;
  bool resetPassInProgress = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();

  Map<String, String?> validationErrors = {};

  Future<bool> sendOtpToEmail() async {
    sendOtpInProgress = true;
    update();

    final response = await ApiCaller().postRequest(Urls.sendOtpToEmail,
        body: {'email': emailController.text.trim()});

    if (response.isSuccess) {
      sendOtpInProgress = false;
      update();
      return true;
    } else {
      if (response.statusCode == 422 &&
          response.responseData is Map<String, dynamic>) {
        // Extract validation errors from responseData['data']
        validationErrors = (response.responseData as Map<String, dynamic>).map(
          (key, value) => MapEntry(key, (value as List<dynamic>).join(', ')),
        );
      } else {
        validationErrors = {};
        // Handle general errors
        UiHelper.showSnackBar(
            text: response.errorMessage ?? 'An unknown error occurred',
            error: true);
      }

      sendOtpInProgress = false;
      update();
      return false;
    }
  }

  Future<bool> resetPassword() async {
    resetPassInProgress = true;
    update();
    final response = await ApiCaller().postRequest(
      Urls.verifyOtp,
      body: {
        'token': otpController.text.trim(),
        'email': emailController.text.trim(),
        'new_password': passwordController.text.trim(),
        'confirm_password': cPasswordController.text.trim(),
      },
    );
    if (response.isSuccess) {
      resetPassInProgress = false;
      update();
      return true;
    } else {
      if (response.statusCode == 422 &&
          response.responseData is Map<String, dynamic>) {
        // Extract validation errors from responseData['data']
        validationErrors = (response.responseData as Map<String, dynamic>).map(
          (key, value) => MapEntry(key, (value as List<dynamic>).join(', ')),
        );
      } else {
        validationErrors = {};
        // Handle general errors
        UiHelper.showSnackBar(
            text: response.errorMessage ?? 'An unknown error occurred',
            error: true);
      }

      resetPassInProgress = false;
      update();
      return false;
    }
  }
}
