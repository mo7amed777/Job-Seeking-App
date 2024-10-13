import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_text_model.dart';

class LocalTextController extends GetxController {
  //static String? selectedLanguage;
  static AppText? text;
  static get terms => text?.terms;

  Future<void> saveAppTexts(AppText model) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString('texts', jsonEncode(model.toJson()));
    text = model;
    update();
  }

  // Future<void> updateAppTexts(AppText model) async {
  //   SharedPreferences sp = await SharedPreferences.getInstance();
  //   await sp.setString('texts', jsonEncode(model.toJson()));
  //   text = model;
  //   update();
  // }

  Future<bool> checkIsTextSaved() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? text = sp.getString('texts');
    if (text != null) {
      await initializeAppText();
      return true;
    }
    return false;
  }

  Future<void> initializeAppText() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    text = AppText.fromJson(jsonDecode(sp.getString('texts') ?? '{}'));
    update();
  }
}
