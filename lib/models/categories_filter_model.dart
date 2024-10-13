class CategoriesFilterModel {
  bool? success;
  String? message;
  CategoryFilterList? categoryFilterList; // Add this line

  CategoriesFilterModel(
      {this.success,
      this.message,
      this.categoryFilterList}); // Add categoryFilterList

  CategoriesFilterModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    categoryFilterList =
        json['data'] != null ? CategoryFilterList.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;

    if (categoryFilterList != null) {
      // Add this block
      data['data'] = categoryFilterList!.toJson();
    }
    return data;
  }
}

class CategoryFilterList {
  List<CategoryFilter>? categoriesFilter;

  CategoryFilterList({this.categoriesFilter});

  CategoryFilterList.fromJson(Map<String, dynamic> json) {
    if (json['categoriesFilter'] != null) {
      categoriesFilter = <CategoryFilter>[];
      json['categoriesFilter'].forEach((v) {
        categoriesFilter!.add(CategoryFilter.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (categoriesFilter != null) {
      data['categoriesFilter'] =
          categoriesFilter!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryFilter {
  // New class for individual category filter
  String? value;
  String? text;

  CategoryFilter({this.value, this.text});

  CategoryFilter.fromJson(Map<String, dynamic> json) {
    value = json['id']?.toString();
    text = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = value;
    data['name'] = text;
    return data;
  }
}
