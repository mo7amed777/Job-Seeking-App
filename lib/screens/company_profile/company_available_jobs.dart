import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job_nect/controllers/company_jobs_controller.dart';
import 'package:job_nect/utils/app_text_styles.dart';
import 'package:job_nect/utils/image_paths.dart';
import 'package:job_nect/widgets/center_progress_indicator.dart';
import 'package:job_nect/widgets/job_card_detailed.dart';

import '../../controllers/local_text_controller.dart';
import '../../models/app_text_model.dart';

class CompanyAvailableJobs extends StatelessWidget {
  const CompanyAvailableJobs({super.key});

  @override
  Widget build(BuildContext context) {
    Terms? terms = LocalTextController.terms;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(terms?.availableVacancy ?? "Available Vacancy", style: smallTitleStyle),
          GetBuilder<CompanyJobsController>(builder: (controller) {
            return Visibility(
              visible: controller.loading == false,
              replacement: const CenterProgressIndicator(),
              child: Visibility(
                visible: controller.jobList?.isNotEmpty ?? false,
                replacement: const Center(child: Text("No Jobs found!")),
                child: ListView.separated(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  itemCount: controller.jobList?.length ?? 0,
                  primary: false,
                  shrinkWrap: true,
                  separatorBuilder: (c, i) => SizedBox(height: 8.h),
                  itemBuilder: (context, index) {
                    final job = controller.jobList?[index];
                    return JobCardDetailed(
                      job: job,
                      logo: googleIcon,
                      companyName: "Apex Limited",
                      jobName: "Sales Manager",
                      time: "Full Time",
                      jobType: "Onsite",
                      experience: "2 year exp",
                      salaryRange: "\$10,000 - \$20,000 / Month",
                    );
                  },
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
