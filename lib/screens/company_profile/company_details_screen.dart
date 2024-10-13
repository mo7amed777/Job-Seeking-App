import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eservices/controllers/company_details_controller.dart';
import 'package:eservices/controllers/company_jobs_controller.dart';
import 'package:eservices/models/company_details_model.dart';
import 'package:eservices/screens/company_profile/company_available_jobs.dart';
import 'package:eservices/screens/company_profile/company_overview.dart';
import 'package:eservices/utils/image_paths.dart';
import 'package:eservices/widgets/center_progress_indicator.dart';
import 'package:eservices/widgets/my_network_image.dart';

import '../../controllers/local_text_controller.dart';
import '../../models/app_text_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/appbar_back_button.dart';
import '../../widgets/filled_icon_button.dart';

class CompanyDetailsScreen extends StatefulWidget {
  final int companyId;
  const CompanyDetailsScreen({super.key, required this.companyId});

  @override
  State<CompanyDetailsScreen> createState() => _CompanyDetailsScreenState();
}

class _CompanyDetailsScreenState extends State<CompanyDetailsScreen> {
  static Terms? terms = LocalTextController.terms;
  @override
  void initState() {
    super.initState();
    Get.find<CompanyDetailsController>().getCompanyDetails(widget.companyId);
    Get.find<CompanyJobsController>().getCompanyJobs(widget.companyId);
  }

  final PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;
  List tabs = [
    terms?.overview ?? 'Overview',
    terms?.availableJobs ?? 'Available Jobs',
  ];
  List<Widget> screens = const [
    CompanyOverview(),
    CompanyAvailableJobs(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CompanyDetailsController>(builder: (controller) {
        Company? company = controller.company;
        return Visibility(
          visible: controller.loading == false,
          replacement: const CenterProgressIndicator(),
          child: Column(
            children: [
              appBarSection(company),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    tabBar(),
                  ],
                ),
              ),
              Expanded(
                child: PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  // onPageChanged: (index) {
                  //   currentIndex = index;
                  //   setState(() {});
                  // },
                  children: screens,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Row tabBar() {
    return Row(
      children: List.generate(
        tabs.length,
        (index) {
          bool selected = currentIndex == index;
          return Expanded(
            child: InkWell(
              onTap: () {
                currentIndex = index;
                pageController.jumpToPage(currentIndex);
                setState(() {});
              },
              borderRadius: BorderRadius.circular(8),
              child: AnimatedContainer(
                height: 45.h,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeIn,
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                margin: EdgeInsets.only(
                    right: index == 0 ? 8.w : 0, left: index == 1 ? 8.w : 0),
                decoration: BoxDecoration(
                    color: selected ? colorPrimary : colorPrimaryLighter,
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Text(tabs[index],
                      style: appTitleStyle.copyWith(
                          color: selected ? colorWhite : colorPrimary)),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Container appBarSection(Company? company) {
    return Container(
      padding: const EdgeInsets.all(16).copyWith(left: 0, top: 0),
      decoration: const BoxDecoration(color: colorPrimary),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppBarBackButton(color: colorWhite),
                Row(
                  children: [
                    // FilledIconButton(svgIcon: plus, onTap: () {}),
                    // FilledIconButton(svgIcon: share, onTap: () {}),
                  ],
                ),
              ],
            ),
            Container(
              height: 80.h,
              width: 80.w,
              clipBehavior: Clip.antiAlias,
              //padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: colorWhite),
              child:
                  MyImage(imageUrl: company?.logo ?? '', fit: BoxFit.scaleDown),
            ),
            SizedBox(height: 10.h),
            Text(company?.name ?? "Company Name",
                style:
                    smallTitleStyle.copyWith(fontSize: 18, color: colorWhite)),
            Text(company?.email ?? "Organization",
                style:
                    appSubTextStyle.copyWith(fontSize: 15, color: colorWhite)),
          ],
        ),
      ),
    );
  }
}
