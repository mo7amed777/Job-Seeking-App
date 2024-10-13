import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eservices/controllers/signup_controller.dart';
import 'package:eservices/screens/auth_screens/verify_otp_screen.dart';
import 'package:eservices/utils/app_text_styles.dart';
import 'package:eservices/utils/image_paths.dart';
import 'package:eservices/utils/strings.dart';
import 'package:eservices/utils/ui_helper.dart';
import 'package:eservices/utils/validator_class.dart';
import 'package:eservices/widgets/appbar_back_button.dart';
import 'package:eservices/widgets/body_widget.dart';
import 'package:eservices/widgets/center_progress_indicator.dart';

import '../../controllers/local_settings_controller.dart';
import '../../controllers/local_text_controller.dart';
import '../../models/app_text_model.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/input_field_green_new.dart';
import '../../widgets/my_network_image.dart';
import 'package:eservices/screens/auth_screens/login_screen.dart';

class SignupUserScreen extends StatefulWidget {
  const SignupUserScreen({super.key});

  @override
  State<SignupUserScreen> createState() => _SignupUserScreenState();
}

class _SignupUserScreenState extends State<SignupUserScreen> {
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
              child: GetBuilder<SignupController>(builder: (controller) {
                return Column(
                  children: [
                    const AppBarBackButton(),
                    SizedBox(height: 50.h),
                    MyImage(
                        imageUrl:
                            LocalSettingsController.setting?.darkLogo ?? ''),
                    SizedBox(height: 20.h),
                    Text(terms?.signupUserTitle ?? signupUserTitle,
                        style: appTextStyle, textAlign: TextAlign.center),
                    SizedBox(height: 16.h),
                    InputFieldGreenNew(
                      controller: controller.nameController,
                      hintText: terms?.fullName ?? "Full Name",
                      prefixIcon: userIcon,
                      serverErrorMessage: controller.validationErrors['name'],
                    ),
                    SizedBox(height: 10.h),
                    InputFieldGreenNew(
                      controller: controller.emailController,
                      hintText: terms?.email ?? "Email",
                      prefixIcon: sms,
                      serverErrorMessage: controller.validationErrors['email'],
                    ),
                    SizedBox(height: 10.h),
                    InputFieldGreenNew(
                      controller: controller.phoneController,
                      hintText: terms?.phone ?? "Phone",
                      prefixIcon: call,
                      serverErrorMessage: controller.validationErrors['phone'],
                    ),
                    SizedBox(height: 10.h),
                    InputFieldGreenNew(
                      controller: controller.passwordController,
                      hintText: terms?.password ?? "Password",
                      prefixIcon: lock,
                      isObscure: true,
                      serverErrorMessage:
                          controller.validationErrors['password'],
                    ),
                    SizedBox(height: 10.h),
                    InputFieldGreenNew(
                      controller: controller.cPasswordController,
                      hintText: terms?.confirmPassword ?? "Confirm Password",
                      prefixIcon: lock,
                      isObscure: true,
                      serverErrorMessage:
                          controller.validationErrors['password_confirmation'],
                    ),
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
    Terms? terms = LocalTextController.terms;
    return Padding(
      padding: const EdgeInsets.all(16).copyWith(top: 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton.icon(
            onPressed: () {
              Get.to(const LoginScreen());
            },
            label: Text("Go to ${terms?.login ?? "Login"}"),
          ),
          SizedBox(height: 6.h),
          GetBuilder<SignupController>(builder: (controller) {
            return Visibility(
              visible: !controller.signupInProgress,
              replacement: const CenterProgressIndicator(),
              child: CustomButton(
                onTap: () async {
                  final response = await controller.signup();
                  if (response) {
                    // UiHelper.showSnackBar(
                    //     text:
                    //         "OTP sent to ${controller.emailController.text.trim()}");
                    Get.to(const VerifyOtpScreen());
                  }
                  // if (formKey.currentState!.validate()) {
                  //   if (controller.passwordController.text !=
                  //       controller.cPasswordController.text) {
                  //     UiHelper.showSnackBar(
                  //         text: "Password do not match", error: true);
                  //     return;
                  //   }
                  //   final response = await controller.signup();
                  //   if (response) {
                  //     UiHelper.showSnackBar(
                  //         text:
                  //             "OTP sent to ${controller.emailController.text.trim()}");
                  //     Get.to(const VerifyOtpScreen());
                  //   } else {
                  //     UiHelper.showSnackBar(
                  //         text: "Something went wrong", error: true);
                  //   }
                  // }
                },
                text: terms?.signUp ?? "Sign up",
              ),
            );
          }),
        ],
      ),
    );
  }
}
