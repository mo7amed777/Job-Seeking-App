class CategoriesModel {
  bool? success;
  String? message;
  CategoryList? categoryList;

  CategoriesModel(
      {this.success,
      this.message,
      this.categoryList}); // Add categoryFilterList

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    categoryList =
        json['data'] != null ? CategoryList.fromJson(json['data']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (categoryList != null) {
      data['data'] = categoryList!.toJson();
    }

    return data;
  }
}

class CategoryList {
  List<Category>? categories;

  CategoryList({this.categories});

  CategoryList.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Category>[];
      json['categories'].forEach((v) {
        categories!.add(Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? iconUrl;
  List<String>? skills;
  String? status;
  String? createdAt;
  String? updatedAt;

  Category(
      {this.id,
      this.name,
      this.iconUrl,
      this.skills,
      this.status,
      this.createdAt,
      this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    iconUrl = json['icon_url'];
    skills = json['skills'].cast<String>();
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['icon_url'] = iconUrl;
    data['skills'] = skills;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
