import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_nect/controllers/local_settings_controller.dart';
import 'package:job_nect/utils/app_text_styles.dart';
import 'package:job_nect/utils/image_paths.dart';
import 'package:job_nect/utils/strings.dart';
import 'package:job_nect/widgets/appbar_back_button.dart';
import 'package:job_nect/widgets/body_widget.dart';
import 'package:job_nect/widgets/my_network_image.dart';

import '../../controllers/local_text_controller.dart';
import '../../models/app_text_model.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/input_field_green.dart';

class SignupCompanyScreen extends StatelessWidget {
  const SignupCompanyScreen({super.key});

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
            child: Column(
              children: [
                const AppBarBackButton(),
                SizedBox(height: 50.h),
                // SvgPicture.asset(appLogo, color: colorPrimary),
                MyNetworkImage(imageUrl: LocalSettingsController.setting?.darkLogo ?? ''),
                SizedBox(height: 20.h),
                Text(terms?.signupCompanyTitle ?? signupCompanyTitle,
                    style: appTextStyle, textAlign: TextAlign.center),
                SizedBox(height: 16.h),
                InputFieldGreen(
                  hintText: terms?.fullName ?? "Full Name",
                  prefixIcon: userIcon,
                ),
                SizedBox(height: 10.h),
                InputFieldGreen(
                  hintText: terms?.email ?? "Email",
                  prefixIcon: sms,
                ),
                SizedBox(height: 10.h),
                InputFieldGreen(
                  hintText: terms?.phone ?? "Phone",
                  prefixIcon: call,
                ),
                SizedBox(height: 10.h),
                InputFieldGreen(
                  hintText: terms?.companyName ?? "Company Name",
                  prefixIcon: userIcon,
                ),
                SizedBox(height: 10.h),
                InputFieldGreen(
                  hintText: terms?.password ?? "Password",
                  prefixIcon: lock,
                  isObscure: true,
                ),
                SizedBox(height: 10.h),
                InputFieldGreen(
                  hintText: terms?.confirmPassword ?? "Confirm Password",
                  prefixIcon: lock,
                  isObscure: true,
                ),
              ],
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
        children: [
          TextButton.icon(
              onPressed: () {},
              icon: Image.asset(googleIcon, height: 18.h),
              label: Text(terms?.signupWithGoogle ?? "Sign up with Google")),
          SizedBox(height: 6.h),
          CustomButton(
            onTap: () {
              //Get.to(const BottomNavScreen());
            },
            text: terms?.signUp ?? "Sign up",
          ),
        ],
      ),
    );
  }
}
