import 'package:get/get.dart';
import 'package:job_nect/models/skills_model.dart';
import 'package:job_nect/services/urls.dart';

import '../services/api_caller.dart';

class SkillsController extends GetxController {




  var loading = false.obs;
  var skillsModel = SkillsModel().obs;

  List<Skill>? get skills =>
      skillsModel.value.skillsList?.skills;

  var selectedSkill = Rxn<String>();

  @override
  void onInit() {
    getSkills();
    super.onInit();
  }

  Future<void> getSkills() async {
    loading.value = true;
    
    final response = await ApiCaller().getRequest(Urls.skills);
    if (response.isSuccess) {
      skillsModel.value = SkillsModel.fromJson(response.responseData);
    } else {

    }
    loading.value = false;
    
  }
}
