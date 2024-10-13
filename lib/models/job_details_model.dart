// To parse this JSON data, do
//
//     final jobDetailsModel = jobDetailsModelFromJson(jsonString);

import 'job_model.dart';

class JobDetailsModel {
  bool? success;
  String? message;
  Data? data;

  JobDetailsModel({this.success, this.message, this.data});

  JobDetailsModel.fromJson(Map<String, dynamic> json) {
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
  Job? job;

  Data({this.job});

  Data.fromJson(Map<String, dynamic> json) {
    job = json['job'] != null ? Job.fromJson(json['job']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (job != null) {
      data['job'] = job!.toJson();
    }
    return data;
  }
}
//
// JobDetailsModel jobDetailsModelFromJson(String str) => JobDetailsModel.fromJson(json.decode(str));
//
// String jobDetailsModelToJson(JobDetailsModel data) => json.encode(data.toJson());

// class JobDetailsModel {
//   bool? success;
//   String? message;
//   Data? data;
//
//   JobDetailsModel({
//     this.success,
//     this.message,
//     this.data,
//   });
//
//   factory JobDetailsModel.fromJson(Map<String, dynamic> json) => JobDetailsModel(
//         success: json["success"],
//         message: json["message"],
//         data: json["data"] == null ? null : Data.fromJson(json["data"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "message": message,
//         "data": data?.toJson(),
//       };
// }
//
// class Data {
//   Job? job;
//
//   Data({
//     this.job,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         job: json["job"] == null ? null : Job.fromJson(json["job"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "job": job?.toJson(),
//       };
// }

// class Job {
//   int? id;
//   String? title;
//   String? category;
//   List<String>? skills;
//   List<String>? jobType;
//   int? companyId;
//   String? company;
//   String? description;
//   DateTime? startDate;
//   DateTime? endDate;
//   String? salary;
//   int? vacancy;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//
//   Job({
//     this.id,
//     this.title,
//     this.category,
//     this.skills,
//     this.jobType,
//     this.companyId,
//     this.company,
//     this.description,
//     this.startDate,
//     this.endDate,
//     this.salary,
//     this.vacancy,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory Job.fromJson(Map<String, dynamic> json) => Job(
//         id: json["id"],
//         title: json["title"],
//         category: json["category"],
//         skills: json["skills"] == null ? [] : List<String>.from(json["skills"]!.map((x) => x)),
//         jobType: json["job_type"] == null ? [] : List<String>.from(json["job_type"]!.map((x) => x)),
//         companyId: json["company_id"],
//         company: json["company"],
//         description: json["description"],
//         startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
//         endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
//         salary: json["salary"],
//         vacancy: json["vacancy"],
//         status: json["status"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "title": title,
//         "category": category,
//         "skills": skills == null ? [] : List<dynamic>.from(skills!.map((x) => x)),
//         "job_type": jobType == null ? [] : List<dynamic>.from(jobType!.map((x) => x)),
//         "company_id": companyId,
//         "company": company,
//         "description": description,
//         "start_date":
//             "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
//         "end_date":
//             "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
//         "salary": salary,
//         "vacancy": vacancy,
//         "status": status,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//       };
// }
