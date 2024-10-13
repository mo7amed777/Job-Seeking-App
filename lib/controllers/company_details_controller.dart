import 'package:get/get.dart';
import 'package:eservices/models/company_details_model.dart';
import 'package:eservices/services/urls.dart';

import '../services/api_caller.dart';

class CompanyDetailsController extends GetxController {
  bool loading = false;
  CompanyDetailsModel companyDetailsModel = CompanyDetailsModel();
  Company? get company => companyDetailsModel.data?.company;

  Future<void> getCompanyDetails(companyId) async {
    loading = true;
    update();
    final response =
        await ApiCaller().getRequest(Urls.companyDetails(companyId));
    if (response.isSuccess) {
      companyDetailsModel = CompanyDetailsModel.fromJson(response.responseData);
    } else {}
    loading = false;
    update();
  }
}
