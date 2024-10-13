import 'package:get/get.dart';

import '../models/settings_model.dart';
import '../services/api_caller.dart';
import '../services/urls.dart';
import 'local_settings_controller.dart';

class SettingsController extends GetxController {
  bool loading = false;

  SettingsModel settingsModel = SettingsModel();
  Settings? get settings => settingsModel.settings;

  Future<void> getSettings() async {
    loading = true;
    update();
    final response = await ApiCaller().getRequest(Urls.appSettings);
    final responseData = await response.responseData;
    if (response.isSuccess) {
      settingsModel = SettingsModel.fromJson(responseData);
      //Settings settings = Settings.fromJson(responseData['data']);
      await Get.find<LocalSettingsController>().saveSettings(settings!);
    } else {
      //customSnackbar('Error', "Failed to get data", 'error');
    }
    loading = false;
    update();
  }
}
