import 'package:get/get.dart';
import 'package:eservices/models/company_jobs_model.dart';
import 'package:eservices/services/urls.dart';

import '../models/job_model.dart';
import '../services/api_caller.dart';

class CompanyJobsController extends GetxController {
  bool loading = false;
  CompanyJobsModel companyJobsModel = CompanyJobsModel();
  List<Job>? get jobList => companyJobsModel.data?.jobs;

  Future<void> getCompanyJobs(int companyId) async {
    loading = true;
    update();
    final response = await ApiCaller().getRequest(Urls.companyJobs(companyId));
    if (response.isSuccess) {
      companyJobsModel = CompanyJobsModel.fromJson(response.responseData);
    } else {}
    loading = false;
    update();
  }
}
