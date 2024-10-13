import 'package:get/get.dart';
import 'package:eservices/models/job_types_filter_model.dart';
import 'package:eservices/services/urls.dart';
import '../services/api_caller.dart';

class JobTypesFilterController extends GetxController {
  var loading = false.obs;
  var jobTypesFilterModel = JobTypesFilterModel().obs;

  List<JobType>? get jobTypes =>
      jobTypesFilterModel.value.jobTypesList?.jobTypes;

  var selectedJobType = Rxn<String>();

  @override
  void onInit() {
    getJobTypesFilter();
    super.onInit();
  }

  Future<void> getJobTypesFilter() async {
    loading.value = true;

    final response = await ApiCaller().getRequest(Urls.jobTypesFilter);
    if (response.isSuccess) {
      jobTypesFilterModel.value =
          JobTypesFilterModel.fromJson(response.responseData);
    } else {
      // Handle the error case if necessary
    }
    loading.value = false;
  }
}
