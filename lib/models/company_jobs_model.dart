import 'job_model.dart';

class CompanyJobsModel {
  bool? success;
  String? message;
  Data? data;

  CompanyJobsModel({this.success, this.message, this.data});

  CompanyJobsModel.fromJson(Map<String, dynamic> json) {
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
  List<Job>? jobs;

  Data({this.jobs});

  Data.fromJson(Map<String, dynamic> json) {
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

// class Job {
//   int? id;
//   String? title;
//   String? category;
//   List<String>? skills;
//   List<String>? jobType;
//   int? companyId;
//   String? company;
//   String? companyLogo;
//   String? description;
//   String? startDate;
//   String? endDate;
//   String? salary;
//   int? vacancy;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//
//   Job(
//       {this.id,
//         this.title,
//         this.category,
//         this.skills,
//         this.jobType,
//         this.companyId,
//         this.company,
//         this.companyLogo,
//         this.description,
//         this.startDate,
//         this.endDate,
//         this.salary,
//         this.vacancy,
//         this.status,
//         this.createdAt,
//         this.updatedAt});
//
//   Job.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     category = json['category'];
//     skills = json['skills'].cast<String>();
//     jobType = json['job_type'].cast<String>();
//     companyId = json['company_id'];
//     company = json['company'];
//     companyLogo = json['company_logo'];
//     description = json['description'];
//     startDate = json['start_date'];
//     endDate = json['end_date'];
//     salary = json['salary'];
//     vacancy = json['vacancy'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['category'] = this.category;
//     data['skills'] = this.skills;
//     data['job_type'] = this.jobType;
//     data['company_id'] = this.companyId;
//     data['company'] = this.company;
//     data['company_logo'] = this.companyLogo;
//     data['description'] = this.description;
//     data['start_date'] = this.startDate;
//     data['end_date'] = this.endDate;
//     data['salary'] = this.salary;
//     data['vacancy'] = this.vacancy;
//     data['status'] = this.status;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
