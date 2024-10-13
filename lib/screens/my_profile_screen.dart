import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:job_nect/controllers/app_text_controller.dart';
import 'package:job_nect/controllers/auth_controller.dart';
import 'package:job_nect/controllers/designation_controller.dart';
import 'package:job_nect/controllers/language_controller.dart';
import 'package:job_nect/controllers/update_image_controller.dart';
import 'package:job_nect/controllers/update_profile_controller.dart';
import 'package:job_nect/models/designation_model.dart';
import 'package:job_nect/models/languages_model.dart';
import 'package:job_nect/utils/app_colors.dart';
import 'package:job_nect/utils/date_time_utils.dart';
import 'package:job_nect/utils/image_paths.dart';
import 'package:job_nect/utils/strings.dart';
import 'package:job_nect/utils/ui_helper.dart';
import 'package:job_nect/widgets/center_progress_indicator.dart';
import 'package:job_nect/widgets/custom_button.dart';
import 'package:job_nect/widgets/input_field_white_new.dart';
import 'package:job_nect/widgets/text_back_button.dart';

import '../controllers/local_text_controller.dart';
import '../models/app_text_model.dart';
import '../models/user.dart';
import '../utils/app_text_styles.dart';
import '../widgets/bordered_container.dart';
import '../widgets/custom_drop_down.dart';
import '../widgets/my_network_image.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  User? user = Get.find<AuthController>().user;
  static List<String> genders = ['male', 'female'];
  String selectedGender = genders.first;
  DateTime? birthDate;

  List<Designation> designations =
      Get.find<DesignationController>().designations ?? [];

  Designation? selectedDesignation;

  Language? appLanguage;

  AppText? selectedLanguage = LocalTextController.text;

  @override
  void initState() {
    super.initState();
    Get.find<UpdateProfileController>().nameController.text =
        Get.find<AuthController>().user?.name ?? '';
    Get.find<UpdateProfileController>().emailController.text =
        Get.find<AuthController>().user?.email ?? '';
    Get.find<UpdateProfileController>().phoneController.text =
        Get.find<AuthController>().user?.phone ?? '';
    Get.find<UpdateProfileController>().birthdayController.text =
        Get.find<AuthController>().user?.dateOfBirth ?? '';
    selectedGender = Get.find<AuthController>().user?.gender ?? "male";
    //selectedDesignation = Get.find<AuthController>().user?.designation;

    Get.find<LanguageController>().getLanguages(); // Fetch languages here
  }

  @override
  Widget build(BuildContext context) {
    Terms? terms = LocalTextController.terms;

    return Scaffold(
      appBar: AppBar(
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          title: TextBackButton(text: terms?.myProfile ?? "My Profile")),
      body: GetBuilder<UpdateProfileController>(builder: (controller) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              profilePicture(),
              SizedBox(height: 20.h),
              changeLanguage(),
              SizedBox(height: 10.h),
              InputFieldWhiteNew(
                  controller: controller.nameController,
                  hintText: terms?.name ?? name,
                  prefixIconSvg: userIcon,
                  serverErrorMessage: controller.validationErrors['name']),

              SizedBox(height: 10.h),
              //InputFieldWhite(hintText: "Ui/Ux Designer", prefixIconSvg: graph),
              //(height: 10.h),
              InputFieldWhiteNew(
                  controller: controller.emailController,
                  hintText: terms?.email ?? email,
                  prefixIconSvg: sms,
                  serverErrorMessage: controller.validationErrors['email']),
              SizedBox(height: 10.h),
              InputFieldWhiteNew(
                  controller: controller.phoneController,
                  hintText: terms?.phone ?? phone,
                  prefixIconSvg: call,
                  serverErrorMessage: controller.validationErrors['phone']),
              SizedBox(height: 10.h),
              InputFieldWhiteNew(
                controller: controller.birthdayController,
                hintText: birthDate == null
                    ? terms?.dateOfBirth ?? dateOfBirth
                    : DateTimeUtils.formatDate(birthDate!),
                prefixIconSvg: calender,
                suffixIcon: IconButton(
                  onPressed: () {
                    DateTimeUtils.pickDate(context).then((value) {
                      if (value != null) {
                        birthDate = value;
                        controller.birthdayController.text =
                            DateTimeUtils.formatDate(value);
                        controller
                            .updateBirthDay(DateTimeUtils.formatDate(value));
                        setState(() {});
                      }
                    });
                  },
                  icon: SvgPicture.asset(calender, color: colorBlackLight),
                ),
              ),
              SizedBox(height: 10.h),
              //InputFieldWhite(hintText: "Male", prefixIconSvg: gender),
              // MyDropDown(
              //     haveTitle: false,
              //     havePrefix: true,
              //     prefixIconSvg: graph,
              //     items: designations.map((Designation designation) {
              //       return DropdownMenuItem<Designation>(
              //         value: designation,
              //         child: Text(designation.name ?? ''),
              //       );
              //     }).toList(),
              //     onChanged: (value) {
              //       selectedDesignation = value;
              //       setState(() {});
              //     },
              //     value: selectedDesignation),
              BorderedContainer(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    SvgPicture.asset(graph),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          icon: const Icon(Icons.keyboard_arrow_down_sharp),
                          hint: Text(
                              user?.designation?.name ?? "Select Designation"),
                          style: appTextStyleBlack,
                          isExpanded: true,
                          value: selectedDesignation,
                          items: designations.map((Designation designation) {
                            return DropdownMenuItem<Designation>(
                              value: designation,
                              child: Text(designation.name ?? ''),
                            );
                          }).toList(),
                          onChanged: (Designation? designation) {
                            selectedDesignation = designation;
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              //InputFieldWhite(hintText: "Male", prefixIconSvg: gender),
              CustomDropDown(
                  haveTitle: false,
                  havePrefix: true,
                  prefixIconSvg: userIcon,
                  hint: user?.gender,
                  value: selectedGender,
                  items: genders,
                  onChanged: (value) {
                    selectedGender = value!;
                    setState(() {});
                  }),
            ],
          ),
        );
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GetBuilder<UpdateProfileController>(builder: (controller) {
              return Visibility(
                visible: controller.loading == false,
                replacement: const CenterProgressIndicator(),
                child: CustomButton(
                  text: terms?.saveAndUpdate ?? "Save & Update",
                  onTap: () async {
                    await controller.updateProfile(
                        designationId: selectedDesignation?.id,
                        gender: selectedGender);
                    // if (response) {
                    //   UiHelper.showSnackBar(text: "Profile update successful");
                    // } else {
                    //   UiHelper.showSnackBar(
                    //       text: "Profile update failed", error: true);
                    // }
                    // if (selectedDesignation == null) {
                    //   return UiHelper.showSnackBar(
                    //       text: "select designation", error: true);
                    // }
                    // final response = await controller.updateProfile(
                    //     designationId: selectedDesignation?.id,
                    //     gender: selectedGender);
                    // if (response) {
                    //   UiHelper.showSnackBar(text: "Profile update successful");
                    // } else {
                    //   UiHelper.showSnackBar(
                    //       text: "Profile update failed", error: true);
                    // }
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  GetBuilder<LanguageController> changeLanguage() {
    return GetBuilder<LanguageController>(builder: (langController) {
      return GetBuilder<AppTextController>(builder: (textController) {
        return BorderedContainer(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              SvgPicture.asset(
                locationIcon,
                colorFilter: const ColorFilter.mode(
                  colorPrimary, // Change to your desired color
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Language>(
                    icon: const Icon(Icons.keyboard_arrow_down_sharp),
                    hint: Text(
                        selectedLanguage?.languageName ?? 'Select Language'),
                    style: appTextStyleBlack,
                    isExpanded: true,
                    value: appLanguage,
                    items: langController.languages
                        .map(
                          (item) => DropdownMenuItem(
                            value: item,
                            child: Text(
                              item.name ?? '',
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) async {
                      appLanguage = value;
                      await textController.getAppTexts(appLanguage?.code);
                      setState(() {});
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      });
    });
  }

  Widget profilePicture() {
    return GetBuilder<UpdateImageController>(builder: (controller) {
      return Stack(
        children: [
          Container(
            height: 90.h,
            width: 90.w,
            clipBehavior: Clip.antiAlias,
            //padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorWhite,
                border: Border.all(color: colorPrimaryLight)),
            child: controller.profileImage != null
                ? Image.file(controller.profileImage!, fit: BoxFit.cover)
                : MyNetworkImage(
                    imageUrl: user?.profilePhoto ?? '', fit: BoxFit.cover),
          ),
          Positioned(
            bottom: -5,
            right: -5,
            child: IconButton.filled(
              constraints: BoxConstraints(maxHeight: 30.h, maxWidth: 30.w),
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.edit_note),
              onPressed: () async {
                await controller.pickProfileImage();
              },
            ),
          ),
        ],
      );
    });
  }
}
