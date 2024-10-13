import 'job_model.dart';

class LatestJobsModel {
  bool? success;
  String? message;
  JobList? jobs;

  LatestJobsModel({this.success, this.message, this.jobs});

  LatestJobsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    jobs = json['data'] != null ? JobList.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (jobs != null) {
      data['data'] = jobs!.toJson();
    }
    return data;
  }
}

class JobList {
  List<Job>? jobs;

  JobList({this.jobs});

  JobList.fromJson(Map<String, dynamic> json) {
    if (json['jobs'] != null) {
      jobs = <Job>[];
      json['jobs'].forEach((v) {
        jobs!.add(Job.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (jobs != null) {
      data['jobs'] = jobs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
