import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:job_nect/controllers/applied_jobs_controller.dart';
import 'package:job_nect/controllers/bottom_nav_controller.dart';
import 'package:job_nect/controllers/categories_controller.dart';
import 'package:job_nect/controllers/companies_controller.dart';
import 'package:job_nect/controllers/latest_jobs_controller.dart';
import 'package:job_nect/controllers/popular_jobs_controller.dart';
import 'package:job_nect/screens/nav_applied_screen.dart';
import 'package:job_nect/screens/nav_explore_screen.dart';
import 'package:job_nect/screens/nav_home_screen.dart';
import 'package:job_nect/screens/nav_profile_screen.dart';
import 'package:job_nect/utils/app_colors.dart';
import 'package:job_nect/utils/image_paths.dart';

import '../controllers/local_text_controller.dart';
import '../models/app_text_model.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  @override
  void initState() {
    super.initState();
    Get.lazyPut(() => LatestJobsController());
    Get.find<PopularJobsController>().getPopularJobs();
    Get.find<AppliedJobsController>().getAppliedJobs();
    Get.find<CategoriesController>().getCategories();
    Get.find<CompaniesController>().getFeaturedCompanies();
  }

  @override
  Widget build(BuildContext context) {
    Terms? terms = LocalTextController.terms;
    final controller = Get.find<BottomNavController>();

    List screens = const [
      NavHomeScreen(),
      NavExploreScreen(),
      NavAppliedScreen(),
      NavProfileScreen(),
    ];
    return GetBuilder<BottomNavController>(builder: (controller) {
      return Scaffold(
        body: screens.elementAt(controller.currentIndex),
        bottomNavigationBar:
            GetBuilder<LocalTextController>(builder: (textController) {
          Terms? terms = LocalTextController.terms;
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            unselectedItemColor: colorBlackLight,
            selectedItemColor: colorPrimary,
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                      controller.currentIndex == 0 ? homeFilled : home),
                  label: terms?.home ?? "Home"),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                      controller.currentIndex == 1 ? searchFilled : search),
                  label: terms?.explore ?? "Explore"),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                      controller.currentIndex == 2 ? appliedFilled : applied),
                  label: terms?.applied ?? "Applied"),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                      controller.currentIndex == 3 ? profileFilled : profile),
                  label: terms?.profile ?? "Profile"),
            ],
            currentIndex: controller.currentIndex,
            onTap: (index) {
              if (index == 1) {
                Get.to(() => const NavExploreScreen());
              } else {
                controller.changeScreen(index);
              }
            },
          );
        }),
      );
    });
  }
}
