class JobTypesModel {
  bool? success;
  String? message;
  List<String>? jobTypes;

  JobTypesModel({this.success, this.message, this.jobTypes});

  JobTypesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    jobTypes = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['data'] = jobTypes;
    return data;
  }
}
