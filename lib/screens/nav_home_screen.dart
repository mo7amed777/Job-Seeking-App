import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:job_nect/controllers/auth_controller.dart';
import 'package:job_nect/controllers/categories_controller.dart';
import 'package:job_nect/controllers/companies_controller.dart';
import 'package:job_nect/controllers/latest_jobs_controller.dart';
import 'package:job_nect/controllers/popular_jobs_controller.dart';
import 'package:job_nect/models/job_model.dart';
import 'package:job_nect/models/user.dart';
import 'package:job_nect/screens/all_category_screen.dart';
import 'package:job_nect/screens/all_company_screen.dart';
import 'package:job_nect/screens/nav_explore_screen.dart';
import 'package:job_nect/screens/notification_screen.dart';
import 'package:job_nect/utils/app_colors.dart';
import 'package:job_nect/utils/app_text_styles.dart';
import 'package:job_nect/utils/image_paths.dart';
import 'package:job_nect/widgets/category_item_card.dart';
import 'package:job_nect/widgets/company_item_card.dart';
import 'package:job_nect/widgets/center_progress_indicator.dart';
import 'package:job_nect/widgets/job_card_detailed.dart';
import 'package:job_nect/widgets/my_network_image.dart';

import '../controllers/local_text_controller.dart';
import '../models/app_text_model.dart';
import '../widgets/search_text_field.dart';

class NavHomeScreen extends StatefulWidget {
  const NavHomeScreen({Key? key}) : super(key: key);

  @override
  _NavHomeScreenState createState() => _NavHomeScreenState();
}

class _NavHomeScreenState extends State<NavHomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  void _onSearch() {
    String query = _searchController.text.trim();
    if (query.isNotEmpty) {
      Get.to(() => NavExploreScreen(query: query));
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Get.find<LatestJobsController>().getLatestJobs();
  }

  @override
  Widget build(BuildContext context) {
    Terms? terms = LocalTextController.terms;
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: SingleChildScrollView(
            child: Column(
              children: [
                appBarSection(),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sectionTitle(
                        title: terms?.jobCategories ?? "Job Categories",
                        onViewAll: () => Get.to(const AllCategoryScreen()),
                      ),
                      SizedBox(height: 10.h),
                      jobCategories(),
                      SizedBox(height: 20.h),
                      sectionTitle(
                        title: terms?.allCompany ?? "All Company",
                        onViewAll: () => Get.to(const AllCompanyScreen()),
                      ),
                      SizedBox(height: 10.h),
                      companies(),
                      SizedBox(height: 20.h),
                      Text(
                        terms?.recommendedJobs ?? "Recommended",
                        style: smallTitleStyle,
                      ),
                      SizedBox(height: 10.h),
                      recommendedJobs(),
                      SizedBox(height: 20.h),
                      Text(
                        terms?.latestJobs ?? "Latest jobs",
                        style: smallTitleStyle,
                      ),
                      SizedBox(height: 10.h),
                      latestJobs(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget appBarSection() {
    User? user = Get.find<AuthController>().user;
    return Container(
      padding: const EdgeInsets.all(16),
      color: colorPrimary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 48.h,
                width: 48.w,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: MyNetworkImage(
                  imageUrl: user?.profilePhoto ?? '',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Good Morning!",
                    style: smallTitleStyle.copyWith(color: colorWhite),
                  ),
                  Text(
                    user?.name ?? "Username",
                    style: smallTitleStyle.copyWith(color: colorWhite),
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  Get.to(const NotificationScreen());
                },
                icon: SvgPicture.asset(notification),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          SearchTextField(
            controller: _searchController,
            onSearch: _onSearch,
            hintText: LocalTextController.text?.terms?.searchForJobs ??
                "Search for jobs",
            greyColor: true,
          ),
        ],
      ),
    );
  }

  Widget sectionTitle(
      {required String title, required VoidCallback onViewAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: smallTitleStyle),
        TextButton(
          onPressed: onViewAll,
          child: Text(
            "View All",
            style: appSubTextStyle.copyWith(
              color: colorPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget jobCategories() {
    return GetBuilder<CategoriesController>(
      builder: (controller) {
        if (controller.loading) {
          return const CenterProgressIndicator();
        } else if (controller.categories?.isEmpty ?? true) {
          return Center(child: Text('Nothing found!'));
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: controller.categories!
                  .take(5)
                  .map(
                    (category) => CategoryItemCard(
                      iconImage: category.iconUrl ?? '',
                      title: category.name ?? "Category",
                      onTap: () {
                        Get.to(
                          () => NavExploreScreen(
                            selectedCategory: category.id.toString(),
                          ),
                        );
                      },
                    ),
                  )
                  .toList(),
            ),
          );
        }
      },
    );
  }

  Widget companies() {
    return GetBuilder<CompaniesController>(
      builder: (controller) {
        if (controller.loading) {
          return const CenterProgressIndicator();
        } else if (controller.featuredCompanies?.isEmpty ?? true) {
          return const Center(child: Text('Nothing found!'));
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: controller.featuredCompanies!
                  .take(5)
                  .map(
                    (company) => CompanyItemCard(
                      logo: company.logo ?? '',
                      name: company.name ?? "Company",
                      onTap: () {
                        Get.to(
                          () => NavExploreScreen(
                            selectedCompany: company.id.toString(),
                          ),
                        );
                      },
                    ),
                  )
                  .toList(),
            ),
          );
        }
      },
    );
  }

  Widget recommendedJobs() {
    return GetBuilder<PopularJobsController>(
      builder: (controller) {
        if (controller.loading) {
          return const CenterProgressIndicator();
        } else if (controller.jobList?.isEmpty ?? true) {
          return Center(child: Text('Nothing found!'));
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: controller.jobList!
                  .map(
                    (job) => Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: JobCardDetailed(job: job),
                    ),
                  )
                  .toList(),
            ),
          );
        }
      },
    );
  }

  Widget latestJobs() {
    return GetBuilder<LatestJobsController>(
      builder: (controller) {
        if (controller.loading && controller.jobList!.isEmpty) {
          return const CenterProgressIndicator();
        } else if (controller.jobList?.isEmpty ?? true) {
          return const Center(child: Text('Nothing found!'));
        } else {
          return Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height *
                    0.6, // Adjust the height as needed
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: controller.jobList!.length,
                  separatorBuilder: (context, index) => SizedBox(height: 10.h),
                  itemBuilder: (context, index) {
                    return JobCardDetailed(job: controller.jobList![index]);
                  },
                ),
              ),
              if (controller.hasMoreData)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      controller.getLatestJobs(loadMore: true);
                    },
                    child: controller.loading
                        ? const CircularProgressIndicator()
                        : const Text('Load More'),
                  ),
                ),
            ],
          );
        }
      },
    );
  }
}
