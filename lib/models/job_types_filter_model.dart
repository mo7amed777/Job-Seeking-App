class JobTypesFilterModel {
  bool? success;
  String? message;
  JobTypesList? jobTypesList;

  JobTypesFilterModel({this.success, this.message, this.jobTypesList});

  JobTypesFilterModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    jobTypesList = json['data'] != null ? JobTypesList.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (jobTypesList != null) {
      data['data'] = jobTypesList!.toJson();
    }
    return data;
  }
}

class JobTypesList {
  List<JobType>? jobTypes;

  JobTypesList({this.jobTypes});

  JobTypesList.fromJson(Map<String, dynamic> json) {
    if (json['jobTypes'] != null) {
      jobTypes = <JobType>[];
      json['jobTypes'].forEach((v) {
        jobTypes!.add(JobType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (jobTypes != null) {
      data['jobTypes'] = jobTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JobType {
  String? value;
  String? text;

  JobType({this.value, this.text});

  JobType.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['text'] = text;
    return data;
  }
}
