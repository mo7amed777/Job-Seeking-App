class LanguagesModel {
  bool? success;
  String? message;
  List<Language>? languages;

  LanguagesModel({this.success, this.message, this.languages});

  LanguagesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      languages = <Language>[];
      json['data'].forEach((v) {
        languages!.add(Language.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (languages != null) {
      data['data'] = languages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Language {
  int? id;
  String? name;
  String? code;
  String? textDirection;
  int? status;

  Language({this.id, this.name, this.code, this.textDirection, this.status});

  Language.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    textDirection = json['text_direction'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['text_direction'] = textDirection;
    data['status'] = status;
    return data;
  }
}
