import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job_nect/controllers/applied_jobs_controller.dart';
import 'package:job_nect/models/applied_jobs_model.dart';
import 'package:job_nect/utils/image_paths.dart';
import 'package:job_nect/widgets/center_progress_indicator.dart';
import 'package:job_nect/widgets/chip_text.dart';
import 'package:job_nect/widgets/job_card_short.dart';
import 'package:job_nect/widgets/text_back_button.dart';

import '../controllers/bottom_nav_controller.dart';
import '../controllers/local_text_controller.dart';
import '../models/app_text_model.dart';

class NavAppliedScreen extends StatefulWidget {
  const NavAppliedScreen({super.key});

  @override
  State<NavAppliedScreen> createState() => _NavAppliedScreenState();
}

class _NavAppliedScreenState extends State<NavAppliedScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<AppliedJobsController>().getAppliedJobs();
  }

  @override
  Widget build(BuildContext context) {
    Terms? terms = LocalTextController.terms;
    return PopScope(
      canPop: false,
      onPopInvoked: (_) => Get.find<BottomNavController>().backToHome(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: TextBackButton(
              text: terms?.appliedJobs ?? "Applied Jobs",
              onTap: () => Get.find<BottomNavController>().backToHome()),
        ),
        body: GetBuilder<AppliedJobsController>(builder: (controller) {
          return Visibility(
            visible: controller.loading == false,
            replacement: const CenterProgressIndicator(),
            child: Visibility(
              visible: controller.jobList?.isNotEmpty ?? false,
              replacement: const Center(child: Text("Nothing found!")),
              child: ListView.separated(
                padding: const EdgeInsets.all(16).copyWith(top: 0),
                physics: const BouncingScrollPhysics(),
                itemCount: controller.jobList?.length ?? 0,
                separatorBuilder: (c, i) => SizedBox(height: 6.h),
                itemBuilder: (context, index) {
                  JobModel? job = controller.jobList?[index];
                  return JobCardShort(
                    job: job,
                    logo: googleIcon,
                    companyName: "IFIC Bank Limited",
                    jobName: "Ui/Ux Designer",
                    salaryRange: "\$10,000 - \$20,000 / Month",
                    topRightWidget: const ChipText(text: "Applied"),
                  );
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}
