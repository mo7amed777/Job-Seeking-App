import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:eservices/controllers/signup_controller.dart';
import 'package:eservices/screens/auth_screens/login_screen.dart';
import 'package:eservices/utils/app_colors.dart';
import 'package:eservices/utils/app_text_styles.dart';
import 'package:eservices/utils/image_paths.dart';
import 'package:eservices/utils/strings.dart';
import 'package:eservices/utils/validator_class.dart';
import 'package:eservices/widgets/appbar_back_button.dart';
import 'package:eservices/widgets/body_widget.dart';
import 'package:eservices/widgets/center_progress_indicator.dart';

import '../../utils/ui_helper.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/input_field_green_new.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
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
              child: Column(
                children: [
                  const AppBarBackButton(),
                  SizedBox(height: 60.h),
                  SvgPicture.asset(appLogo, color: colorPrimary),
                  SizedBox(height: 10.h),
                  const Text(signupUserTitle, style: appTextStyle),
                  SizedBox(height: 16.h),
                  GetBuilder<SignupController>(builder: (controller) {
                    return InputFieldGreenNew(
                      controller: controller.otpController,
                      hintText: "Enter OTP",
                      prefixIcon: lock,
                      textInputType: TextInputType.number,
                      serverErrorMessage: controller.validationErrors['token'],
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
          GetBuilder<SignupController>(
            builder: (controller) {
              return Visibility(
                visible: controller.verifyOtpInProgress == false,
                replacement: const CenterProgressIndicator(),
                child: CustomButton(
                  onTap: () async {
                    final response = await controller.verifySignup();
                    if (response) {
                      // UiHelper.showSnackBar(
                      //     text: "Account created, please login");
                      Get.offAll(const LoginScreen());
                    }

                    // if (formKey.currentState!.validate()) {
                    //   final response = await controller.verifySignup();
                    //   if (response) {
                    //     UiHelper.showSnackBar(text: "Account created, please login");
                    //     Get.offAll(const LoginScreen());
                    //   } else {
                    //     UiHelper.showSnackBar(text: "Something went wrong", error: true);
                    //   }
                    // }
                  },
                  text: "Sign up",
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
