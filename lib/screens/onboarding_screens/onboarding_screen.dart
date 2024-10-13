import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eservices/controllers/local_text_controller.dart';
import 'package:eservices/controllers/slider_controller.dart';
import 'package:eservices/models/app_text_model.dart';
import 'package:eservices/screens/onboarding_screens/select_account_screen.dart';
import 'package:eservices/utils/app_colors.dart';
import 'package:eservices/utils/app_text_styles.dart';
import 'package:eservices/widgets/my_network_image.dart';
import 'package:eservices/screens/onboarding_screens/welcome_screen.dart';
import '../../widgets/custom_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: colorWhite,
      body: GetBuilder<SliderController>(builder: (controller) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView.builder(
              controller: pageController,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index) {
                currentIndex = index;
                setState(() {});
              },
              itemCount: controller.slides?.length,
              itemBuilder: (c, index) {
                final slide = controller.slides?.reversed.toList()[index];
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Image.asset(
                      //   contents[i].image,
                      // ),
                      MyImage(
                        imageUrl: slide?.image ?? '',
                        height: 250.h,
                        width: mq.width / 1.1,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 30.h),
                      Text(
                        slide?.description ?? '',
                        textAlign: TextAlign.center,
                        style: mediumTitleStyle,
                      ),
                      SizedBox(height: 20.h),
                      // Text(
                      //   contents[i].subtitle,
                      //   textAlign: TextAlign.center,
                      //   style: appTextStyle,
                      // ),
                    ],
                  ),
                );
              },
            ),
            Positioned(
              //bottom: 140.h,
              bottom: 0,
              child: dotIndicator(),
            ),
          ],
        );
      }),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Row dotIndicator() {
    return Row(
      children: List.generate(
        Get.find<SliderController>().slides?.length ?? 0,
        (index) => Padding(
          padding: const EdgeInsets.all(3).r,
          child: CircleAvatar(
            radius: 4.r,
            backgroundColor:
                currentIndex == index ? colorPrimary : colorLightGrey,
          ),
        ),
      ),
    );
  }

  Widget bottomNavigationBar() {
    Terms? terms = LocalTextController.terms;
    return Padding(
      padding: const EdgeInsets.all(16).r.copyWith(top: 30),
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              onTap: () => Get.to(const WelcomeScreen(accType: 'Employee')),
              text: terms?.skip,
              backgroundColor: colorPrimaryLight,
              foregroundColor: colorPrimary,
              surfaceTintColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: CustomButton(
              onTap: () {
                if (currentIndex ==
                    (Get.find<SliderController>().slides?.length ?? 0) - 1) {
                  Get.to(const WelcomeScreen(accType: 'Employee'));
                }
                pageController.nextPage(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                );
              },
              text: currentIndex == 2 ? terms?.getStarted : terms?.next,
            ),
          ),
        ],
      ),
    );
  }
}
