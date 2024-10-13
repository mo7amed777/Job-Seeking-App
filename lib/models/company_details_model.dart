class CompanyDetailsModel {
  bool? success;
  String? message;
  Data? data;

  CompanyDetailsModel({this.success, this.message, this.data});

  CompanyDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Company? company;

  Data({this.company});

  Data.fromJson(Map<String, dynamic> json) {
    company = json['company'] != null ? Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (company != null) {
      data['company'] = company!.toJson();
    }
    return data;
  }
}

class Company {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? address;
  String? logo;
  String? banner;
  String? rating;
  String? user;
  String? status;
  String? createdAt;
  String? updatedAt;

  Company(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.address,
      this.logo,
      this.banner,
      this.rating,
      this.user,
      this.status,
      this.createdAt,
      this.updatedAt});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    address = json['address'];
    logo = json['logo'];
    banner = json['banner'];
    rating = json['rating'];
    user = json['user'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['address'] = address;
    data['logo'] = logo;
    data['banner'] = banner;
    data['rating'] = rating;
    data['user'] = user;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
