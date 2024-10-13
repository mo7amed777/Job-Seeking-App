import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eservices/screens/filter_screen.dart';
import '../controllers/bottom_nav_controller.dart';
import '../controllers/filter_jobs_controller.dart';
import '../controllers/local_text_controller.dart';
import '../models/app_text_model.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/center_progress_indicator.dart';
import '../widgets/job_card_detailed.dart';
import '../widgets/search_text_field.dart';
import 'package:eservices/widgets/text_back_button.dart';

class NavExploreScreen extends StatefulWidget {
  final String? query;
  final String? selectedCategory; // Accept selectedCategory
  final String? selectedCompany; // Accept selectedCategory
  final String? selectedJobType;
  final String? selectedSkill;

  const NavExploreScreen({
    Key? key,
    this.query,
    this.selectedCategory, // Initialize selectedCategory
    this.selectedCompany, // Initialize selectedCategory
    this.selectedJobType,
    this.selectedSkill,
  }) : super(key: key);

  @override
  State<NavExploreScreen> createState() => _NavExploreScreenState();
}

class _NavExploreScreenState extends State<NavExploreScreen> {
  late TextEditingController _searchController;
  late FilterJobsController _filterJobsController;
  Terms? terms = LocalTextController.terms;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.query ?? '');
    _filterJobsController = Get.put(FilterJobsController());

    _fetchJobs();
  }

  void _fetchJobs() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _filterJobsController.getFilterJobs(
        query: _searchController.text.trim(),
        category: widget.selectedCategory, // Pass the selectedCategory here
        company: widget.selectedCompany, // Pass the selectedCategory here
        jobType: widget.selectedJobType,
        skill: widget.selectedSkill,
      );
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    Get.delete<FilterJobsController>();
    super.dispose();
  }

  void _onSearch() {
    // Use the same approach here to prevent triggering setState during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchJobs();
      // Optionally, you can scroll to top or provide feedback to user
    });
  }

  @override
  Widget build(BuildContext context) {
    Terms? terms = LocalTextController.terms;

    return WillPopScope(
      onWillPop: () async {
        Get.find<BottomNavController>().backToHome();
        return false;
      },
      child: Scaffold(
        appBar: appBar(),
        body: SafeArea(
          child: Column(
            children: [
              appBarSection(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(terms?.foundJobs ?? "Found Jobs",
                          style: smallTitleStyle),
                      filterJobs(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: TextBackButton(text: terms?.foundJobs ?? "Found Jobs"),
    );
  }

  // Widget filterJobs() {
  //   return GetBuilder<FilterJobsController>(builder: (controller) {
  //     if (controller.loading) {
  //       return const Center(child: CircularProgressIndicator());
  //     }

  //     return Visibility(
  //       visible: controller.loading == false,
  //       replacement: const CenterProgressIndicator(),
  //       child: Visibility(
  //         visible: controller.jobList?.isNotEmpty ?? false,
  //         replacement: const Center(child: Text('Nothing found!')),
  //         child: Expanded(
  //           child: ListView.separated(
  //             // Removed shrinkWrap to allow ListView to take available space
  //             primary: false,
  //             itemCount: controller.jobList?.length ?? 0,
  //             padding: EdgeInsets.only(top: 10.h),
  //             separatorBuilder: (c, i) => SizedBox(height: 6.h),
  //             itemBuilder: (context, index) {
  //               final job = controller.jobList?[index];
  //               return JobCardDetailed(job: job);
  //             },
  //           ),
  //         ),
  //       ),
  //     );
  //   });
  // }

  Widget filterJobs() {
    return GetBuilder<FilterJobsController>(builder: (controller) {
      // Check if jobList is null or empty
      if (controller.loading &&
          (controller.jobList == null || controller.jobList!.isEmpty)) {
        return const Center(child: CircularProgressIndicator());
      } else if (controller.jobList == null || controller.jobList!.isEmpty) {
        return const Center(child: Text('Nothing found!'));
      } else {
        return Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height *
                  0.6, // Adjust height as needed
              child: ListView.separated(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: controller
                    .jobList!.length, // Since jobList is non-null here, use !
                padding: const EdgeInsets.only(top: 10),
                separatorBuilder: (context, index) => const SizedBox(height: 6),
                itemBuilder: (context, index) {
                  final job = controller
                      .jobList![index]; // Safely access jobList with !
                  return JobCardDetailed(job: job);
                },
              ),
            ),
            if (controller.hasMoreData &&
                !controller.loading) // Show 'Load More' if more data exists
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Call load more when the button is pressed
                    controller.getFilterJobs(loadMore: true);
                  },
                  child: const Text('Load More'),
                ),
              ),
            if (controller.loading &&
                controller
                    .jobList!.isNotEmpty) // Show a spinner when loading more
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
          ],
        );
      }
    });
  }

  Widget appBarSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: colorPrimary,
      child: Column(
        children: [
          SearchTextField(
            controller: _searchController,
            onSearch: _onSearch,
            hintText: LocalTextController.text?.terms?.searchForJobs ??
                "Search for jobs",
            onTapFilter: () async {
              final filters = await Get.to(() => FilterScreen(), arguments: {
                'categoryId': widget.selectedCategory,
              });
              if (filters != null) {
                setState(() {
                  _filterJobsController.getFilterJobs(
                    query: _searchController.text.trim(),
                    category: filters['category'] ??
                        widget
                            .selectedCategory, // Default to empty string if null
                    jobType: filters['jobType'] ??
                        '', // Default to empty string if null
                    skill: filters['skill'] ??
                        '', // Default to empty string if null
                  );
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
