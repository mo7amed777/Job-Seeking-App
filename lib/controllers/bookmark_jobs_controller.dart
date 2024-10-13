import 'package:get/get.dart';
import 'package:job_nect/models/applied_jobs_model.dart';
import 'package:job_nect/models/bookmark_jobs_model.dart';
import 'package:job_nect/services/urls.dart';
import 'package:job_nect/utils/ui_helper.dart';

import '../services/api_caller.dart';

class BookmarkedJobsController extends GetxController {
  bool loading = false;
  BookmarkJobsModel bookmarkJobsModel = BookmarkJobsModel();
  List<JobModel>? get jobList => bookmarkJobsModel.bookmarkedJobs;

  Future<void> getBookmarkedJobs() async {
    loading = true;
    update();
    final response = await ApiCaller().getRequest(Urls.bookmarkedJobs);
    if (response.isSuccess) {
      bookmarkJobsModel = BookmarkJobsModel.fromJson(response.responseData);
    } else {}
    loading = false;
    update();
  }

  // New method to bookmark a job
  Future<bool> bookmarkJob(int? jobId) async {
    if (jobId == null) return false;

    loading = true;
    update();

    // Prepare data for the POST request
    final response = await ApiCaller().postRequest(Urls.bookmarkedStore, body: {
      'job_id': jobId.toString(),
    });

    var responseData = await response.responseData;
    if (response.isSuccess && responseData['success'] == true) {
      update();
      UiHelper.showSnackBar(text: response.responseData['message']);
      return true;
    } else {
      UiHelper.showSnackBar(
          text: response.errorMessage ?? 'An unknown error occurred',
          error: true);

      update();
      return false;
    }
  }
}
