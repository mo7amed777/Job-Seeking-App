import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:job_nect/controllers/bookmark_jobs_controller.dart';
import 'package:job_nect/models/job_model.dart';
import 'package:job_nect/screens/company_profile/company_details_screen.dart';
import 'package:job_nect/screens/job_details_screen.dart';
import 'package:job_nect/utils/app_text_styles.dart';
import 'package:job_nect/widgets/my_network_image.dart';

import '../utils/app_colors.dart';
import '../utils/image_paths.dart';
import 'chip_text.dart';

class JobCardDetailed extends StatelessWidget {
  final Job? job;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final String? logo;
  final String? companyName;
  final String? jobName;
  final String? time;
  final String? jobType;
  final String? experience;
  final String? salaryRange;
  final VoidCallback? onTap;
  final VoidCallback? onTapCompany;
  const JobCardDetailed(
      {super.key,
      this.logo,
      this.companyName,
      this.jobName,
      this.time,
      this.jobType,
      this.experience,
      this.salaryRange,
      this.width,
      this.onTap,
      this.margin,
      this.onTapCompany,
      this.job});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      onTap: onTap ?? () => Get.to(JobDetailsScreen(jobId: job?.id)),
      child: Container(
        width: width,
        margin: margin,
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: colorPrimaryLighter, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(6),
                  onTap: onTapCompany ??
                      () => Get.to(
                          CompanyDetailsScreen(companyId: job?.companyId ?? 0)),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                color: colorPrimary.withOpacity(0.1),
                                width: 1.2)),
                        child: MyNetworkImage(
                            imageUrl: job?.companyLogo ?? '',
                            height: 30.h,
                            width: 30.h),
                      ),
                      SizedBox(width: 6.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(job?.company ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: appTitleStyle.copyWith(
                                  fontSize: 14, color: colorLightGreen)),
                          SizedBox(width: 5.w),
                          Text(job?.title ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: appSubTextStyle.copyWith(
                                  color: colorBlack,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 5.w),
                InkWell(
                  borderRadius: BorderRadius.circular(6),
                  onTap: () async {
                    // Call the bookmark API with the job ID
                    await Get.find<BookmarkedJobsController>()
                        .bookmarkJob(job?.id);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: SvgPicture.asset(bookmarkIcon),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              children: job?.jobType
                      ?.map((e) => ChipText(
                          text: e, margin: EdgeInsets.only(right: 5.w)))
                      ?.toList() ??
                  [],
            ),
            SizedBox(height: 8.h),
            Text("\$${job?.salary} / month", style: appTitleStyle),
          ],
        ),
      ),
    );
  }
}
