import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:job_nect/screens/bottom_nav_screen.dart';
import 'package:job_nect/utils/app_colors.dart';
import 'package:job_nect/utils/image_paths.dart';
import 'package:job_nect/utils/strings.dart';
import 'package:job_nect/widgets/appbar_back_button.dart';
import 'package:job_nect/widgets/custom_button.dart';

import '../models/job_topic_model.dart';
import '../utils/app_text_styles.dart';

class JobTopicScreen extends StatefulWidget {
  const JobTopicScreen({super.key});

  @override
  State<JobTopicScreen> createState() => _JobTopicScreenState();
}

class _JobTopicScreenState extends State<JobTopicScreen> {
  List<JobTopicModel> jobTopicList = const [
    JobTopicModel(icon: videoEdit, title: "Video Edit"),
    JobTopicModel(icon: marketing, title: "Marketing"),
    JobTopicModel(icon: uiUx, title: "Ui/Ux"),
    JobTopicModel(icon: programming, title: "Programming"),
    JobTopicModel(icon: webDesign, title: "Web Design"),
    JobTopicModel(icon: design, title: "Design"),
    JobTopicModel(icon: health, title: "Health"),
    JobTopicModel(icon: travel, title: "Travel"),
    JobTopicModel(icon: it, title: "IT"),
  ];
  List<String> selectedTopic = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBarBackButton(),
                SizedBox(width: 10),
                Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Text(jobTopicTitle, textAlign: TextAlign.center, style: mediumTitleStyle),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  selectionCard(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavBar(),
    );
  }

  Widget selectionCard() {
    return GridView.builder(
      shrinkWrap: true,
      //primary: false,
      physics: const BouncingScrollPhysics(),
      itemCount: jobTopicList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, mainAxisSpacing: 8.h, crossAxisSpacing: 8.w),
      itemBuilder: (context, index) {
        bool selected = selectedTopic.contains(jobTopicList[index].title);
        return InkWell(
          borderRadius: BorderRadius.circular(10).r,
          onTap: () {
            if (selected) {
              selectedTopic.remove(jobTopicList[index].title);
            } else {
              selectedTopic.add(jobTopicList[index].title);
            }
            setState(() {});
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10).r,
                border:
                    Border.all(width: selected ? 1.3 : 1, color: selected ? colorPrimary : colorLightGrey)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(jobTopicList[index].icon,
                    //color: selected ? colorPrimary : colorBlack,
                    colorFilter: ColorFilter.mode(selected ? colorPrimary : colorBlack, BlendMode.srcIn)),
                SizedBox(height: 8.h),
                Text(jobTopicList[index].title, style: appSubTextStyle),
              ],
            ),
          ),
        );
      },
    );
  }

  Padding bottomNavBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: CustomButton(onTap: () => Get.offAll(const BottomNavScreen()), text: "Find Jobs"),
    );
  }
}
