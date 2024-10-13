import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eservices/controllers/auth_controller.dart';
import 'package:eservices/utils/ui_helper.dart';

import '../models/user.dart';
import '../services/api_caller.dart';
import '../services/urls.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorMessage = '';
  bool loginInProgress = false;

  Map<String, String?> validationErrors = {};

  Future<bool> login() async {
    loginInProgress = true;
    update();
    final response = await ApiCaller().postRequest(Urls.login, body: {
      'email': emailController.text.trim(),
      'password': passwordController.text,
    });
    var responseData = await response.responseData;
    if (response.isSuccess) {
      String token = responseData['data']['access_token'];
      User user = User.fromJson(responseData['data']['user']);
      await Get.find<AuthController>().saveUserInformation(token, user);
      loginInProgress = false;
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

      loginInProgress = false;
      update();
      return false;
    }
  }
}
