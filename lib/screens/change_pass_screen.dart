import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_nect/utils/app_text_styles.dart';
import 'package:job_nect/utils/image_paths.dart';
import 'package:job_nect/widgets/custom_button.dart';
import 'package:job_nect/widgets/input_field_white.dart';
import 'package:job_nect/widgets/text_back_button.dart';

import '../controllers/local_text_controller.dart';
import '../models/app_text_model.dart';

class ChangePassScreen extends StatelessWidget {
  const ChangePassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Terms? terms = LocalTextController.terms;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextBackButton(text: terms?.changePassword ?? "Change Password"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset(lockImage),
            SizedBox(height: 20.h),
            Text(terms?.changePassword ?? "Change Password", style: largeTitleStyle),
            SizedBox(height: 8.h),
            Text(terms?.changePasswordSub ?? "Please Change Your Password", style: appTextStyle),
            SizedBox(height: 20.h),
            InputFieldWhite(
                hintText: terms?.oldPassword ?? "Old Password", prefixIconSvg: lock, isObscure: true),
            SizedBox(height: 8.h),
            InputFieldWhite(
                hintText: terms?.newPassword ?? "New Password", prefixIconSvg: lock, isObscure: true),
            SizedBox(height: 8.h),
            InputFieldWhite(
                hintText: terms?.confirmNewPassword ?? "Confirm New Password",
                prefixIconSvg: lock,
                isObscure: true),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TextButton(
            //     onPressed: () {},
            //     child: Text(terms?.forgotPassword ?? "Forgot Password?",
            //         style: appTextStyle.copyWith(color: colorRed))),
            CustomButton(onTap: () {}, text: terms?.changePassword ?? "Change Password")
          ],
        ),
      ),
    );
  }
}
