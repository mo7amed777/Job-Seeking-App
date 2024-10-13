import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eservices/controllers/reset_pass_controller.dart';
import 'package:eservices/screens/auth_screens/login_screen.dart';
import 'package:eservices/utils/app_text_styles.dart';
import 'package:eservices/utils/image_paths.dart';
import 'package:eservices/utils/strings.dart';
import 'package:eservices/utils/validator_class.dart';
import 'package:eservices/widgets/appbar_back_button.dart';
import 'package:eservices/widgets/body_widget.dart';
import 'package:eservices/widgets/center_progress_indicator.dart';

import '../../controllers/local_settings_controller.dart';
import '../../controllers/local_text_controller.dart';
import '../../models/app_text_model.dart';
import '../../utils/ui_helper.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/input_field_green_new.dart';
import '../../widgets/my_network_image.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  Terms? terms = LocalTextController.terms;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BodyWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
            child: Form(
              key: formKey,
              child: GetBuilder<ResetPasswordController>(builder: (controller) {
                return Column(
                  children: [
                    const AppBarBackButton(),
                    SizedBox(height: 60.h),
                    // SvgPicture.asset(appLogo, color: colorPrimary),
                    MyImage(
                        imageUrl:
                            LocalSettingsController.setting?.darkLogo ?? ''),
                    SizedBox(height: 20.h),
                    Text(terms?.resetPassTitle ?? resetPassTitle,
                        style: appTextStyle),
                    SizedBox(height: 20.h),
                    InputFieldGreenNew(
                      controller: controller.otpController,
                      hintText: "Enter OTP",
                      prefixIcon: lockDot,
                      textInputType: TextInputType.number,
                      serverErrorMessage: controller.validationErrors['token'],
                    ),
                    SizedBox(height: 10.h),
                    InputFieldGreenNew(
                      controller: controller.passwordController,
                      hintText: terms?.newPassword ?? "New Password",
                      prefixIcon: lock,
                      isObscure: true,
                      serverErrorMessage:
                          controller.validationErrors['new_password'],
                    ),
                    SizedBox(height: 10.h),
                    InputFieldGreenNew(
                      controller: controller.cPasswordController,
                      hintText:
                          terms?.confirmNewPassword ?? "Confirm New Password",
                      prefixIcon: lock,
                      isObscure: true,
                      serverErrorMessage:
                          controller.validationErrors['confirm_password'],
                    ),
                    SizedBox(height: 10.h),
                  ],
                );
              }),
            ),
          ),
        ),
        bottomNavigationBar: bottomNavigationBar(),
      ),
    );
  }

  Widget bottomNavigationBar() {
    return Padding(
      padding: const EdgeInsets.all(16).copyWith(top: 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GetBuilder<ResetPasswordController>(
            builder: (controller) {
              return Visibility(
                visible: controller.resetPassInProgress == false,
                replacement: const CenterProgressIndicator(),
                child: CustomButton(
                  onTap: () async {
                    final response = await controller.resetPassword();
                    if (response) {
                      Get.offAll(const LoginScreen());
                    }
                    // if (formKey.currentState!.validate()) {
                    //   final response = await controller.resetPassword();
                    //   if (response) {
                    //     UiHelper.showSnackBar(text: "Password Reset Successful");
                    //     Get.offAll(const LoginScreen());
                    //   } else {
                    //     UiHelper.showSnackBar(text: "Something went wrong", error: true);
                    //   }
                    // }
                  },
                  text: terms?.verify ?? "Verify",
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
