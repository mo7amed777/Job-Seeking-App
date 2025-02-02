class JobLevelsModel {
  bool? success;
  String? message;
  List<String>? jobLevels;

  JobLevelsModel({this.success, this.message, this.jobLevels});

  JobLevelsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    jobLevels = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['data'] = jobLevels;
    return data;
  }
}
