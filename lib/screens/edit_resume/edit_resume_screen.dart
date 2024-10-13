import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job_nect/controllers/resume_details_controller.dart';
import 'package:job_nect/screens/edit_resume/academic_qualification.dart';
import 'package:job_nect/screens/edit_resume/career_object.dart';
import 'package:job_nect/screens/edit_resume/edit_address.dart';
import 'package:job_nect/screens/edit_resume/edit_language.dart';
import 'package:job_nect/screens/edit_resume/edit_personal_details.dart';
import 'package:job_nect/screens/edit_resume/edit_reference.dart';
import 'package:job_nect/screens/edit_resume/training_summary.dart';
import 'package:job_nect/screens/edit_resume/work_experience.dart';
import 'package:job_nect/utils/app_colors.dart';
import 'package:job_nect/utils/app_text_styles.dart';
import 'package:job_nect/widgets/custom_button.dart';
import 'package:job_nect/widgets/text_back_button.dart';

import '../../controllers/local_text_controller.dart';
import '../../models/app_text_model.dart';

class EditResumeScreen extends StatefulWidget {
  const EditResumeScreen({super.key});

  @override
  State<EditResumeScreen> createState() => _EditResumeScreenState();
}

class _EditResumeScreenState extends State<EditResumeScreen> with SingleTickerProviderStateMixin {
  static Terms? terms = LocalTextController.terms;
  final PageController pageController = PageController(initialPage: 0);
  //final ScrollController scrollController = ScrollController();
  final resume = Get.find<ResumeDetailsController>().resume;
  int currentIndex = 0;
  List tabs = [
    terms?.personalDetails ?? 'Personal Details',
    terms?.address ?? 'Address',
    terms?.careerObjective ?? 'Career Objective',
    terms?.workExperience ?? 'Work Experience',
    terms?.academicQualification ?? 'Academic Qualification',
    //'Special Qualification',
    terms?.trainingSummary ?? 'Training Summary',
    terms?.language ?? 'Language',
    terms?.reference ?? 'Reference'
  ];
  List<Widget> screens = const [
    EditPersonalDetails(),
    EditAddress(),
    CareerObject(),
    WorkExperience(),
    AcademicQualification(),
    //SpecialQualification(),
    TrainingSummary(),
    EditLanguage(),
    Reference(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false, title: TextBackButton(text: terms?.viewResume ?? "Edit Resume")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            tabBar(),
            SizedBox(height: 12.h),
            Expanded(
              child: PageView(
                controller: pageController,
                // physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  currentIndex = index;
                  setState(() {});
                },
                children: screens,
              ),
            ),
          ],
        ),
      ),
      //bottomNavigationBar: bottomNavBar(),
    );
  }

  SingleChildScrollView tabBar() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          tabs.length,
          (index) {
            bool selected = currentIndex == index;
            return InkWell(
              onTap: () {
                currentIndex = index;
                pageController.jumpToPage(currentIndex);
                setState(() {});
              },
              borderRadius: BorderRadius.circular(8),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeIn,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                margin: EdgeInsets.only(right: 5.w),
                decoration: BoxDecoration(
                    color: selected ? colorPrimary : colorPrimaryLighter,
                    borderRadius: BorderRadius.circular(8)),
                child: Text(tabs[index],
                    style: appTitleStyle.copyWith(color: selected ? colorWhite : colorPrimary)),
              ),
            );
          },
        ),
      ),
    );
  }

  Padding bottomNavBar() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      child: CustomButton(
        text: "Save & Continue",
        onTap: () {
          if (currentIndex == tabs.length - 1) {
            //Get.to(const SelectAccountScreen());
          }
          pageController.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
          // controller.nextPage(
          //   duration: const Duration(milliseconds: 250),
          //   curve: Curves.easeInOut,
          // );
        },
      ),
    );
  }
}
