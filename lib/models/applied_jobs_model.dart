class AppliedJobsModel {
  bool? success;
  String? message;
  Data? data;

  AppliedJobsModel({this.success, this.message, this.data});

  AppliedJobsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<JobModel>? jobList;

  Data({this.jobList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['job_list'] != null) {
      jobList = <JobModel>[];
      json['job_list'].forEach((v) {
        jobList!.add(JobModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (jobList != null) {
      data['job_list'] = jobList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JobModel {
  int? jobId;
  String? jobTitle;
  String? salary;
  int? companyId;
  String? companyName;
  String? companyLogo;
  int? applicantId;
  String? message;
  String? attachmentUrl;

  JobModel(
      {this.jobId,
      this.jobTitle,
      this.salary,
      this.companyId,
      this.companyName,
      this.companyLogo,
      this.applicantId,
      this.message,
      this.attachmentUrl});

  JobModel.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    jobTitle = json['job_title'];
    salary = json['salary'];
    companyId = json['company_id'];
    companyName = json['company_name'];
    companyLogo = json['company_logo'];
    applicantId = json['applicant_id'];
    message = json['message'];
    attachmentUrl = json['attachment_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['job_id'] = jobId;
    data['job_title'] = jobTitle;
    data['salary'] = salary;
    data['company_id'] = companyId;
    data['company_name'] = companyName;
    data['company_logo'] = companyLogo;
    data['applicant_id'] = applicantId;
    data['message'] = message;
    data['attachment_url'] = attachmentUrl;
    return data;
  }
}
