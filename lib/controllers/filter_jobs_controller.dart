import 'package:get/get.dart';
import 'package:job_nect/models/latest_jobs_model.dart';
import 'package:job_nect/services/urls.dart';
import '../models/job_model.dart';
import '../services/api_caller.dart';

class FilterJobsController extends GetxController {
  bool loading = false;
  LatestJobsModel latestJobsModel = LatestJobsModel();
  List<Job> jobs = []; // List to store jobs
  int currentPage = 1; // Page number for pagination
  bool hasMoreData = true; // Flag to check if more data can be fetched

  List<Job>? get jobList => jobs;

  @override
  void onInit() {
    super.onInit();
    // Fetch the first page when the controller is initialized
    Future.delayed(Duration(milliseconds: 100), () {
      getFilterJobs();
    });
  }

  Future<void> getFilterJobs({
    String? query,
    String? category,
    String? company,
    String? jobType,
    String? skill,
    bool loadMore = false,
  }) async {
    if (loading || !hasMoreData) return; // Prevent multiple requests

    loading = true;
    update(); // Update UI to show loading

    // If not loading more, reset the job list and current page
    if (!loadMore) {
      jobs.clear();
      currentPage = 1;
    }

    // Build the URL with pagination and query parameters
    String url = '${Urls.filterJobs}?page=$currentPage';

    // Append filters as query parameters if they are provided
    if (query != null && query.isNotEmpty) url += '&keyword=$query';
    if (category != null && category.isNotEmpty) url += '&category=$category';
    if (company != null && company.isNotEmpty) url += '&company=$company';
    if (jobType != null && jobType.isNotEmpty) url += '&jobType=$jobType';
    if (skill != null && skill.isNotEmpty) url += '&skill=$skill';

    try {
      final response = await ApiCaller().getRequest(url);

      if (response.isSuccess) {
        LatestJobsModel fetchedJobs =
            LatestJobsModel.fromJson(response.responseData);

        // Append new data to existing jobs when loadMore is true
        if (loadMore) {
          jobs.addAll(fetchedJobs.jobs?.jobs ?? []);
        } else {
          jobs = fetchedJobs.jobs?.jobs ?? [];
        }

        // Check if there's more data to load
        hasMoreData = fetchedJobs.jobs?.jobs?.isNotEmpty ?? false;

        // Increment page number if there is more data
        if (hasMoreData) {
          currentPage++;
        }
      } else {
        // Handle the error response
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Request error: $e');
    }

    loading = false;
    update(); // Update UI after loading is done
  }

  // Method to set the query and trigger job fetching
  void setQuery(String query) {
    // Call getFilterJobs with the new query
    getFilterJobs(query: query);
  }
}
