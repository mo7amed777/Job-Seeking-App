import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:eservices/controllers/bookmark_jobs_controller.dart';
import 'package:eservices/controllers/job_details_controller.dart';
import 'package:eservices/screens/apply_job_screen.dart';
import 'package:eservices/screens/company_profile/company_details_screen.dart';
import 'package:eservices/utils/app_colors.dart';
import 'package:eservices/utils/app_text_styles.dart';
import 'package:eservices/utils/image_paths.dart';
import 'package:eservices/utils/ui_helper.dart';
import 'package:eservices/widgets/bullet_text.dart';
import 'package:eservices/widgets/center_progress_indicator.dart';
import 'package:eservices/widgets/custom_button.dart';
import 'package:eservices/widgets/filled_icon_button.dart';
import 'package:eservices/widgets/text_back_button.dart';

import '../controllers/local_text_controller.dart';
import '../models/app_text_model.dart';
import '../models/job_model.dart';
import '../widgets/floating_card.dart';

class JobDetailsScreen extends StatefulWidget {
  final int? jobId;
  const JobDetailsScreen({super.key, this.jobId});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<JobDetailsController>().getJobDetails(widget.jobId);
  }

  //Job? job = Get.find<JobDetailsController>().jobDetails;

  @override
  Widget build(BuildContext context) {
    Terms? terms = LocalTextController.terms;
    return Scaffold(
      appBar: appBar(),
      body: GetBuilder<JobDetailsController>(builder: (controller) {
        Job? job = controller.jobDetails;
        if (controller.loading) {
          return const CenterProgressIndicator();
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              FloatingCard(
                image: job?.companyLogo ?? '',
                title: job?.title ?? "Ui/Ux Designer",
                subTitle: job?.company ?? "Apex Limited",
                titleOne: terms?.salary ?? "Salary",
                valueOne: "\$${job?.salary}/m",
                titleTwo: terms?.jobType ?? "Job Type",
                valueTwo: "Full-Time",
                titleThree: "Vacancy",
                valueThree: job?.vacancy.toString() ?? "10",
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(terms?.jobDescription ?? "Job description",
                        style: smallTitleStyle),
                    SizedBox(height: 8.h),
                    Text(job?.description ?? '', style: appTextStyle),
                    SizedBox(height: 10.h),
                    Text(terms?.skills ?? "Skills", style: smallTitleStyle),
                    SizedBox(height: 8.h),
                    ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: job?.skills?.length ?? 0,
                      itemBuilder: (context, index) {
                        return BulletText(text: job?.skills?[index] ?? "");
                      },
                    ),
                    SizedBox(height: 10.h),
                    // const Text("Workplace", style: smallTitleStyle),
                    // SizedBox(height: 8.h),
                    // const BulletText(text: "Work at office"),
                    // SizedBox(height: 10.h),
                    Text(terms?.jobType ?? "Job type", style: smallTitleStyle),
                    SizedBox(height: 8.h),
                    ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: job?.jobType?.length ?? 0,
                      itemBuilder: (context, index) {
                        return BulletText(text: job?.jobType?[index] ?? "");
                      },
                    ),
                    SizedBox(height: 10.h),
                    // const Text("Experience Requirements", style: smallTitleStyle),
                    // SizedBox(height: 8.h),
                    // const BulletText(text: "At least 1 year"),
                    // SizedBox(height: 10.h),
                    // const Text("Additional Requirements", style: smallTitleStyle),
                    // SizedBox(height: 8.h),
                    // ListView.builder(
                    //   primary: false,
                    //   shrinkWrap: true,
                    //   itemCount: 5,
                    //   itemBuilder: (context, index) {
                    //     return const BulletText(
                    //         text: "Develop understanding of new concepts of insurance business.");
                    //   },
                    // ),
                    // SizedBox(height: 10.h),
                    // const Text("Benefits", style: smallTitleStyle),
                    // SizedBox(height: 8.h),
                    // ListView.builder(
                    //   primary: false,
                    //   shrinkWrap: true,
                    //   itemCount: 5,
                    //   itemBuilder: (context, index) {
                    //     return const BulletText(text: "Comprehensive health, dental, and vision plans.");
                    //   },
                    // ),
                    // SizedBox(height: 10.h),
                    // const Text("Job Location", style: smallTitleStyle),
                    // SizedBox(height: 8.h),
                    // const BulletText(text: "2118 Thornridge Cir. Syracuse, Connecticut 35624"),
                    // SizedBox(height: 10.h),
                    // const Text("Comopany Info", style: smallTitleStyle),
                    // SizedBox(height: 8.h),
                    // const Text(
                    //     "Name: Apex Limited\nPublishing Date: 25 Nov 2023\nEmail: apex@gmail.com\nAddress:  2118 Thornridge Cir. Syracuse, Connecticut.",
                    //     style: appTextStyle),
                    InkWell(
                      borderRadius: BorderRadius.circular(50.r),
                      onTap: () => Get.to(
                          CompanyDetailsScreen(companyId: job?.companyId ?? 0)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0).copyWith(left: 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(terms?.visitCompany ?? "Visit Company",
                                style: appSubTextStyle.copyWith(
                                    color: colorPrimary)),
                            const SizedBox(width: 5),
                            const Icon(Icons.arrow_forward_ios,
                                size: 14, color: colorPrimary),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //bottomNavigationBar(),
            ],
          ),
        );
      }),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  AppBar appBar() {
    Terms? terms = LocalTextController.terms;
    return AppBar(
      backgroundColor: colorPrimary,
      automaticallyImplyLeading: false,
      title:
          TextBackButton(text: terms?.jobDetails ?? "Job Details", white: true),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 10.w),
          // child: FilledIconButton(svgIcon: share, onTap: () {}),
        ),
      ],
    );
  }

  Widget bottomNavigationBar() {
    Terms? terms = LocalTextController.terms;
    return GetBuilder<JobDetailsController>(builder: (controller) {
      Job? job = controller.jobDetails;
      return Visibility(
        visible: controller.loading == false,
        replacement: const SizedBox(),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorWhite,
            boxShadow: [
              BoxShadow(
                  color: colorPrimaryLight,
                  offset: const Offset(0, -4),
                  blurRadius: 20),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("${terms?.applicationDeadline} : ${job?.endDate}",
                  style: appTitleStyle.copyWith(color: colorRed)),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      surfaceTintColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      backgroundColor: colorPrimaryLighter,
                      //text: "Bookmark",
                      foregroundColor: colorPrimary,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(bookmarkIcon),
                          SizedBox(width: 5.w),
                          Text(
                            "Bookmark",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      onTap: () async {
                        // Call the bookmark API with the job ID

                        await Get.find<BookmarkedJobsController>()
                            .bookmarkJob(job?.id);
                      },
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: CustomButton(
                      onTap: () => Get.to(ApplyJobScreen(job: job)),
                      text: "Apply Now",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
