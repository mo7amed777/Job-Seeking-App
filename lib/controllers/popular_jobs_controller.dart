import 'package:get/get.dart';
import 'package:eservices/models/popular_jobs_model.dart';
import 'package:eservices/services/urls.dart';

import '../models/job_model.dart';
import '../services/api_caller.dart';

class PopularJobsController extends GetxController {
  bool loading = false;
  PopularJobsModel popularJobsModel = PopularJobsModel();
  List<Job>? get jobList => popularJobsModel.jobs?.jobs;

  Future<void> getPopularJobs() async {
    loading = true;
    update();
    final response = await ApiCaller().getRequest(Urls.popularJobs);
    if (response.isSuccess) {
      popularJobsModel = PopularJobsModel.fromJson(response.responseData);
    } else {}
    loading = false;
    update();
  }
}
