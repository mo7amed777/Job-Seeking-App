import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:eservices/controllers/edit_resume_controller.dart';
import 'package:eservices/controllers/resume_details_controller.dart';
import 'package:eservices/utils/app_colors.dart';
import 'package:eservices/utils/date_time_utils.dart';
import 'package:eservices/utils/image_paths.dart';
import 'package:eservices/utils/ui_helper.dart';
import 'package:eservices/utils/validator_class.dart';
import 'package:eservices/widgets/custom_drop_down.dart';
import 'package:eservices/widgets/titled_input_field.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/local_text_controller.dart';
import '../../models/app_text_model.dart';
import '../../models/resume_model.dart';
import '../../widgets/custom_button.dart';

class EditPersonalDetails extends StatefulWidget {
  const EditPersonalDetails({super.key});

  @override
  State<EditPersonalDetails> createState() => _EditPersonalDetailsState();
}

class _EditPersonalDetailsState extends State<EditPersonalDetails> {
  Terms? terms = LocalTextController.terms;
  Resume? resume = Get.find<ResumeDetailsController>().resume;
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController fathersNameController = TextEditingController();
  TextEditingController mothersNameController = TextEditingController();
  TextEditingController birthDayController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  DateTime? dateOfBirth;
  static List<String> genders = ['male', 'female'];
  String selectedGender = genders.first;
  static List<String> maritalStatuses = ['unmarried', 'married'];
  String maritalStatus = maritalStatuses.first;
  @override
  void initState() {
    super.initState();
    nameController.text = resume?.name ?? '';
    emailController.text = resume?.email ?? '';
    phoneController.text = resume?.phone ?? '';
    fathersNameController.text = resume?.fatherName ?? '';
    mothersNameController.text = resume?.motherName ?? '';
    birthDayController.text = resume?.dateOfBirth ?? '';
    nationalityController.text = resume?.nationality ?? '';
    selectedGender = resume?.gender ?? 'male';
    maritalStatus = resume?.maritalStatus ?? 'unmarried';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                  height: 100.h,
                  width: 100.w,
                  child: Image.network(
                      Get.find<AuthController>().user?.profilePhoto ?? '',
                      fit: BoxFit.cover)),
              SizedBox(height: 8.h),
              TitledInputFilled(
                  controller: nameController,
                  validator: ValidatorClass().validateName,
                  title: terms?.name ?? "Name",
                  hintText: terms?.fullName ?? "Enter your name"),
              SizedBox(height: 8.h),
              TitledInputFilled(
                  controller: emailController,
                  validator: ValidatorClass().validateEmail,
                  title: terms?.email ?? "Email",
                  hintText: terms?.emailHintText ?? "Enter your email"),
              SizedBox(height: 8.h),
              TitledInputFilled(
                  controller: phoneController,
                  validator: ValidatorClass().validateEmptyField,
                  title: terms?.phone ?? "Phone",
                  hintText: terms?.phone ?? "Enter your phone"),
              SizedBox(height: 8.h),
              TitledInputFilled(
                  controller: fathersNameController,
                  validator: ValidatorClass().validateName,
                  title: terms?.fathersName ?? "Father's Name",
                  hintText: terms?.fathersName ?? "Father's Name"),
              SizedBox(height: 8.h),
              TitledInputFilled(
                  controller: mothersNameController,
                  validator: ValidatorClass().validateName,
                  title: terms?.mothersName ?? "Mother's Name",
                  hintText: terms?.mothersName ?? "Mother's Name"),
              SizedBox(height: 8.h),
              TitledInputFilled(
                controller: birthDayController,
                title: terms?.dateOfBirth ?? "Date of Birth",
                hintText: dateOfBirth == null
                    ? terms?.dateOfBirth ?? "Select Date of Birth"
                    : DateTimeUtils.formatDate(dateOfBirth!),
                suffixIcon: IconButton(
                    onPressed: () {
                      selectDateOfBirth();
                    },
                    icon: SvgPicture.asset(calender, color: colorBlackLight)),
              ),
              SizedBox(height: 8.h),
              CustomDropDown(
                  title: terms?.gender ?? "Gender",
                  value: selectedGender,
                  items: genders,
                  onChanged: (value) {
                    selectedGender = value!;
                    setState(() {});
                  }),
              SizedBox(height: 8.h),
              CustomDropDown(
                  title: terms?.maritalStatus ?? "Marital Status",
                  value: maritalStatus,
                  items: maritalStatuses,
                  onChanged: (value) {
                    maritalStatus = value!;
                    setState(() {});
                  }),
              SizedBox(height: 8.h),
              TitledInputFilled(
                  controller: nationalityController,
                  title: terms?.nationality ?? "Nationality",
                  hintText: terms?.nationality ?? "Bangladeshi"),
              // SizedBox(height: 8.h),
              // const TitledInputFilled(title: "Religion", hintText: "Islam"),
              // SizedBox(height: 8.h),
              // const TitledInputFilled(title: "Permanent Address", hintText: "3654/A, Technical Gate, USA"),
              // SizedBox(height: 8.h),
              // const TitledInputFilled(title: "Present Address", hintText: "3654/A, Technical Gate, USA"),
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
            final response = await Get.find<EditResumeController>()
                .editPersonalDetails(
                    name: nameController.text.trim(),
                    email: emailController.text.trim(),
                    phone: phoneController.text.trim(),
                    fathersName: fathersNameController.text.trim(),
                    mothersName: mothersNameController.text.trim(),
                    dateOfBirth: birthDayController.text.trim(),
                    gender: selectedGender,
                    maritalStatus: maritalStatus,
                    nationality: nationalityController.text.trim());
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

  // selectDateOfBirth() {
  //   DateTimeUtils.pickDate(context).then(
  //     (value) {
  //       if (value != null) {
  //         dateOfBirth = value;
  //         setState(() {});
  //       }
  //     },
  //   );
  // }

  selectDateOfBirth() {
    DateTimeUtils.pickDate(context).then(
      (value) {
        if (value != null) {
          dateOfBirth = value;
          // Update the TextEditingController with the selected date
          birthDayController.text = DateTimeUtils.formatDate(dateOfBirth!);
          setState(() {}); // Refresh the UI
        }
      },
    );
  }
}
