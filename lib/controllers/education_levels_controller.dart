import 'package:get/get.dart';
import 'package:eservices/models/education_level_model.dart';
import 'package:eservices/services/urls.dart';

import '../services/api_caller.dart';

class EducationLevelsController extends GetxController {
  bool loading = false;
  EducationLevelsModel educationLevelsModel = EducationLevelsModel();
  List<String>? get educationLevels => educationLevelsModel.educations;

  Future<void> getEducationLevels() async {
    loading = true;
    update();
    final response = await ApiCaller().getRequest(Urls.educationLevels);
    if (response.isSuccess) {
      educationLevelsModel =
          EducationLevelsModel.fromJson(response.responseData);
    } else {}
    loading = false;
    update();
  }
}
