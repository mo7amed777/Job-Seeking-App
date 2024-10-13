import 'applied_jobs_model.dart';

class BookmarkJobsModel {
  bool? success;
  String? message;
  List<JobModel>? bookmarkedJobs;

  BookmarkJobsModel({this.success, this.message, this.bookmarkedJobs});

  BookmarkJobsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      bookmarkedJobs = <JobModel>[];
      json['data'].forEach((v) {
        bookmarkedJobs!.add(JobModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.bookmarkedJobs != null) {
      data['data'] = this.bookmarkedJobs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class JobModel {
//   int? userId;
//   int? jobId;
//   String? jobTitle;
//   String? category;
//   List<String>? types;
//   String? salary;
//   int? vacancy;
//   String? jobStatus;
//   int? companyId;
//   String? companyName;
//   String? companyLogo;
//
//   JobModel(
//       {this.userId,
//         this.jobId,
//         this.jobTitle,
//         this.category,
//         this.types,
//         this.salary,
//         this.vacancy,
//         this.jobStatus,
//         this.companyId,
//         this.companyName,
//         this.companyLogo});
//
//   JobModel.fromJson(Map<String, dynamic> json) {
//     userId = json['user_id'];
//     jobId = json['job_id'];
//     jobTitle = json['job_title'];
//     category = json['category'];
//     types = json['types'].cast<String>();
//     salary = json['salary'];
//     vacancy = json['vacancy'];
//     jobStatus = json['job_status'];
//     companyId = json['company_id'];
//     companyName = json['company_name'];
//     companyLogo = json['company_logo'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['user_id'] = this.userId;
//     data['job_id'] = this.jobId;
//     data['job_title'] = this.jobTitle;
//     data['category'] = this.category;
//     data['types'] = this.types;
//     data['salary'] = this.salary;
//     data['vacancy'] = this.vacancy;
//     data['job_status'] = this.jobStatus;
//     data['company_id'] = this.companyId;
//     data['company_name'] = this.companyName;
//     data['company_logo'] = this.companyLogo;
//     return data;
//   }
// }
