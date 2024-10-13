import 'package:get/get.dart';
import 'package:eservices/models/resume_model.dart';
import 'package:eservices/services/urls.dart';

import '../services/api_caller.dart';

class ResumeDetailsController extends GetxController {
  bool loading = false;
  ResumeModel resumeModel = ResumeModel();
  Resume? get resume => resumeModel.resume;

  Future<void> getResumeDetails() async {
    loading = true;
    update();
    final response = await ApiCaller().getRequest(Urls.resumeDetails);
    if (response.isSuccess) {
      resumeModel = ResumeModel.fromJson(response.responseData);
    } else {}
    loading = false;
    update();
  }

  void addExp(Experiences exp) {
    resume?.experiences?.add(exp);
    update();
  }

  void removeExp(id) {
    resume?.experiences?.removeWhere((element) => element.id == id);
    update();
  }
}
