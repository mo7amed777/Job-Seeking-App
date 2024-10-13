import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eservices/controllers/companies_controller.dart';
import 'package:eservices/controllers/filter_jobs_controller.dart';
import 'package:eservices/controllers/notification_controller.dart';
import 'package:eservices/controllers/app_text_controller.dart';
import 'package:eservices/controllers/applied_jobs_controller.dart';
import 'package:eservices/controllers/apply_job_controller.dart';
import 'package:eservices/controllers/auth_controller.dart';
import 'package:eservices/controllers/bookmark_jobs_controller.dart';
import 'package:eservices/controllers/bottom_nav_controller.dart';
import 'package:eservices/controllers/categories_filter_controller.dart';
import 'package:eservices/controllers/categories_controller.dart';
import 'package:eservices/controllers/company_details_controller.dart';
import 'package:eservices/controllers/company_jobs_controller.dart';
import 'package:eservices/controllers/designation_controller.dart';
import 'package:eservices/controllers/edit_resume_controller.dart';
import 'package:eservices/controllers/education_levels_controller.dart';
import 'package:eservices/controllers/job_details_controller.dart';
import 'package:eservices/controllers/job_levels_controller.dart';
import 'package:eservices/controllers/job_types_controller.dart';
import 'package:eservices/controllers/job_types_filter_controller.dart';
import 'package:eservices/controllers/language_controller.dart';
import 'package:eservices/controllers/latest_jobs_controller.dart';
import 'package:eservices/controllers/local_settings_controller.dart';
import 'package:eservices/controllers/local_text_controller.dart';
import 'package:eservices/controllers/login_controller.dart';
import 'package:eservices/controllers/reset_pass_controller.dart';
import 'package:eservices/controllers/resume_details_controller.dart';
import 'package:eservices/controllers/setting_controller.dart';
import 'package:eservices/controllers/signup_controller.dart';
import 'package:eservices/controllers/slider_controller.dart';
import 'package:eservices/controllers/update_image_controller.dart';
import 'package:eservices/controllers/update_profile_controller.dart';
import 'package:eservices/screens/onboarding_screens/splash_screen.dart';
import 'package:eservices/utils/app_theme.dart';

import 'controllers/popular_jobs_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'NBU E-Services',
          theme: appThemeData,
          initialBinding: ControllerBindings(),
          home: const SplashScreen(),
        );
      },
    );
  }
}

class ControllerBindings extends Bindings {
  @override
  void dependencies() async {
    Get.put(AuthController());
    Get.put(AppTextController());
    Get.put(LocalTextController());
    Get.put(LanguageController());
    Get.put(SettingsController());
    Get.put(SliderController());
    Get.put(LocalSettingsController());
    Get.put(BottomNavController());
    Get.put(SignupController());
    Get.put(LoginController());
    Get.put(ResetPasswordController());
    Get.put(CategoriesController());
    Get.put(CompaniesController());
    Get.put(NotificationController());

    bool loggedInUser = await Get.find<AuthController>().checkAuthState();
    if (loggedInUser) {
      // Load only if authenticated
      Get.lazyPut(() => LatestJobsController());
      Get.put(FilterJobsController());
    }

    Get.put(PopularJobsController());
    Get.put(AppliedJobsController());
    Get.put(BookmarkedJobsController());
    Get.put(JobDetailsController());
    Get.put(CompanyDetailsController());
    Get.put(CompanyJobsController());
    Get.put(ResumeDetailsController());
    Get.put(ApplyJobController());
    Get.put(UpdateProfileController());
    Get.put(UpdateImageController());
    Get.put(DesignationController());
    Get.put(JobTypesController());
    Get.put(JobLevelsController());
    Get.put(EducationLevelsController());
    Get.put(EditResumeController());
    Get.lazyPut(() => CategoriesFilterController());
    Get.lazyPut(() => JobTypesFilterController());
  }
}
