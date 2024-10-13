class EducationLevelsModel {
  bool? success;
  String? message;
  List<String>? educations;

  EducationLevelsModel({this.success, this.message, this.educations});

  EducationLevelsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    educations = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['data'] = educations;
    return data;
  }
}
