import 'package:get/get.dart';
import 'package:eservices/models/companies_model.dart';
import 'package:eservices/services/urls.dart';

import '../services/api_caller.dart';

class CompaniesController extends GetxController {
  bool loading = false;
  CompaniesModel companiesModel = CompaniesModel();
  List<Company>? get featuredCompanies => companiesModel.companyList?.companies;
  List<Company>? get companies => companiesModel.companyList?.companies;

  Future<void> getFeaturedCompanies() async {
    loading = true;
    update();
    final response = await ApiCaller().getRequest(Urls.featuredCompanies);
    if (response.isSuccess) {
      companiesModel = CompaniesModel.fromJson(response.responseData);
    } else {}
    loading = false;
    update();
  }

  Future<void> getCompanies() async {
    loading = true;
    update();
    final response = await ApiCaller().getRequest(Urls.companies);
    if (response.isSuccess) {
      companiesModel = CompaniesModel.fromJson(response.responseData);
    } else {}
    loading = false;
    update();
  }
}
