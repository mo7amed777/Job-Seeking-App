class SliderModel {
  bool? success;
  String? message;
  List<Slide>? slides;

  SliderModel({this.success, this.message, this.slides});

  SliderModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      slides = <Slide>[];
      json['data'].forEach((v) {
        slides!.add(Slide.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (slides != null) {
      data['data'] = slides!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Slide {
  int? id;
  String? image;
  String? description;
  String? position;
  String? status;

  Slide({this.id, this.image, this.description, this.position, this.status});

  Slide.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    description = json['description'];
    position = json['position'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['description'] = description;
    data['position'] = position;
    data['status'] = status;
    return data;
  }
}
