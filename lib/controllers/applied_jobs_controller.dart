import 'package:get/get.dart';
import 'package:job_nect/models/applied_jobs_model.dart';
import 'package:job_nect/services/urls.dart';

import '../services/api_caller.dart';

class AppliedJobsController extends GetxController {
  bool loading = false;
  AppliedJobsModel appliedJobsModel = AppliedJobsModel();
  List<JobModel>? get jobList => appliedJobsModel.data?.jobList;

  Future<void> getAppliedJobs() async {
    loading = true;
    update();
    final response = await ApiCaller().getRequest(Urls.appliedJobs);
    if (response.isSuccess) {
      appliedJobsModel = AppliedJobsModel.fromJson(response.responseData);
    } else {}
    loading = false;
    update();
  }
}
