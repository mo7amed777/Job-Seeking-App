import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:eservices/utils/app_colors.dart';
import 'package:eservices/widgets/center_progress_indicator.dart';

import '../../controllers/edit_resume_controller.dart';
import '../../controllers/local_text_controller.dart';
import '../../controllers/resume_details_controller.dart';
import '../../models/app_text_model.dart';
import '../../models/resume_model.dart';
import '../../utils/app_text_styles.dart';
import '../../utils/date_time_utils.dart';
import '../../utils/image_paths.dart';
import '../../utils/ui_helper.dart';
import '../../utils/validator_class.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/bullet_text_titled.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/titled_input_field.dart';

class WorkExperience extends StatefulWidget {
  const WorkExperience({super.key});

  @override
  State<WorkExperience> createState() => _WorkExperienceState();
}

class _WorkExperienceState extends State<WorkExperience> {
  //Resume? resume = Get.find<ResumeDetailsController>().resume;
  Terms? terms = LocalTextController.terms;
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController employerController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  DateTimeRange? selectedDateRange;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: BorderedContainer(
        title: terms?.workExperience ?? "Work Experience",
        body: GetBuilder<ResumeDetailsController>(builder: (controller) {
          Resume? resume = controller.resume;
          if (controller.loading) {
            return const CenterProgressIndicator();
          }
          return Column(
            children: [
              ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: resume?.experiences?.length ?? 0,
                itemBuilder: (context, index) {
                  var exp = resume?.experiences?[index];
                  return BulletTextTitled(
                    title:
                        resume?.experiences?[index].business ?? "Company Name",
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "${exp?.designation} (${exp?.startDate} - ${exp?.endDate})",
                            style: appTextStyleBlack),
                        //Text("UI/UX Designer (Jan 2023-Feb 2024)", style: appTextStyleBlack),
                        Text("${terms?.address ?? "Address"}: ${exp?.location}",
                            style: appTextStyleBlack),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: InkWell(
                                child:
                                    const Icon(Icons.edit, color: colorPrimary),
                                onTap: () {
                                  companyNameController.text =
                                      exp?.business ?? '';
                                  employerController.text = exp?.employer ?? '';
                                  designationController.text =
                                      exp?.designation ?? '';
                                  durationController.text =
                                      "${exp?.startDate} - ${exp?.endDate}" ??
                                          '';
                                  selectedDateRange = DateTimeRange(
                                      start:
                                          DateTime.parse(exp?.startDate ?? ''),
                                      end: DateTime.parse(exp?.endDate ?? ''));
                                  addressController.text = exp?.location ?? '';
                                  showAddOrUpdateModal(context, true,
                                      resume?.experiences?[index].id);
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: InkWell(
                                child:
                                    const Icon(Icons.delete, color: colorRed),
                                onTap: () async {
                                  deleteExperience(context, exp);
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
        }),
      )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: TextButton.icon(
          icon: const Icon(Icons.add),
          label: Text(terms?.addNewExperience ?? "Add Experience"),
          onPressed: () {
            showAddOrUpdateModal(context);
          },
        ),
      ),
    );
  }

  Future<dynamic> deleteExperience(BuildContext context, Experiences? exp) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Are you sure to delete?", style: appTitleStyle),
          content: Row(
            children: [
              Expanded(
                  child: CustomButton(
                      text: terms?.no ?? "No", onTap: () => Get.back())),
              const SizedBox(width: 16),
              Expanded(
                child: CustomButton(
                  text: terms?.yes ?? "Yes",
                  onTap: () async {
                    UiHelper.loadingIndicator();
                    final response = await Get.find<EditResumeController>()
                        .deleteExperience(id: exp?.id);
                    Get.back();
                    Get.back();
                    if (response) {
                      Get.find<ResumeDetailsController>().getResumeDetails();
                      //controller.removeExp(exp?.id);
                      UiHelper.showSnackBar(text: "Deleted Successfully");
                    } else {
                      UiHelper.showSnackBar(
                          text: "Something went wrong", error: true);
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> showAddOrUpdateModal(context, [bool? isUpdating, int? id]) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Text(
                        isUpdating ?? false
                            ? terms?.editExperience ?? "Edit Experience"
                            : terms?.addNewExperience ?? "Add New Experience",
                        style: appTitleStyle),
                    SizedBox(height: 10.h),
                    TitledInputFilled(
                        controller: companyNameController,
                        validator: ValidatorClass().validateEmptyField,
                        title: terms?.organizationName ?? "Organization Name",
                        hintText:
                            terms?.organizationName ?? "enter organization"),
                    SizedBox(height: 8.h),
                    TitledInputFilled(
                        controller: employerController,
                        validator: ValidatorClass().validateEmptyField,
                        title: terms?.employer ?? "Employer",
                        hintText: terms?.employer ?? "enter employer"),
                    SizedBox(height: 8.h),
                    TitledInputFilled(
                        controller: designationController,
                        validator: ValidatorClass().validateEmptyField,
                        title: terms?.designation ?? "Designation",
                        hintText: terms?.designation ?? "enter designation"),
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
                            : "select duration",
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(calender,
                              color: colorBlackLight),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    TitledInputFilled(
                        controller: addressController,
                        validator: ValidatorClass().validateEmptyField,
                        title: terms?.address ?? "Address",
                        hintText: "enter location"),
                    const SizedBox(height: 20),
                    // if (index < (resume?.experiences?.length ?? 0) - 1) const Divider(),
                    // const SizedBox(height: 20),
                    CustomButton(
                      text: terms?.saveAndContinue ??
                          terms?.saveAndContinue ??
                          "Save & Continue",
                      onTap: () async {
                        isUpdating ?? false
                            ? await updateExperience(id)
                            : await addExperience();
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> addExperience() async {
    if (formKey.currentState!.validate()) {
      UiHelper.loadingIndicator();
      final response = await Get.find<EditResumeController>().addNewExperience(
          companyName: companyNameController.text.trim(),
          employer: employerController.text.trim(),
          designation: designationController.text.trim(),
          startDate: DateTimeUtils.formatDate(selectedDateRange!.start),
          endDate: DateTimeUtils.formatDate(selectedDateRange!.end),
          address: addressController.text.trim());
      Get.back();
      Get.back();
      if (response) {
        Get.find<ResumeDetailsController>().getResumeDetails();
        UiHelper.showSnackBar(text: "Added Successfully");
        companyNameController.clear();
        employerController.clear();
        addressController.clear();
        designationController.clear();
        selectedDateRange = null;
      } else {
        UiHelper.showSnackBar(text: "Failed to add", error: true);
      }
    }
  }

  Future<void> updateExperience(id) async {
    if (formKey.currentState!.validate()) {
      UiHelper.loadingIndicator();
      final response = await Get.find<EditResumeController>().updateExperience(
          id: id,
          companyName: companyNameController.text.trim(),
          employer: employerController.text.trim(),
          designation: designationController.text.trim(),
          startDate: DateTimeUtils.formatDate(selectedDateRange!.start),
          endDate: DateTimeUtils.formatDate(selectedDateRange!.end),
          address: addressController.text.trim());
      Get.back();
      Get.back();
      if (response) {
        Get.find<ResumeDetailsController>().getResumeDetails();
        UiHelper.showSnackBar(text: "Update Successfully");
        companyNameController.clear();
        employerController.clear();
        addressController.clear();
        designationController.clear();
        selectedDateRange = null;
      } else {
        UiHelper.showSnackBar(text: "Update Failed", error: true);
      }
    }
  }
}
//
// Future<void> pickDate(context) async {
//   await showDateRangePicker(
//     context: context,
//     firstDate: DateTime(1990),
//     lastDate: DateTime.now(),
//   ).then((value) {
//     if (value != null) {
//       selectedDateRange = value;
//       setState(() {});
//     }
//   });
// }
