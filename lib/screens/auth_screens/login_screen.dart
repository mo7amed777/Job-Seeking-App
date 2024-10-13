import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eservices/controllers/local_text_controller.dart';
import 'package:eservices/controllers/login_controller.dart';
import 'package:eservices/models/app_text_model.dart';
import 'package:eservices/screens/auth_screens/forgot_password_screen.dart';
import 'package:eservices/screens/bottom_nav_screen.dart';
import 'package:eservices/utils/app_colors.dart';
import 'package:eservices/utils/app_text_styles.dart';
import 'package:eservices/utils/image_paths.dart';
import 'package:eservices/utils/ui_helper.dart';
import 'package:eservices/utils/validator_class.dart';
import 'package:eservices/widgets/appbar_back_button.dart';
import 'package:eservices/widgets/body_widget.dart';
import 'package:eservices/widgets/center_progress_indicator.dart';
import 'package:eservices/widgets/input_field_green_new.dart';

import '../../controllers/local_settings_controller.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/my_network_image.dart';
import 'package:eservices/screens/auth_screens/signup_user_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Terms? terms = LocalTextController.terms;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BodyWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
            child: Form(
              key: formKey,
              child: GetBuilder<LoginController>(builder: (controller) {
                print(LocalSettingsController.setting?.lightLogo);
                return Column(
                  children: [
                    const AppBarBackButton(),
                    SizedBox(height: 60.h),
                    // SvgPicture.asset(appLogo, color: colorPrimary),
                    MyImage(
                        imageUrl:
                            LocalSettingsController.setting?.darkLogo ?? ''),
                    SizedBox(height: 20.h),
                    Text(terms?.loginTitle ?? 'loginTitle',
                        style: appTextStyle, textAlign: TextAlign.center),
                    SizedBox(height: 16.h),
                    InputFieldGreenNew(
                      controller: controller.emailController,
                      hintText: terms?.emailHintText ?? "Enter Your Email",
                      prefixIcon: sms,
                      serverErrorMessage: controller.validationErrors['email'],
                    ),
                    SizedBox(height: 10.h),
                    InputFieldGreenNew(
                      controller: controller.passwordController,
                      hintText:
                          terms?.passwordHintText ?? "Enter Your Password",
                      prefixIcon: lock,
                      isObscure: true,
                      serverErrorMessage:
                          controller.validationErrors['password'],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        style: TextButton.styleFrom(foregroundColor: colorRed),
                        onPressed: () => Get.to(const ForgotPasswordScreen()),
                        child: Text(terms?.forgotPassword ?? ""),
                      ),
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
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // TextButton.icon(
          //     onPressed: () {},
          //     icon: Image.asset(googleIcon, height: 18.h),
          //     label: Text(terms?.loginWithGoogle ?? "Login with Google")),
          TextButton.icon(
              onPressed: () {
                Get.to(const SignupUserScreen());
              },
              label: Text("Go to ${terms?.signUp ?? 'Sign up'}")),
          SizedBox(height: 6.h),
          GetBuilder<LoginController>(builder: (controller) {
            return Visibility(
              visible: controller.loginInProgress == false,
              replacement: const CenterProgressIndicator(),
              child: CustomButton(
                onTap: () async {
                  //Get.to(const BottomNavScreen());
                  final response = await controller.login();
                  if (response) {
                    // UiHelper.showSnackBar(text: "Login Success");
                    Get.offAll(const BottomNavScreen());
                  }
                  // if (formKey.currentState!.validate()) {
                  //   final response = await controller.login();
                  //   if (response) {
                  //     UiHelper.showSnackBar(text: "Login Success");
                  //     Get.offAll(const BottomNavScreen());
                  //   } else {
                  //     UiHelper.showSnackBar(
                  //         text: controller.errorMessage, error: true);
                  //   }
                  // }
                },
                text: terms?.login ?? "Login",
              ),
            );
          }),
        ],
      ),
    );
  }
}
