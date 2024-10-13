import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:job_nect/controllers/applied_jobs_controller.dart';
import 'package:job_nect/controllers/auth_controller.dart';
import 'package:job_nect/controllers/bookmark_jobs_controller.dart';
import 'package:job_nect/controllers/bottom_nav_controller.dart';
import 'package:job_nect/screens/bookmark_jobs_screen.dart';
import 'package:job_nect/screens/change_pass_screen.dart';
import 'package:job_nect/screens/my_profile_screen.dart';
import 'package:job_nect/screens/onboarding_screens/onboarding_screen.dart';
import 'package:job_nect/screens/setting_screen.dart';
import 'package:job_nect/screens/view_resume_screen.dart';
import 'package:job_nect/utils/app_colors.dart';
import 'package:job_nect/utils/app_text_styles.dart';
import 'package:job_nect/utils/image_paths.dart';
import 'package:job_nect/utils/strings.dart';
import 'package:job_nect/widgets/custom_button.dart';
import 'package:job_nect/widgets/filled_icon_button.dart';
import 'package:job_nect/widgets/floating_card.dart';

import '../controllers/designation_controller.dart';
import '../controllers/local_text_controller.dart';
import '../models/app_text_model.dart';
import '../models/user.dart';
import 'notification_screen.dart';

class NavProfileScreen extends StatefulWidget {
  const NavProfileScreen({super.key});

  @override
  State<NavProfileScreen> createState() => _NavProfileScreenState();
}

class _NavProfileScreenState extends State<NavProfileScreen> {
  @override
  void initState() {
    super.initState();
    if (Get.find<DesignationController>().designations == null) {
      Get.find<DesignationController>().getDesignations();
    }
  }

  @override
  Widget build(BuildContext context) {
    User? profile = Get.find<AuthController>().user;
    return PopScope(
      canPop: false,
      onPopInvoked: (_) => Get.find<BottomNavController>().backToHome(),
      child: GetBuilder<LocalTextController>(builder: (textController) {
        Terms? terms = LocalTextController.terms;
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: colorPrimary,
            titleSpacing: 16,
            title: Text(terms?.profile ?? "Profile",
                style: smallTitleStyle.copyWith(color: colorWhite)),
            // actions: [
            //   Padding(
            //     padding: const EdgeInsets.only(right: 10),
            //     child: FilledIconButton(onTap: () => Get.to(const SettingScreen()), svgIcon: settingIcon),
            //   )
            // ],
          ),
          body: Column(
            children: [
              FloatingCard(
                image: profile?.profilePhoto ?? man,
                title: profile?.name ?? "Name",
                subTitle: profile?.designation?.name ?? "Designation",
                titleOne: terms?.applied ?? "Applied",
                valueOne: Get.find<AppliedJobsController>()
                        .jobList
                        ?.length
                        .toString() ??
                    "25",
                titleTwo: "Interview",
                valueTwo: "10",
                titleThree: terms?.bookmarkJobs ?? "Bookmark",
                valueThree: Get.find<BookmarkedJobsController>()
                        .jobList
                        ?.length
                        .toString() ??
                    "16",
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: colorWhite,
                  boxShadow: [
                    BoxShadow(
                      color: colorPrimaryLight,
                      offset: const Offset(0, 4),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    optionCard(userIcon, terms?.profile ?? "Profile",
                        () => Get.to(const MyProfileScreen())),
                    optionCard(
                        appliedJobsIcon,
                        terms?.appliedJobs ?? "Applied Jobs",
                        () => Get.find<BottomNavController>().changeScreen(2)),
                    optionCard(
                        bookmarkJobsIcon,
                        terms?.bookmarkJobs ?? "Bookmark Jobs",
                        () => Get.to(const BookmarkJobsScreen())),
                    optionCard(resume, terms?.viewResume ?? "View Resume",
                        () => Get.to(const ViewResumeScreen())),
                    optionCard(bell, terms?.notification ?? "Notification",
                        () => Get.to(const NotificationScreen())),
                    optionCard(
                        lockDot,
                        terms?.changePassword ?? "Change Password",
                        () => Get.to(const ChangePassScreen())),
                    optionCard(logoutIcon, terms?.logout ?? "Logout",
                        () => logoutDialog(context), false),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget optionCard(String icon, String title, VoidCallback? onTap,
      [bool divider = true]) {
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap ?? () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  //Image.asset(userIcon, height: 20.h),
                  SvgPicture.asset(icon, color: colorPrimary),
                  const SizedBox(width: 10),
                  Text(title, style: appTitleStyle)
                ],
              ),
              const Icon(Icons.arrow_forward_ios,
                  size: 18, color: colorBlackLight),
            ],
          ),
        ),
        if (divider)
          Divider(color: colorLightGrey, thickness: 0.7, height: 20.h)
      ],
    );
  }

  logoutDialog(context) {
    Terms? terms = LocalTextController.terms;
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 35),
          width: MediaQuery.sizeOf(context).width,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(terms?.logout ?? logout,
                  style: mediumTitleStyle.copyWith(color: colorPrimary)),
              SizedBox(height: 10.h),
              Text(terms?.logoutWarning ?? logoutWarning,
                  style: appSubTextStyle.copyWith(fontSize: 15.sp)),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      shadowColor: Colors.transparent,
                      surfaceTintColor: Colors.transparent,
                      backgroundColor: colorPrimaryLighter,
                      foregroundColor: colorPrimary,
                      onTap: () => Get.back(closeOverlays: true),
                      text: terms?.no ?? no,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomButton(
                        text: terms?.yes ?? yes,
                        onTap: () async {
                          await AuthController.clearAuthData();
                          Get.offAll(const OnboardingScreen());
                        }),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
