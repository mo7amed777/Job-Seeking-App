class SkillsModel {
  bool? success;
  String? message;
  SkillsList? skillsList;

  SkillsModel({this.success, this.message, this.skillsList});

  SkillsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    skillsList = json['data'] != null ? SkillsList.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (skillsList != null) {
      data['data'] = skillsList!.toJson();
    }
    return data;
  }
}

class SkillsList {
  List<Skill>? skills;

  SkillsList({this.skills});

  SkillsList.fromJson(Map<String, dynamic> json) {
    if (json['skills'] != null) {
      skills = <Skill>[];
      json['skills'].forEach((v) {
        skills!.add(Skill.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (skills != null) {
      data['skills'] = skills!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Skill {
  String? value;
  String? text;

  Skill({this.value, this.text});

  Skill.fromJson(Map<String, dynamic> json) {
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
