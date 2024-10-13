import 'package:get/get.dart';
import 'package:job_nect/models/job_details_model.dart';
import 'package:job_nect/models/job_model.dart';
import 'package:job_nect/services/urls.dart';

import '../services/api_caller.dart';

class JobDetailsController extends GetxController {
  bool loading = false;
  JobDetailsModel jobDetailsModel = JobDetailsModel();
  Job? get jobDetails => jobDetailsModel.data?.job;

  Future<void> getJobDetails(jobId) async {
    loading = true;
    update();
    final response = await ApiCaller().getRequest(Urls.jobDetails(jobId));
    if (response.isSuccess) {
      jobDetailsModel = JobDetailsModel.fromJson(response.responseData);
    } else {}
    loading = false;
    update();
  }

  // CompanyJobsModel companyJobsModel = CompanyJobsModel();
  // List<Job>? get jobList => companyJobsModel.data?.jobs;
  //
  // Future<void> getCompanyJobs(int companyId) async {
  //   loading = true;
  //   update();
  //   final response = await ApiCaller().getRequest(Urls.companyJobs(companyId));
  //   if (response.isSuccess) {
  //     companyJobsModel = CompanyJobsModel.fromJson(response.responseData);
  //   } else {}
  //   loading = false;
  //   update();
  // }
}
