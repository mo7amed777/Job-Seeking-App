import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:eservices/controllers/bookmark_jobs_controller.dart';
import 'package:eservices/utils/image_paths.dart';
import 'package:eservices/widgets/center_progress_indicator.dart';
import 'package:eservices/widgets/job_card_short.dart';
import 'package:eservices/widgets/text_back_button.dart';

class BookmarkJobsScreen extends StatefulWidget {
  const BookmarkJobsScreen({super.key});

  @override
  State<BookmarkJobsScreen> createState() => _BookmarkJobsScreenState();
}

class _BookmarkJobsScreenState extends State<BookmarkJobsScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<BookmarkedJobsController>().getBookmarkedJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const TextBackButton(text: "Bookmark Jobs")),
      body: GetBuilder<BookmarkedJobsController>(builder: (controller) {
        return Visibility(
          visible: controller.loading == false,
          replacement: const CenterProgressIndicator(),
          child: Visibility(
            visible: controller.jobList?.isNotEmpty ?? false,
            replacement: const Center(child: Text("Nothing found!")),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(),
              itemCount: controller.jobList?.length ?? 0,
              separatorBuilder: (c, i) => SizedBox(height: 6.h),
              itemBuilder: (context, index) {
                return JobCardShort(
                  job: controller.jobList?[index],
                  fullTime: true,
                  logo: googleIcon,
                  companyName: "IFIC Bank Limited",
                  jobName: "Ui/Ux Designer",
                  salaryRange: "\$10,000 - \$20,000 / Month",
                  topRightWidget: InkWell(
                      onTap: () {}, child: SvgPicture.asset(bookmarkIcon)),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
