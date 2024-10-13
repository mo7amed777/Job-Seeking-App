import 'package:get/get.dart';
import 'package:job_nect/models/latest_jobs_model.dart';
import 'package:job_nect/services/urls.dart';
import '../models/job_model.dart';
import '../services/api_caller.dart';

class LatestJobsController extends GetxController {
  bool loading = false;
  LatestJobsModel latestJobsModel = LatestJobsModel();
  List<Job> jobs = [];
  int currentPage = 1;
  bool hasMoreData = true;

  List<Job>? get jobList => jobs;

  @override
  void onInit() {
    super.onInit();
    // Add a delay to ensure network is ready
    Future.delayed(Duration(milliseconds: 100), () {
      getLatestJobs(); // Fetch the first page when the controller is initialized
    });
  }

  Future<void> getLatestJobs({bool loadMore = false}) async {
    if (loading || !hasMoreData) return;

    loading = true;
    update();

    final url = '${Urls.latestJobs}?page=$currentPage';

    try {
      final response = await ApiCaller().getRequest(url);

      if (response.isSuccess) {
        LatestJobsModel fetchedJobs =
            LatestJobsModel.fromJson(response.responseData);

        if (loadMore) {
          // Append new data to existing jobs
          jobs.addAll(fetchedJobs.jobs?.jobs ?? []);
        } else {
          // Replace existing jobs with new data
          jobs = fetchedJobs.jobs?.jobs ?? [];
        }

        // Determine if there are more pages to load
        hasMoreData = fetchedJobs.jobs?.jobs?.isNotEmpty ?? false;

        // Increment page number if more data is available
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
    update();
  }
}
