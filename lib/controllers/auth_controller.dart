import 'dart:convert';

import 'package:get/get.dart';
import 'package:eservices/screens/onboarding_screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../screens/auth_screens/login_screen.dart';

class AuthController extends GetxController {
  static String? token;
  User? user;

  Future<void> saveUserInformation(String t, User userModel) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString('token', t);
    await sp.setString('user', jsonEncode(userModel.toJson()));
    token = t;
    user = userModel;
    update();
  }

  Future<void> updateUserInformation(User userModel) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString('user', jsonEncode(userModel.toJson()));
    user = userModel;
    update();
  }

  Future<void> initializeUserCache() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    token = sp.getString('token');
    user = User.fromJson(jsonDecode(sp.getString('user') ?? '{}'));
    update();
  }

  Future<bool> checkAuthState() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('token');
    if (token != null) {
      await initializeUserCache();
      return true;
    }
    return false;
  }

  static Future<void> clearAuthData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.clear();
    token = null;
  }

  static Future<void> goToLogin() async {
    Get.offAll(() => const SplashScreen());
  }
}
