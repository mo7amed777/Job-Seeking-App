import 'package:get/get.dart';
import 'package:eservices/models/designation_model.dart';
import 'package:eservices/services/urls.dart';

import '../services/api_caller.dart';

class DesignationController extends GetxController {
  bool loading = false;
  DesignationModel designationModel = DesignationModel();
  List<Designation>? get designations => designationModel.designations;

  Future<void> getDesignations() async {
    loading = true;
    update();
    final response = await ApiCaller().getRequest(Urls.designations);
    if (response.isSuccess) {
      designationModel = DesignationModel.fromJson(response.responseData);
    } else {}
    loading = false;
    update();
  }
}
