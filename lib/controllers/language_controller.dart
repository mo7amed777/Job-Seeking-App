import 'package:get/get.dart';

import '../models/languages_model.dart';
import '../services/api_caller.dart';
import '../services/urls.dart';

class LanguageController extends GetxController {
  bool loading = false;

  LanguagesModel _languagesModel = LanguagesModel();
  List<Language> languages = []; // This will hold the languages

  Future<void> getLanguages() async {
    loading = true;
    update();
    final response = await ApiCaller().getRequest(Urls.appLanguages);

    final responseData = await response.responseData;
    if (response.isSuccess) {
      _languagesModel = LanguagesModel.fromJson(responseData);
      languages = _languagesModel.languages ?? []; // Update the languages list
    } else {
      //customSnackbar('Error', "Failed to get data", 'error');
    }
    loading = false;
    update(); // This will trigger the UI to update
  }
}
