import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eservices/controllers/resume_details_controller.dart';
import 'package:eservices/models/resume_model.dart';

import '../../controllers/edit_resume_controller.dart';
import '../../controllers/local_text_controller.dart';
import '../../models/app_text_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../utils/ui_helper.dart';
import '../../utils/validator_class.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/bullet_text_titled.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_drop_down.dart';
import '../../widgets/titled_input_field.dart';

class EditLanguage extends StatefulWidget {
  const EditLanguage({super.key});

  @override
  State<EditLanguage> createState() => _EditLanguageState();
}

class _EditLanguageState extends State<EditLanguage> {
  Terms? terms = LocalTextController.terms;
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  static List<String> languageLevels = ["intermediate", "advanced", "fluent"];
  //static List<String> languages = ["Bengali", "English", "Hindi"];
  //String language = languages.first;
  String readingValue = languageLevels.first;
  String writingValue = languageLevels.first;
  String speakingValue = languageLevels.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GetBuilder<ResumeDetailsController>(
              builder: (controller) {
                Resume? resume = controller.resume;
                return BorderedContainer(
                  title: terms?.language ?? "Language",
                  body: Column(
                    children: [
                      ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: resume?.resumeLanguages?.length ?? 0,
                        itemBuilder: (context, index) {
                          final lang = resume?.resumeLanguages?[index];
                          return BulletTextTitled(
                            title: lang?.name ?? "",
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "${terms?.reading ?? "Reading"}: ${lang?.reading}",
                                    style: appTextStyleBlack),
                                Text(
                                    "${terms?.writing ?? "Writing"}: ${lang?.writing}",
                                    style: appTextStyleBlack),
                                Text(
                                    "${terms?.speaking ?? "Speaking"}: ${lang?.speaking}",
                                    style: appTextStyleBlack),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: InkWell(
                                        child: const Icon(Icons.edit,
                                            color: colorPrimary),
                                        onTap: () {
                                          nameController.text =
                                              lang?.name ?? '';
                                          readingValue = lang?.reading ?? '';
                                          writingValue = lang?.writing ?? '';
                                          speakingValue = lang?.speaking ?? '';
                                          showAddOrUpdateModal(
                                              context, true, lang?.id);
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: InkWell(
                                        child: const Icon(Icons.delete,
                                            color: colorRed),
                                        onTap: () async {
                                          deleteLanguage(context, lang?.id);
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
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: TextButton.icon(
          icon: const Icon(Icons.add),
          label: Text(terms?.addNewLanguage ?? "Add Language"),
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
          child: StatefulBuilder(builder: (context, setState) {
            return SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Text(
                        isUpdating ?? false
                            ? terms?.editLanguage ?? "Edit Language"
                            : terms?.addNewLanguage ?? "Add New Language",
                        style: appTitleStyle),
                    SizedBox(height: 10.h),
                    TitledInputFilled(
                        controller: nameController,
                        validator: ValidatorClass().validateEmptyField,
                        title: terms?.languageName ?? "Language Name",
                        hintText: terms?.languageName ?? "enter language name"),
                    SizedBox(height: 8.h),
                    CustomDropDown(
                      title: terms?.reading ?? "Reading",
                      value: readingValue,
                      items: languageLevels,
                      onChanged: (String? value) {
                        readingValue = value!;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 8.h),
                    CustomDropDown(
                      title: terms?.writing ?? "Writing",
                      value: writingValue,
                      items: languageLevels,
                      onChanged: (String? value) {
                        writingValue = value!;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 8.h),
                    CustomDropDown(
                      title: terms?.speaking ?? "Speaking",
                      value: speakingValue,
                      items: languageLevels,
                      onChanged: (String? value) {
                        speakingValue = value!;
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 20),
                    // if (index < (resume?.experiences?.length ?? 0) - 1) const Divider(),
                    // const SizedBox(height: 20),
                    CustomButton(
                      text: terms?.saveAndContinue ?? "Save & Continue",
                      onTap: () async {
                        isUpdating ?? false
                            ? await updateLanguage(id)
                            : await addLanguage();
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Future<void> addLanguage() async {
    if (formKey.currentState!.validate()) {
      UiHelper.loadingIndicator();
      final response = await Get.find<EditResumeController>().addNewLanguage(
        name: nameController.text.trim(),
        reading: readingValue,
        writing: writingValue,
        speaking: speakingValue,
      );
      Get.back();
      Get.back();
      if (response) {
        Get.find<ResumeDetailsController>().getResumeDetails();
        UiHelper.showSnackBar(text: "Added Successfully");
        nameController.clear();
      } else {
        UiHelper.showSnackBar(text: "Failed to add", error: true);
      }
    }
  }

  Future<void> updateLanguage(id) async {
    if (formKey.currentState!.validate()) {
      UiHelper.loadingIndicator();
      final response = await Get.find<EditResumeController>().updateLanguage(
        id: id,
        name: nameController.text.trim(),
        reading: readingValue,
        writing: writingValue,
        speaking: speakingValue,
      );
      Get.back();
      Get.back();
      if (response) {
        Get.find<ResumeDetailsController>().getResumeDetails();
        UiHelper.showSnackBar(text: "Update Successfully");
        nameController.clear();
      } else {
        UiHelper.showSnackBar(text: "Update Failed", error: true);
      }
    }
  }

  Future<dynamic> deleteLanguage(BuildContext context, id) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Are you sure to delete?", style: appTitleStyle),
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
                        .deleteLanguage(id: id);
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
}
//BorderedContainer(
//   padding: const EdgeInsets.symmetric(horizontal: 16),
//   child: DropdownButtonHideUnderline(
//     child: DropdownButton(
//       isExpanded: true,
//       value: readingValue,
//       items: List.generate(
//           valueList.length,
//           (index) => DropdownMenuItem(
//                 value: valueList[index],
//                 child: Text(valueList[index]),
//               )),
//       onChanged: (value) {
//         readingValue = value!;
//         setState(() {});
//       },
//     ),
//   ),
// ),
