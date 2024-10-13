class DesignationModel {
  bool? success;
  String? message;
  List<Designation>? designations;

  DesignationModel({this.success, this.message, this.designations});

  DesignationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      designations = <Designation>[];
      json['data'].forEach((v) {
        designations!.add(Designation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (designations != null) {
      data['data'] = designations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Designation {
  int? id;
  String? name;

  Designation({this.id, this.name});

  Designation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
