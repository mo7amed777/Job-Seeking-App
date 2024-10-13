import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eservices/models/applied_jobs_model.dart';
import 'package:eservices/screens/job_details_screen.dart';
import 'package:eservices/utils/app_text_styles.dart';
import 'package:eservices/widgets/chip_text.dart';
import 'package:eservices/widgets/my_network_image.dart';

import '../screens/company_profile/company_details_screen.dart';
import '../utils/app_colors.dart';

class JobCardShort extends StatelessWidget {
  final JobModel? job;
  final double? width;
  final bool fullTime;
  final EdgeInsetsGeometry? margin;
  final String logo;
  final String companyName;
  final String jobName;
  final String salaryRange;
  final Widget topRightWidget;
  final VoidCallback? onTap;
  final VoidCallback? onTapCompany;
  const JobCardShort(
      {super.key,
      required this.logo,
      required this.companyName,
      required this.jobName,
      required this.salaryRange,
      this.width,
      this.onTap,
      this.margin,
      required this.topRightWidget,
      this.fullTime = false,
      this.onTapCompany,
      this.job});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      onTap: onTap ?? () => Get.to(JobDetailsScreen(jobId: job?.jobId)),
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
                        child: MyImage(
                            imageUrl: job?.companyLogo ?? '',
                            height: 30.h,
                            width: 30.w),
                      ),
                      SizedBox(width: 6.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(job?.companyName ?? 'Company Name',
                              style: appTitleStyle.copyWith(
                                  fontSize: 14, color: colorLightGreen)),
                          SizedBox(width: 5.w),
                          // Text(job?.jobTitle ?? '',
                          //     style:
                          //         appSubTextStyle.copyWith(color: colorBlack, fontWeight: FontWeight.w600),
                          //     maxLines: 1,
                          //     overflow: TextOverflow.ellipsis),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width / 1.9,
                            child: Text(job?.jobTitle ?? '',
                                style: appSubTextStyle.copyWith(
                                    color: colorBlack,
                                    fontWeight: FontWeight.w600),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 5.w),
                // topRightWidget,
              ],
            ),
            //SizedBox(height: 8.h),
            // Row(
            //   children: [
            //     optionCard(time),
            //     SizedBox(width: 5.w),
            //     optionCard(jobType),
            //     SizedBox(width: 5.w),
            //     optionCard(experience),
            //   ],
            // ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("\$${job?.salary ?? 0} / Month", style: appTitleStyle),
                if (fullTime) const ChipText(text: "Full Time")
              ],
            ),
          ],
        ),
      ),
    );
  }
}
