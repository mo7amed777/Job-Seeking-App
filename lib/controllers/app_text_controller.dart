import 'package:get/get.dart';

import '../models/app_text_model.dart';
import '../services/api_caller.dart';
import '../services/urls.dart';
import 'local_text_controller.dart';

class AppTextController extends GetxController {
  bool loading = false;

  AppTextModel _appTextModel = AppTextModel();
  AppText? get appTexts => _appTextModel.appTexts;

  Future<void> getAppTexts(code) async {
    loading = true;
    update();
    final response = await ApiCaller().getRequest(Urls.appTexts(code));
    final responseData = await response.responseData;
    if (response.isSuccess) {
      _appTextModel = AppTextModel.fromJson(responseData);
      await Get.find<LocalTextController>().saveAppTexts(appTexts!);
      // loading = false;
      // update();
    } else {
      //customSnackbar('Error', "Failed to get data", 'error');
    }
    loading = false;
    update();
  }
}
