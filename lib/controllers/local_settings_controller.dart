import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/settings_model.dart';

class LocalSettingsController extends GetxController {
  //static String? selectedLanguage;
  static Settings? setting;

  Future<void> saveSettings(Settings settings) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString('setting', jsonEncode(settings.toJson()));
    setting = settings;
    update();
  }

  // Future<void> updateAppTexts(AppText model) async {
  //   SharedPreferences sp = await SharedPreferences.getInstance();
  //   await sp.setString('texts', jsonEncode(model.toJson()));
  //   text = model;
  //   update();
  // }

  Future<bool> checkIsSettingsSaved() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? setting = sp.getString('setting');
    if (setting != null) {
      await initializeSettings();
      return true;
    }
    return false;
  }

  Future<void> initializeSettings() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setting = Settings.fromJson(jsonDecode(sp.getString('setting') ?? '{}'));
    update();
  }
}
