import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job_nect/utils/validator_class.dart';
import 'package:job_nect/widgets/titled_input_field.dart';

import '../../controllers/edit_resume_controller.dart';
import '../../controllers/local_text_controller.dart';
import '../../controllers/resume_details_controller.dart';
import '../../models/app_text_model.dart';
import '../../models/resume_model.dart';
import '../../utils/ui_helper.dart';
import '../../widgets/custom_button.dart';

class EditAddress extends StatefulWidget {
  const EditAddress({super.key});

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  Terms? terms = LocalTextController.terms;
  Resume? resume = Get.find<ResumeDetailsController>().resume;
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController presentAddController = TextEditingController();
  TextEditingController permanentAddController = TextEditingController();
  @override
  void initState() {
    super.initState();
    presentAddController.text = resume?.presentAddress ?? '';
    permanentAddController.text = resume?.permanentAddress ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              // const TitledInputFilled(title: "Name", hintText: "Alexa Demain"),
              // SizedBox(height: 8.h),
              // const TitledInputFilled(title: "Email", hintText: "alexa@gmail.com"),
              // SizedBox(height: 8.h),
              TitledInputFilled(
                controller: presentAddController,
                validator: ValidatorClass().validateEmptyField,
                title: terms?.presentAddress ?? "Present Address",
                hintText: terms?.presentAddress ?? "Enter address here",
                maxLine: 5,
              ),
              SizedBox(height: 8.h),
              TitledInputFilled(
                controller: permanentAddController,
                validator: ValidatorClass().validateEmptyField,
                title: terms?.permanentAddress ?? "Permanent Address",
                hintText: terms?.permanentAddress ?? "Enter address here",
                maxLine: 5,
              ),
              const SizedBox(height: 20),
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
            final response = await Get.find<EditResumeController>().editAddressDetails(
              presentAddress: presentAddController.text.trim(),
              permanentAddress: permanentAddController.text.trim(),
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
