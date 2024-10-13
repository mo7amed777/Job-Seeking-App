import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:job_nect/widgets/custom_drop_down.dart';
import 'package:job_nect/widgets/titled_input_field.dart';

import '../../controllers/edit_resume_controller.dart';
import '../../controllers/education_levels_controller.dart';
import '../../controllers/local_text_controller.dart';
import '../../controllers/resume_details_controller.dart';
import '../../models/app_text_model.dart';
import '../../models/resume_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../utils/date_time_utils.dart';
import '../../utils/image_paths.dart';
import '../../utils/ui_helper.dart';
import '../../utils/validator_class.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/bullet_text_titled.dart';
import '../../widgets/custom_button.dart';

class AcademicQualification extends StatefulWidget {
  const AcademicQualification({super.key});

  @override
  State<AcademicQualification> createState() => _AcademicQualificationState();
}

class _AcademicQualificationState extends State<AcademicQualification> {
  Terms? terms = LocalTextController.terms;
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController instituteController = TextEditingController();
  TextEditingController majorController = TextEditingController();
  TextEditingController resultController = TextEditingController();
  TextEditingController examController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  DateTimeRange? selectedDateRange;
  String selectedEducationLevel = educationLevels.first;
  static EducationLevelsController educationLevelController = Get.find<EducationLevelsController>();
  static List<String> educationLevels = educationLevelController.educationLevels ?? [];
  @override
  Widget build(BuildContext context) {
    //Resume? resume = Get.find<ResumeDetailsController>().resume;
    return Scaffold(
      body: SingleChildScrollView(
        child: BorderedContainer(
          title: terms?.academicQualification ?? "Academic Qualification",
          body: GetBuilder<ResumeDetailsController>(
            builder: (controller) {
              Resume? resume = controller.resume;
              return Column(
                children: [
                  ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: resume?.educations?.length ?? 0,
                    itemBuilder: (context, index) {
                      var education = resume?.educations?[index];
                      return BulletTextTitled(
                        title: education?.level ?? "",
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${terms?.institute ?? "Institute"}: ${education?.institute}",
                                style: appTextStyleBlack),
                            Text("${terms?.major ?? "Major"}: ${education?.major}", style: appTextStyleBlack),
                            Text("${terms?.exam ?? "Exam"}: ${education?.exam}", style: appTextStyleBlack),
                            Text("${terms?.result ?? "Result"}: ${education?.result}",
                                style: appTextStyleBlack),
                            Text("${terms?.passingYear ?? "Passing Year"}: ${education?.endDate}",
                                style: appTextStyleBlack),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: InkWell(
                                    child: const Icon(Icons.edit, color: colorPrimary),
                                    onTap: () {
                                      selectedEducationLevel = education?.level ?? '';
                                      instituteController.text = education?.institute ?? '';
                                      majorController.text = education?.major ?? '';
                                      examController.text = education?.exam ?? '';
                                      resultController.text = education?.result ?? '';
                                      durationController.text =
                                          "${education?.startDate} - ${education?.endDate}" ?? '';
                                      selectedDateRange = DateTimeRange(
                                          start: DateTime.parse(education?.startDate ?? ''),
                                          end: DateTime.parse(education?.endDate ?? ''));
                                      showAddOrUpdateModal(context, true, education?.id);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: InkWell(
                                    child: const Icon(Icons.delete, color: colorRed),
                                    onTap: () async {
                                      UiHelper.loadingIndicator();
                                      final response = await Get.find<EditResumeController>()
                                          .deleteEducation(id: education?.id);
                                      Get.back();
                                      if (response) {
                                        Get.find<ResumeDetailsController>().getResumeDetails();
                                        UiHelper.showSnackBar(text: "Deleted Successfully");
                                      } else {
                                        UiHelper.showSnackBar(text: "Something went wrong", error: true);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: TextButton.icon(
          onPressed: () {
            showAddOrUpdateModal(context);
          },
          icon: const Icon(Icons.add),
          label: Text(terms?.addNewQualification ?? "Add Qualification"),
        ),
      ),
    );
  }

  Future<dynamic> showAddOrUpdateModal(context, [bool? isUpdating, int? id]) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Text(
                          isUpdating ?? false
                              ? terms?.editQualification ?? "Edit Qualification"
                              : terms?.addNewQualification ?? "Add New Qualification",
                          style: appTitleStyle),
                      SizedBox(height: 10.h),
                      CustomDropDown(
                          title: terms?.educationLevel ?? "Education Level",
                          items: educationLevels,
                          value: selectedEducationLevel,
                          onChanged: (String? value) {
                            selectedEducationLevel = value!;
                            setState(() {});
                          }),
                      SizedBox(height: 8.h),
                      TitledInputFilled(
                          controller: instituteController,
                          validator: ValidatorClass().validateEmptyField,
                          title: terms?.institute ?? "Institute Name",
                          hintText: terms?.instituteName ?? "enter institute"),
                      SizedBox(height: 8.h),
                      TitledInputFilled(
                          controller: majorController,
                          validator: ValidatorClass().validateEmptyField,
                          title: terms?.major ?? "Major",
                          hintText: terms?.major ?? "enter major"),
                      SizedBox(height: 8.h),
                      TitledInputFilled(
                          controller: examController,
                          validator: ValidatorClass().validateEmptyField,
                          title: terms?.exam ?? "Exam",
                          hintText: terms?.exam ?? "enter exam"),
                      SizedBox(height: 8.h),
                      TitledInputFilled(
                          controller: resultController,
                          validator: ValidatorClass().validateEmptyField,
                          title: terms?.result ?? "Result",
                          hintText: terms?.result ?? "enter result"),
                      SizedBox(height: 8.h),
                      GestureDetector(
                        onTap: () {
                          DateTimeUtils.pickDateRange(context).then(
                            (value) {
                              if (value != null) {
                                selectedDateRange = value;
                                durationController.text =
                                    "${DateTimeUtils.formatDate(selectedDateRange!.start)} - ${DateTimeUtils.formatDate(selectedDateRange!.end)}";
                                setState(() {});
                              }
                            },
                          );
                        },
                        child: TitledInputFilled(
                          controller: durationController,
                          validator: ValidatorClass().validateEmptyField,
                          enabled: false,
                          title: terms?.duration ?? "Duration",
                          hintText: selectedDateRange != null
                              ? "${DateTimeUtils.formatDate(selectedDateRange!.start)} - ${DateTimeUtils.formatDate(selectedDateRange!.end)}"
                              : terms?.duration ?? "select duration",
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(calender, color: colorBlackLight),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // if (index < (resume?.experiences?.length ?? 0) - 1) const Divider(),
                      // const SizedBox(height: 20),
                      CustomButton(
                        text: terms?.saveAndContinue ?? "Save & Continue",
                        onTap: () async {
                          isUpdating ?? false ? await updateEducation(id) : await addEducation();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  Future<void> addEducation() async {
    if (formKey.currentState!.validate()) {
      UiHelper.loadingIndicator();
      final response = await Get.find<EditResumeController>().addNewEducation(
        level: selectedEducationLevel,
        exam: examController.text.trim(),
        major: majorController.text.trim(),
        institute: instituteController.text.trim(),
        result: resultController.text.trim(),
        startDate: DateTimeUtils.formatDate(selectedDateRange!.start),
        endDate: DateTimeUtils.formatDate(selectedDateRange!.end),
      );
      Get.back();
      Get.back();
      if (response) {
        Get.find<ResumeDetailsController>().getResumeDetails();
        UiHelper.showSnackBar(text: "Added Successfully");
        instituteController.clear();
        majorController.clear();
        examController.clear();
        resultController.clear();
        selectedDateRange = null;
      } else {
        UiHelper.showSnackBar(text: "Failed to Add", error: true);
      }
    }
  }

  Future<void> updateEducation(id) async {
    if (formKey.currentState!.validate()) {
      UiHelper.loadingIndicator();
      final response = await Get.find<EditResumeController>().updateEducation(
        id: id,
        level: selectedEducationLevel,
        exam: examController.text.trim(),
        major: majorController.text.trim(),
        institute: instituteController.text.trim(),
        result: resultController.text.trim(),
        startDate: DateTimeUtils.formatDate(selectedDateRange!.start),
        endDate: DateTimeUtils.formatDate(selectedDateRange!.end),
      );
      Get.back();
      Get.back();
      if (response) {
        Get.find<ResumeDetailsController>().getResumeDetails();
        UiHelper.showSnackBar(text: "Update Successfully");
        instituteController.clear();
        majorController.clear();
        examController.clear();
        resultController.clear();
        selectedDateRange = null;
      } else {
        UiHelper.showSnackBar(text: "Update Failed", error: true);
      }
    }
  }
}
