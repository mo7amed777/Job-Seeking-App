class CompaniesModel {
  bool? success;
  String? message;
  CompanyList? companyList;

  CompaniesModel({this.success, this.message, this.companyList});

  CompaniesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    companyList = json['data'] != null ? CompanyList.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (companyList != null) {
      data['data'] = companyList!.toJson();
    }
    return data;
  }
}

class CompanyList {
  List<Company>? companies;

  CompanyList({this.companies});

  CompanyList.fromJson(Map<String, dynamic> json) {
    if (json['companies'] != null) {
      companies = <Company>[];
      json['companies'].forEach((v) {
        companies!.add(Company.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (companies != null) {
      data['companies'] = companies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Company {
  int? id;
  String? name;
  String? logo;

  Company({this.id, this.name, this.logo});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['logo'] = logo;
    return data;
  }
}
