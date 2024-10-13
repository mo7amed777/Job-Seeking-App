import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eservices/controllers/reset_pass_controller.dart';
import 'package:eservices/screens/auth_screens/reset_password_screen.dart';
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

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Terms? terms = LocalTextController.terms;
    return BodyWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const AppBarBackButton(),
                  SizedBox(height: 60.h),
                  //SvgPicture.asset(appLogo, color: colorPrimary),
                  MyImage(
                      imageUrl:
                          LocalSettingsController.setting?.darkLogo ?? ''),
                  SizedBox(height: 20.h),
                  Text(terms?.forgotPassTitle ?? forgotPassTitle,
                      style: appTextStyle),
                  SizedBox(height: 20.h),
                  GetBuilder<ResetPasswordController>(builder: (controller) {
                    return InputFieldGreenNew(
                      controller: controller.emailController,
                      hintText: terms?.emailHintText ?? "Enter Email",
                      prefixIcon: sms,
                      serverErrorMessage: controller.validationErrors['email'],
                    );
                  }),
                  SizedBox(height: 10.h),
                ],
              ),
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
                visible: controller.sendOtpInProgress == false,
                replacement: const CenterProgressIndicator(),
                child: CustomButton(
                  onTap: () async {
                    final response = await controller.sendOtpToEmail();
                    if (response) {
                      Get.to(const ResetPasswordScreen());
                    }
                    // if (formKey.currentState!.validate()) {
                    //   final response = await controller.sendOtpToEmail();
                    //   if (response) {
                    //     UiHelper.showSnackBar(text: "Enter OTP and New Password");
                    //     Get.to(const ResetPasswordScreen());
                    //   } else {
                    //     UiHelper.showSnackBar(text: "Something went wrong", error: true);
                    //   }
                    // }
                  },
                  text: LocalTextController.text?.terms?.next ?? "Next",
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
