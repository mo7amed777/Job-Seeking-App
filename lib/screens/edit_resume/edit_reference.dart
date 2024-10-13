import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/edit_resume_controller.dart';
import '../../controllers/local_text_controller.dart';
import '../../controllers/resume_details_controller.dart';
import '../../models/app_text_model.dart';
import '../../models/resume_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../utils/ui_helper.dart';
import '../../utils/validator_class.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/titled_input_field.dart';

class Reference extends StatefulWidget {
  const Reference({super.key});

  @override
  State<Reference> createState() => _ReferenceState();
}

class _ReferenceState extends State<Reference> {
  Terms? terms = LocalTextController.terms;
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController relationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ResumeDetailsController>(builder: (controller) {
        Resume? resume = controller.resume;
        return SingleChildScrollView(
          child: BorderedContainer(
            title: terms?.trainingSummary ?? "Training Summary",
            body: Column(
              children: [
                ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: resume?.references?.length ?? 0,
                  itemBuilder: (context, index) {
                    final reference = resume?.references?[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        colonText(key: terms?.name ?? "Name", value: reference?.name ?? ""),
                        colonText(
                            key: terms?.organization ?? "Organization", value: reference?.organization ?? ""),
                        colonText(
                            key: terms?.designation ?? "Designation", value: reference?.designation ?? ""),
                        colonText(key: terms?.address ?? "Address", value: reference?.address ?? ""),
                        colonText(key: terms?.phone ?? "Phone", value: reference?.phone ?? ""),
                        colonText(key: terms?.email ?? "Email", value: reference?.email ?? ""),
                        colonText(key: terms?.relation ?? "Relation", value: reference?.relation ?? ""),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: InkWell(
                                child: const Icon(Icons.edit, color: colorPrimary),
                                onTap: () {
                                  nameController.text = reference?.name ?? '';
                                  organizationController.text = reference?.organization ?? '';
                                  designationController.text = reference?.designation ?? '';
                                  addressController.text = reference?.address ?? '';
                                  phoneController.text = reference?.phone ?? '';
                                  emailController.text = reference?.email ?? '';
                                  relationController.text = reference?.relation ?? '';
                                  showAddOrUpdateModal(context, true, reference?.id);
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: InkWell(
                                child: const Icon(Icons.delete, color: colorRed),
                                onTap: () async {
                                  deleteReference(context, reference?.id);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }),
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
                          ? terms?.editReference ?? "Edit Reference"
                          : terms?.addNewReference ?? "Add New Reference",
                      style: appTitleStyle),
                  SizedBox(height: 10.h),
                  TitledInputFilled(
                      controller: nameController,
                      validator: ValidatorClass().validateEmptyField,
                      title: terms?.name ?? "Name",
                      hintText: terms?.fullName ?? "enter name"),
                  SizedBox(height: 8.h),
                  TitledInputFilled(
                      controller: organizationController,
                      validator: ValidatorClass().validateEmptyField,
                      title: terms?.organization ?? "Organization",
                      hintText: terms?.organizationName ?? "enter organization"),
                  SizedBox(height: 8.h),
                  TitledInputFilled(
                      controller: designationController,
                      validator: ValidatorClass().validateEmptyField,
                      title: terms?.designation ?? "Designation",
                      hintText: terms?.designation ?? "enter designation"),
                  SizedBox(height: 8.h),
                  TitledInputFilled(
                      controller: addressController,
                      validator: ValidatorClass().validateEmptyField,
                      title: terms?.address ?? "Address",
                      hintText: terms?.address ?? "enter address"),
                  SizedBox(height: 8.h),
                  TitledInputFilled(
                    controller: phoneController,
                    validator: ValidatorClass().validateEmptyField,
                    title: terms?.phone ?? "Phone",
                    hintText: terms?.phone ?? "enter phone",
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 8.h),
                  TitledInputFilled(
                    controller: emailController,
                    validator: ValidatorClass().validateEmptyField,
                    title: terms?.email ?? "Email",
                    hintText: terms?.emailHintText ?? "enter email",
                  ),
                  SizedBox(height: 8.h),
                  TitledInputFilled(
                    controller: relationController,
                    validator: ValidatorClass().validateEmptyField,
                    title: terms?.relation ?? "Relation",
                    hintText: terms?.relation ?? "enter relation",
                  ),
                  const SizedBox(height: 20),
                  // if (index < (resume?.experiences?.length ?? 0) - 1) const Divider(),
                  // const SizedBox(height: 20),
                  CustomButton(
                    text: "Save & Continue",
                    onTap: () async {
                      isUpdating ?? false ? await updateReference(id) : await addReference();
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

  Future<void> addReference() async {
    if (formKey.currentState!.validate()) {
      UiHelper.loadingIndicator();
      final response = await Get.find<EditResumeController>().addNewReference(
        name: nameController.text.trim(),
        designation: designationController.text.trim(),
        organization: organizationController.text.trim(),
        address: addressController.text.trim(),
        phone: phoneController.text.trim(),
        email: emailController.text.trim(),
        relation: relationController.text.trim(),
      );
      Get.back();
      Get.back();
      if (response) {
        Get.find<ResumeDetailsController>().getResumeDetails();
        UiHelper.showSnackBar(text: "Added Successfully");
        nameController.clear();
        organizationController.clear();
        addressController.clear();
        designationController.clear();
        phoneController.clear();
        emailController.clear();
        relationController.clear();
      } else {
        UiHelper.showSnackBar(text: "Failed to add", error: true);
      }
    }
  }

  Future<void> updateReference(id) async {
    if (formKey.currentState!.validate()) {
      UiHelper.loadingIndicator();
      final response = await Get.find<EditResumeController>().updateReference(
        id: id,
        name: nameController.text.trim(),
        designation: designationController.text.trim(),
        organization: organizationController.text.trim(),
        address: addressController.text.trim(),
        phone: phoneController.text.trim(),
        email: emailController.text.trim(),
        relation: relationController.text.trim(),
      );
      Get.back();
      Get.back();
      if (response) {
        Get.find<ResumeDetailsController>().getResumeDetails();
        UiHelper.showSnackBar(text: "Update Successfully");
        nameController.clear();
        organizationController.clear();
        addressController.clear();
        designationController.clear();
        phoneController.clear();
        emailController.clear();
        relationController.clear();
      } else {
        UiHelper.showSnackBar(text: "Update Failed", error: true);
      }
    }
  }

  Future<dynamic> deleteReference(BuildContext context, id) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Are you sure to delete?", style: appTitleStyle),
          content: Row(
            children: [
              Expanded(child: CustomButton(text: "Cancel", onTap: () => Get.back())),
              const SizedBox(width: 16),
              Expanded(
                child: CustomButton(
                  text: "Ok",
                  onTap: () async {
                    UiHelper.loadingIndicator();
                    final response = await Get.find<EditResumeController>().deleteReference(id: id);
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

  Widget colonText({required key, required value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Text(key, style: appTextStyleBlack)),
        Text(" :  ", style: appTextStyleBlack.copyWith(fontWeight: FontWeight.bold)),
        Expanded(child: Text(value, style: appTextStyleBlack)),
      ],
    );
  }
}
