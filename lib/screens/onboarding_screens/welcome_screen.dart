import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job_nect/screens/auth_screens/login_screen.dart';
import 'package:job_nect/screens/auth_screens/signup_company_screen.dart';
import 'package:job_nect/screens/auth_screens/signup_user_screen.dart';
import 'package:job_nect/utils/app_text_styles.dart';
import 'package:job_nect/utils/image_paths.dart';
import 'package:job_nect/widgets/appbar_back_button.dart';
import 'package:job_nect/widgets/body_widget.dart';

import '../../controllers/local_text_controller.dart';
import '../../models/app_text_model.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  final String accType;
  const WelcomeScreen({super.key, required this.accType});

  @override
  Widget build(BuildContext context) {
    Terms? terms = LocalTextController.terms;
    Size mq = MediaQuery.sizeOf(context);
    return Scaffold(
      body: BodyWidget(
        deepColor: true,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const AppBarBackButton(color: colorWhite),
                const Spacer(),
                Image.asset(welcomeImage),
                //SizedBox(height: 60.h),
                SizedBox(height: MediaQuery.sizeOf(context).height / 10),
                Text(terms?.welcomeTitle ?? 'welcomeTitle',
                    style: largeTitleStyle),
                SizedBox(height: 8.h),
                Text(terms?.welcomeSub ?? 'welcomeSub',
                    style: appTextStyle, textAlign: TextAlign.center),
                SizedBox(height: 25.h),
                // TextButton(
                //   onPressed: () {},
                //   child: Text(terms?.continueGuest ?? "Continue with Guest"),
                // ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onTap: () => Get.to(const LoginScreen()),
                        text: terms?.login ?? "Login",
                        backgroundColor: colorPrimaryLight,
                        foregroundColor: colorPrimary,
                        surfaceTintColor: Colors.transparent,
                        shadowColor: const Color.fromARGB(0, 22, 10, 10),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomButton(
                        onTap: () => Get.to(accType == "Employee"
                            ? const SignupUserScreen()
                            : const SignupCompanyScreen()),
                        text: terms?.signUp ?? "Sign up",
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
