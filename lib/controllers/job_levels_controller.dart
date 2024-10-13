import 'package:get/get.dart';
import 'package:job_nect/models/job_levels_model.dart';
import 'package:job_nect/services/urls.dart';

import '../services/api_caller.dart';

class JobLevelsController extends GetxController {
  bool loading = false;
  JobLevelsModel jobLevelsModel = JobLevelsModel();
  List<String>? get jobLevels => jobLevelsModel.jobLevels;

  Future<void> getJobLevels() async {
    loading = true;
    update();
    final response = await ApiCaller().getRequest(Urls.jobLevels);
    if (response.isSuccess) {
      jobLevelsModel = JobLevelsModel.fromJson(response.responseData);
    } else {}
    loading = false;
    update();
  }
}
