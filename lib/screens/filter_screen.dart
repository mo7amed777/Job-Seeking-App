import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:eservices/controllers/skills_controller.dart';
import 'package:get/get.dart';
import 'package:eservices/screens/nav_explore_screen.dart';

import '../controllers/categories_filter_controller.dart';
import '../controllers/job_types_filter_controller.dart';
import '../controllers/local_text_controller.dart';
import '../models/app_text_model.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_drop_down_filter.dart';
import '../widgets/text_back_button.dart';

class FilterScreen extends StatelessWidget {
  FilterScreen({super.key});

  final CategoriesFilterController categoriesFilterController =
      Get.put(CategoriesFilterController());
  final JobTypesFilterController jobTypesFilterController =
      Get.put(JobTypesFilterController());
  final SkillsController skillsController = Get.put(SkillsController());
  final Terms? terms = LocalTextController.terms;

  @override
  Widget build(BuildContext context) {
    // Retrieve arguments passed from NavExploreScreen
    final Map<String, dynamic>? arguments = Get.arguments;
    String? selectedCategoryId = arguments?['categoryId'];

    // Set the selected category in the controller if it exists
    if (selectedCategoryId != null) {
      categoriesFilterController.selectedCategory.value = selectedCategoryId;
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextBackButton(text: terms?.filterJobs ?? "Filter Jobs"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16).copyWith(top: 5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Categories Dropdown
            GetX<CategoriesFilterController>(
              builder: (controller) {
                if (controller.loading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (controller.categoriesFilter == null ||
                    controller.categoriesFilter!.isEmpty) {
                  return const Center(
                      child: Text('No category filters available.'));
                } else {
                  return CustomDropDownFilter(
                    title: "Category",
                    value: controller.selectedCategory.value,
                    items: controller.categoriesFilter!
                        .map((filter) =>
                            MapEntry(filter.value ?? '', filter.text ?? ''))
                        .toList(),
                    onChanged: (String? value) {
                      controller.selectedCategory.value = value;
                    },
                  );
                }
              },
            ),
            SizedBox(height: 8.h),

            // Job Types Dropdown
            GetX<JobTypesFilterController>(
              builder: (controller) {
                if (controller.loading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (controller.jobTypes == null ||
                    controller.jobTypes!.isEmpty) {
                  return const Center(
                      child: Text('No job type filters available.'));
                } else {
                  return CustomDropDownFilter(
                    title: terms?.jobType ?? "Job Type",
                    value: controller.selectedJobType.value,
                    items: controller.jobTypes!
                        .map((filter) =>
                            MapEntry(filter.value ?? '', filter.text ?? ''))
                        .toList(),
                    onChanged: (String? value) {
                      controller.selectedJobType.value = value;
                    },
                  );
                }
              },
            ),
            SizedBox(height: 8.h),

            // Skills Dropdown
            GetX<SkillsController>(
              builder: (controller) {
                if (controller.loading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (controller.skills == null ||
                    controller.skills!.isEmpty) {
                  return const Center(child: Text('No skills available.'));
                } else {
                  return CustomDropDownFilter(
                    title: terms?.skills ?? "Skills",
                    value: controller.selectedSkill.value,
                    items: controller.skills!
                        .map((filter) =>
                            MapEntry(filter.value ?? '', filter.text ?? ''))
                        .toList(),
                    onChanged: (String? value) {
                      controller.selectedSkill.value = value;
                    },
                  );
                }
              },
            ),
            SizedBox(height: 8.h),

            // Additional filters or widgets can go here
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomButton(
          text: terms?.searchJobs ?? "Search Jobs",
          onTap: () {
            // Pass the selected filter values to the NavExploreScreen
            Get.to(() => NavExploreScreen(
                  selectedCategory:
                      categoriesFilterController.selectedCategory.value,
                  selectedJobType:
                      jobTypesFilterController.selectedJobType.value,
                  selectedSkill: skillsController.selectedSkill.value,
                ));
          },
        ),
      ),
    );
  }
}
