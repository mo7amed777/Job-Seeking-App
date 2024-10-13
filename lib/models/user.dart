import 'package:eservices/models/designation_model.dart';

class User {
  int? userId;
  String? name;
  String? email;
  String? phone;
  String? gender;
  String? dateOfBirth;
  String? address;
  String? about;
  String? profilePhoto;
  String? coverImage;
  Designation? designation;

  User(
      {this.userId,
      this.name,
      this.email,
      this.phone,
      this.gender,
      this.dateOfBirth,
      this.address,
      this.about,
      this.profilePhoto,
      this.coverImage,
      this.designation});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    address = json['address'];
    about = json['about'];
    profilePhoto = json['profile_photo'];
    coverImage = json['cover_image'];
    designation = json['designation'] != null
        ? Designation.fromJson(json['designation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['gender'] = gender;
    data['date_of_birth'] = dateOfBirth;
    data['address'] = address;
    data['about'] = about;
    data['profile_photo'] = profilePhoto;
    data['cover_image'] = coverImage;
    if (designation != null) {
      data['designation'] = designation!.toJson();
    }
    return data;
  }
}
// class User {
//   int? id;
//   String? name;
//   String? email;
//   String? avatar;
//   String? coverAvatar;
//   String? designation;
//   String? dob;
//   String? gender;
//   String? phone;
//   List<String>? skills;
//   int? salary;
//   List<Experience>? experience;
//   String? description;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//
//   User(
//       {this.id,
//       this.name,
//       this.email,
//       this.avatar,
//       this.coverAvatar,
//       this.designation,
//       this.dob,
//       this.gender,
//       this.phone,
//       this.skills,
//       this.salary,
//       this.experience,
//       this.description,
//       this.status,
//       this.createdAt,
//       this.updatedAt});
//
//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     avatar = json['avatar'];
//     coverAvatar = json['cover_avatar'];
//     designation = json['designation'];
//     dob = json['dob'];
//     gender = json['gender'];
//     phone = json['phone'];
//     skills = json['skills'].cast<String>();
//     salary = json['salary'];
//     if (json['experience'] != null) {
//       experience = <Experience>[];
//       json['experience'].forEach((v) {
//         experience!.add(Experience.fromJson(v));
//       });
//     }
//     description = json['description'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     data['email'] = email;
//     data['avatar'] = avatar;
//     data['cover_avatar'] = coverAvatar;
//     data['designation'] = designation;
//     data['dob'] = dob;
//     data['gender'] = gender;
//     data['phone'] = phone;
//     data['skills'] = skills;
//     data['salary'] = salary;
//     if (experience != null) {
//       data['experience'] = experience!.map((v) => v.toJson()).toList();
//     }
//     data['description'] = description;
//     data['status'] = status;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     return data;
//   }
// }
//
// class Experience {
//   int? id;
//   int? applicantId;
//   String? employer;
//   String? business;
//   String? designation;
//   String? department;
//   String? responsibilities;
//   String? location;
//   String? startDate;
//   String? endDate;
//   String? jobType;
//   int? status;
//   String? createdAt;
//   String? updatedAt;
//
//   Experience(
//       {this.id,
//       this.applicantId,
//       this.employer,
//       this.business,
//       this.designation,
//       this.department,
//       this.responsibilities,
//       this.location,
//       this.startDate,
//       this.endDate,
//       this.jobType,
//       this.status,
//       this.createdAt,
//       this.updatedAt});
//
//   Experience.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     applicantId = json['applicant_id'];
//     employer = json['employer'];
//     business = json['business'];
//     designation = json['designation'];
//     department = json['department'];
//     responsibilities = json['responsibilities'];
//     location = json['location'];
//     startDate = json['start_date'];
//     endDate = json['end_date'];
//     jobType = json['job_type'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['applicant_id'] = applicantId;
//     data['employer'] = employer;
//     data['business'] = business;
//     data['designation'] = designation;
//     data['department'] = department;
//     data['responsibilities'] = responsibilities;
//     data['location'] = location;
//     data['start_date'] = startDate;
//     data['end_date'] = endDate;
//     data['job_type'] = jobType;
//     data['status'] = status;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     return data;
//   }
// }

// class User {
//   int? id;
//   String? name;
//   String? email;
//   String? designation;
//   String? dob;
//   String? gender;
//   String? phone;
//   String? photo;
//   String? skills;
//   String? salary;
//   String? experience;
//   String? description;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//
//   User(
//       {this.id,
//       this.name,
//       this.email,
//       this.designation,
//       this.dob,
//       this.gender,
//       this.phone,
//       this.photo,
//       this.skills,
//       this.salary,
//       this.experience,
//       this.description,
//       this.status,
//       this.createdAt,
//       this.updatedAt});
//
//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     designation = json['designation'];
//     dob = json['dob'];
//     gender = json['gender'];
//     phone = json['phone'];
//     photo = json['photo'];
//     skills = json['skills'];
//     salary = json['salary'];
//     experience = json['experience'];
//     description = json['description'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     data['email'] = email;
//     data['designation'] = designation;
//     data['dob'] = dob;
//     data['gender'] = gender;
//     data['phone'] = phone;
//     data['photo'] = photo;
//     data['skills'] = skills;
//     data['salary'] = salary;
//     data['experience'] = experience;
//     data['description'] = description;
//     data['status'] = status;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     return data;
//   }
// }
