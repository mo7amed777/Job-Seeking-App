import 'package:get/get.dart';
import 'package:eservices/models/job_types_model.dart';
import 'package:eservices/services/urls.dart';

import '../services/api_caller.dart';

class JobTypesController extends GetxController {
  bool loading = false;
  JobTypesModel jobTypesModel = JobTypesModel();
  List<String>? get jobTypes => jobTypesModel.jobTypes;

  Future<void> getJobTypes() async {
    loading = true;
    update();
    final response = await ApiCaller().getRequest(Urls.jobTypes);
    if (response.isSuccess) {
      jobTypesModel = JobTypesModel.fromJson(response.responseData);
    } else {}
    loading = false;
    update();
  }
}
