import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job_nect/controllers/job_levels_controller.dart';
import 'package:job_nect/controllers/job_types_controller.dart';
import 'package:job_nect/utils/validator_class.dart';
import 'package:job_nect/widgets/titled_input_field.dart';

import '../../controllers/edit_resume_controller.dart';
import '../../controllers/local_text_controller.dart';
import '../../controllers/resume_details_controller.dart';
import '../../models/app_text_model.dart';
import '../../models/resume_model.dart';
import '../../utils/ui_helper.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_drop_down.dart';

class CareerObject extends StatefulWidget {
  const CareerObject({super.key});

  @override
  State<CareerObject> createState() => _CareerObjectState();
}

class _CareerObjectState extends State<CareerObject> {
  Terms? terms = LocalTextController.terms;
  Resume? resume = Get.find<ResumeDetailsController>().resume;
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController careerObjectiveController = TextEditingController();
  TextEditingController careerSummaryController = TextEditingController();
  TextEditingController presentSalaryController = TextEditingController();
  TextEditingController expectedSalaryController = TextEditingController();
  static List<String> jobLevels = Get.find<JobLevelsController>().jobLevels ?? [];
  String selectedJobLevel = jobLevels.first;
  static List<String> jobTypes = Get.find<JobTypesController>().jobTypes ?? [];
  String selectedJobType = jobTypes.first;

  @override
  void initState() {
    super.initState();
    careerObjectiveController.text = resume?.careerObjective ?? '';
    careerSummaryController.text = resume?.careerSummary ?? '';
    presentSalaryController.text = resume?.presentSalary.toString() ?? '';
    expectedSalaryController.text = resume?.expectedSalary.toString() ?? '';
    selectedJobLevel = resume?.expectedJobLevel ?? jobLevels.first;
    selectedJobType = resume?.expectedJobType ?? jobTypes.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 8.h),
              TitledInputFilled(
                controller: careerObjectiveController,
                validator: ValidatorClass().validateEmptyField,
                title: terms?.careerObjective ?? "Career Objective",
                hintText: terms?.careerObjective ?? "Say something",
                maxLine: 3,
              ),
              SizedBox(height: 8.h),
              TitledInputFilled(
                controller: careerSummaryController,
                validator: ValidatorClass().validateEmptyField,
                title: terms?.careerSummary ?? "Career Summary",
                hintText: terms?.careerSummary ?? "Say something",
                maxLine: 3,
              ),
              SizedBox(height: 8.h),
              TitledInputFilled(
                controller: presentSalaryController,
                validator: ValidatorClass().validateEmptyField,
                title: terms?.presentSalary ?? "Present Salary",
                hintText: terms?.presentSalary ?? "Present Salary",
              ),
              SizedBox(height: 8.h),
              TitledInputFilled(
                controller: expectedSalaryController,
                validator: ValidatorClass().validateEmptyField,
                title: terms?.expectedSalary ?? "Expected Salary",
                hintText: terms?.expectedSalary ?? "Expected Salary",
              ),
              SizedBox(height: 8.h),
              CustomDropDown(
                  title: terms?.jobLevel ?? "Job Level",
                  value: selectedJobLevel,
                  items: jobLevels,
                  onChanged: (value) {
                    selectedJobLevel = value!;
                    setState(() {});
                  }),
              SizedBox(height: 8.h),
              CustomDropDown(
                  title: terms?.jobType ?? "Job Type",
                  value: selectedJobType,
                  items: jobTypes,
                  onChanged: (value) {
                    selectedJobType = value!;
                    setState(() {});
                  }),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomNavBar(),
    );
  }

  Widget bottomNavBar() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 10),
      child: CustomButton(
        text: terms?.saveAndContinue ?? "Save & Continue",
        onTap: () async {
          if (formKey.currentState!.validate()) {
            UiHelper.loadingIndicator();
            final response = await Get.find<EditResumeController>().editCareerInfo(
              careerObjective: careerObjectiveController.text.trim(),
              careerSummary: careerSummaryController.text.trim(),
              presentSalary: presentSalaryController.text.trim(),
              expectedSalary: expectedSalaryController.text.trim(),
              jobLevel: selectedJobLevel,
              jobType: selectedJobType,
            );
            Get.back();
            if (response) {
              Get.find<ResumeDetailsController>().getResumeDetails();
              UiHelper.showSnackBar(text: "Updated Successfully");
            } else {
              UiHelper.showSnackBar(text: "Update Failed", error: true);
            }
          }
        },
      ),
    );
  }
}
