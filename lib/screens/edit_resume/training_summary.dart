import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:job_nect/controllers/resume_details_controller.dart';
import 'package:job_nect/models/resume_model.dart';

import '../../controllers/edit_resume_controller.dart';
import '../../controllers/local_text_controller.dart';
import '../../models/app_text_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../utils/date_time_utils.dart';
import '../../utils/image_paths.dart';
import '../../utils/ui_helper.dart';
import '../../utils/validator_class.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/bullet_text_titled.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/titled_input_field.dart';

class TrainingSummary extends StatefulWidget {
  const TrainingSummary({super.key});

  @override
  State<TrainingSummary> createState() => _TrainingSummaryState();
}

class _TrainingSummaryState extends State<TrainingSummary> {
  Terms? terms = LocalTextController.terms;
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController instituteController = TextEditingController();
  TextEditingController topicController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  DateTimeRange? selectedDateRange;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BorderedContainer(
          title: terms?.trainingSummary ?? "Training Summary",
          body: GetBuilder<ResumeDetailsController>(builder: (controller) {
            Resume? resume = controller.resume;
            return Column(
              children: [
                ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: resume?.trainings?.length ?? 0,
                  itemBuilder: (context, index) {
                    final training = resume?.trainings?[index];
                    return BulletTextTitled(
                      title: training?.name ?? "",
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${terms?.institute ?? "Institute"}: ${training?.institute}",
                              style: appTextStyleBlack),
                          Text("${terms?.topic ?? "Topic"}: ${training?.topics}", style: appTextStyleBlack),
                          Text("${terms?.location ?? "Location"}: ${training?.location}",
                              style: appTextStyleBlack),
                          Text(
                              "${terms?.duration ?? "Duration"}: ${training?.startDate} - ${training?.endDate}",
                              style: appTextStyleBlack),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: InkWell(
                                  child: const Icon(Icons.edit, color: colorPrimary),
                                  onTap: () {
                                    nameController.text = training?.name ?? '';
                                    instituteController.text = training?.institute ?? '';
                                    topicController.text = training?.topics ?? '';
                                    locationController.text = training?.location ?? '';
                                    durationController.text =
                                        "${training?.startDate} - ${training?.endDate}" ?? '';
                                    selectedDateRange = DateTimeRange(
                                        start: DateTime.parse(training?.startDate ?? ''),
                                        end: DateTime.parse(training?.endDate ?? ''));
                                    showAddOrUpdateModal(context, true, training?.id);
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: InkWell(
                                  child: const Icon(Icons.delete, color: colorRed),
                                  onTap: () async {
                                    deleteExperience(context, training?.id);
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
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: TextButton.icon(
          icon: const Icon(Icons.add),
          label: Text(terms?.addNewTraining ?? "Add Training"),
          onPressed: () {
            showAddOrUpdateModal(context);
          },
        ),
      ),
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
                          ? terms?.editTraining ?? "Edit Training"
                          : terms?.addNewTraining ?? "Add New Training",
                      style: appTitleStyle),
                  SizedBox(height: 10.h),
                  TitledInputFilled(
                      controller: nameController,
                      validator: ValidatorClass().validateEmptyField,
                      title: terms?.trainingName ?? "Training Name",
                      hintText: terms?.trainingName ?? "enter training name"),
                  SizedBox(height: 8.h),
                  TitledInputFilled(
                      controller: instituteController,
                      validator: ValidatorClass().validateEmptyField,
                      title: terms?.institute ?? "Institute",
                      hintText: terms?.instituteName ?? "enter institute"),
                  SizedBox(height: 8.h),
                  TitledInputFilled(
                      controller: topicController,
                      validator: ValidatorClass().validateEmptyField,
                      title: terms?.topic ?? "Topic",
                      hintText: terms?.topic ?? "enter topic"),
                  SizedBox(height: 8.h),
                  TitledInputFilled(
                      controller: locationController,
                      validator: ValidatorClass().validateEmptyField,
                      title: terms?.address ?? "Address",
                      hintText: terms?.address ?? "enter address"),
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
                      isUpdating ?? false ? await updateTraining(id) : await addTraining();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> addTraining() async {
    if (formKey.currentState!.validate()) {
      UiHelper.loadingIndicator();
      final response = await Get.find<EditResumeController>().addNewTraining(
        name: nameController.text.trim(),
        topics: topicController.text.trim(),
        institute: instituteController.text.trim(),
        location: locationController.text.trim(),
        startDate: DateTimeUtils.formatDate(selectedDateRange!.start),
        endDate: DateTimeUtils.formatDate(selectedDateRange!.end),
      );
      Get.back();
      Get.back();
      if (response) {
        Get.find<ResumeDetailsController>().getResumeDetails();
        UiHelper.showSnackBar(text: "Added Successfully");
        nameController.clear();
        instituteController.clear();
        locationController.clear();
        topicController.clear();
        selectedDateRange = null;
      } else {
        UiHelper.showSnackBar(text: "Failed to add", error: true);
      }
    }
  }

  Future<void> updateTraining(id) async {
    if (formKey.currentState!.validate()) {
      UiHelper.loadingIndicator();
      final response = await Get.find<EditResumeController>().updateTraining(
        id: id,
        name: nameController.text.trim(),
        topics: topicController.text.trim(),
        institute: instituteController.text.trim(),
        location: locationController.text.trim(),
        startDate: DateTimeUtils.formatDate(selectedDateRange!.start),
        endDate: DateTimeUtils.formatDate(selectedDateRange!.end),
      );
      Get.back();
      Get.back();
      if (response) {
        Get.find<ResumeDetailsController>().getResumeDetails();
        UiHelper.showSnackBar(text: "Update Successfully");
        nameController.clear();
        instituteController.clear();
        locationController.clear();
        topicController.clear();
        selectedDateRange = null;
      } else {
        UiHelper.showSnackBar(text: "Update Failed", error: true);
      }
    }
  }

  Future<dynamic> deleteExperience(BuildContext context, id) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Are you sure to delete?", style: appTitleStyle),
          content: Row(
            children: [
              Expanded(child: CustomButton(text: terms?.no ?? "No", onTap: () => Get.back())),
              const SizedBox(width: 16),
              Expanded(
                child: CustomButton(
                  text: terms?.yes ?? "Yes",
                  onTap: () async {
                    UiHelper.loadingIndicator();
                    final response = await Get.find<EditResumeController>().deleteTraining(id: id);
                    Get.back();
                    Get.back();
                    if (response) {
                      Get.find<ResumeDetailsController>().getResumeDetails();
                      //controller.removeExp(exp?.id);
                      UiHelper.showSnackBar(text: "Deleted Successfully");
                    } else {
                      UiHelper.showSnackBar(text: "Something went wrong", error: true);
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
}
