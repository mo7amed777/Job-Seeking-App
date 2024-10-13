class Job {
  int? id;
  String? title;
  String? category;
  List<String>? skills;
  List<String>? jobType;
  int? companyId;
  String? company;
  String? companyLogo;
  String? description;
  String? startDate;
  String? endDate;
  String? salary;
  int? vacancy;
  String? status;
  String? createdAt;
  String? updatedAt;

  Job(
      {this.id,
      this.title,
      this.category,
      this.skills,
      this.jobType,
      this.companyId,
      this.company,
      this.companyLogo,
      this.description,
      this.startDate,
      this.endDate,
      this.salary,
      this.vacancy,
      this.status,
      this.createdAt,
      this.updatedAt});

  Job.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    category = json['category'];
    skills = json['skills'].cast<String>();
    jobType = json['job_type'].cast<String>();
    companyId = json['company_id'];
    company = json['company'];
    companyLogo = json['company_logo'];
    description = json['description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    salary = json['salary'];
    vacancy = json['vacancy'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['category'] = category;
    data['skills'] = skills;
    data['job_type'] = jobType;
    data['company_id'] = companyId;
    data['company'] = company;
    data['company_logo'] = companyLogo;
    data['description'] = description;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['salary'] = salary;
    data['vacancy'] = vacancy;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
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
