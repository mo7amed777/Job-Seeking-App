import 'designation_model.dart';

class ResumeModel {
  bool? success;
  String? message;
  Resume? resume;

  ResumeModel({this.success, this.message, this.resume});

  ResumeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    resume = json['data'] != null ? Resume.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (resume != null) {
      data['data'] = resume!.toJson();
    }
    return data;
  }
}

class Resume {
  int? userId;
  String? name;
  String? email;
  String? phone;
  String? dateOfBirth;
  String? gender;
  String? address;
  String? about;
  String? profilePhoto;
  String? coverImage;
  Designation? designation;
  int? applicantId;
  String? fatherName;
  String? motherName;
  String? nationality;
  int? bloodGroup;
  String? maritalStatus;
  String? weight;
  String? height;
  String? alternativeEmail;
  String? secondaryMobile;
  String? emergencyContact;
  String? presentAddress;
  String? permanentAddress;
  int? presentSalary;
  int? expectedSalary;
  String? expectedJobType;
  String? expectedJobLevel;
  List<String>? preferredJobLocations;
  List<String>? preferredOrganizationTypes;
  List<PreferredJobCategories>? preferredJobCategories;
  List<String>? skills;
  String? careerObjective;
  String? careerSummary;
  String? specialQualification;
  List<String>? keywords;
  String? disability;
  List<Educations>? educations;
  List<Experiences>? experiences;
  List<Certifications>? certifications;
  List<Trainings>? trainings;
  List<References>? references;
  List<ResumeLanguages>? resumeLanguages;

  Resume(
      {this.userId,
      this.name,
      this.email,
      this.phone,
      this.dateOfBirth,
      this.gender,
      this.address,
      this.about,
      this.profilePhoto,
      this.coverImage,
      this.designation,
      this.applicantId,
      this.fatherName,
      this.motherName,
      this.nationality,
      this.bloodGroup,
      this.maritalStatus,
      this.weight,
      this.height,
      this.alternativeEmail,
      this.secondaryMobile,
      this.emergencyContact,
      this.presentAddress,
      this.permanentAddress,
      this.presentSalary,
      this.expectedSalary,
      this.expectedJobType,
      this.expectedJobLevel,
      this.preferredJobLocations,
      this.preferredOrganizationTypes,
      this.preferredJobCategories,
      this.skills,
      this.careerObjective,
      this.careerSummary,
      this.specialQualification,
      this.keywords,
      this.disability,
      this.educations,
      this.experiences,
      this.certifications,
      this.trainings,
      this.references,
      this.resumeLanguages});

  Resume.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    address = json['address'];
    about = json['about'];
    profilePhoto = json['profile_photo'];
    coverImage = json['cover_image'];
    designation = json['designation'] != null ? Designation.fromJson(json['designation']) : null;
    applicantId = json['applicant_id'];
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    nationality = json['nationality'];
    bloodGroup = json['blood_group'];
    maritalStatus = json['marital_status'];
    weight = json['weight'];
    height = json['height'];
    alternativeEmail = json['alternative_email'];
    secondaryMobile = json['secondary_mobile'];
    emergencyContact = json['emergency_contact'];
    presentAddress = json['present_address'];
    permanentAddress = json['permanent_address'];
    presentSalary = json['present_salary'];
    expectedSalary = json['expected_salary'];
    expectedJobType = json['expected_job_type'];
    expectedJobLevel = json['expected_job_level'];
    //preferredJobLocations = json['preferred_job_locations'].cast<String>();
    //preferredOrganizationTypes = json['preferred_organization_types'].cast<String>();
    preferredJobLocations = json['preferred_job_locations'] == null
        ? []
        : List<String>.from(json["preferred_job_locations"]!.map((x) => x));
    preferredOrganizationTypes = json['preferred_organization_types'] == null
        ? []
        : List<String>.from(json["preferred_organization_types"]!.map((x) => x));

    if (json['preferred_job_categories'] != null) {
      preferredJobCategories = <PreferredJobCategories>[];
      json['preferred_job_categories'].forEach((v) {
        preferredJobCategories!.add(PreferredJobCategories.fromJson(v));
      });
    }
    //skills = json['skills'].cast<String>();
    skills = json['skills'] == null ? [] : List<String>.from(json["skills"]!.map((x) => x));
    careerObjective = json['career_objective'];
    careerSummary = json['career_summary'];
    specialQualification = json['special_qualification'];
    //keywords = json['keywords'].cast<String>();
    keywords = json['keywords'] == null ? [] : List<String>.from(json["keywords"]!.map((x) => x));
    disability = json['disability'];
    if (json['educations'] != null) {
      educations = <Educations>[];
      json['educations'].forEach((v) {
        educations!.add(Educations.fromJson(v));
      });
    }
    if (json['experiences'] != null) {
      experiences = <Experiences>[];
      json['experiences'].forEach((v) {
        experiences!.add(Experiences.fromJson(v));
      });
    }
    if (json['certifications'] != null) {
      certifications = <Certifications>[];
      json['certifications'].forEach((v) {
        certifications!.add(Certifications.fromJson(v));
      });
    }
    if (json['trainings'] != null) {
      trainings = <Trainings>[];
      json['trainings'].forEach((v) {
        trainings!.add(Trainings.fromJson(v));
      });
    }
    if (json['references'] != null) {
      references = <References>[];
      json['references'].forEach((v) {
        references!.add(References.fromJson(v));
      });
    }
    if (json['resumeLanguages'] != null) {
      resumeLanguages = <ResumeLanguages>[];
      json['resumeLanguages'].forEach((v) {
        resumeLanguages!.add(ResumeLanguages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    data['address'] = address;
    data['about'] = about;
    data['profile_photo'] = profilePhoto;
    data['cover_image'] = coverImage;
    if (designation != null) {
      data['designation'] = designation!.toJson();
    }
    data['applicant_id'] = applicantId;
    data['father_name'] = fatherName;
    data['mother_name'] = motherName;
    data['nationality'] = nationality;
    data['blood_group'] = bloodGroup;
    data['marital_status'] = maritalStatus;
    data['weight'] = weight;
    data['height'] = height;
    data['alternative_email'] = alternativeEmail;
    data['secondary_mobile'] = secondaryMobile;
    data['emergency_contact'] = emergencyContact;
    data['present_address'] = presentAddress;
    data['permanent_address'] = permanentAddress;
    data['present_salary'] = presentSalary;
    data['expected_salary'] = expectedSalary;
    data['expected_job_type'] = expectedJobType;
    data['expected_job_level'] = expectedJobLevel;
    data['preferred_job_locations'] = preferredJobLocations;
    data['preferred_organization_types'] = preferredOrganizationTypes;
    if (preferredJobCategories != null) {
      data['preferred_job_categories'] = preferredJobCategories!.map((v) => v.toJson()).toList();
    }
    data['skills'] = skills;
    data['career_objective'] = careerObjective;
    data['career_summary'] = careerSummary;
    data['special_qualification'] = specialQualification;
    data['keywords'] = keywords;
    data['disability'] = disability;
    if (educations != null) {
      data['educations'] = educations!.map((v) => v.toJson()).toList();
    }
    if (experiences != null) {
      data['experiences'] = experiences!.map((v) => v.toJson()).toList();
    }
    if (certifications != null) {
      data['certifications'] = certifications!.map((v) => v.toJson()).toList();
    }
    if (trainings != null) {
      data['trainings'] = trainings!.map((v) => v.toJson()).toList();
    }
    if (references != null) {
      data['references'] = references!.map((v) => v.toJson()).toList();
    }
    if (resumeLanguages != null) {
      data['resumeLanguages'] = resumeLanguages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PreferredJobCategories {
  int? id;
  String? name;

  PreferredJobCategories({
    this.id,
    this.name,
  });

  factory PreferredJobCategories.fromJson(Map<String, dynamic> json) => PreferredJobCategories(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
// class Designation {
//   int? id;
//   String? name;
//
//   Designation({this.id, this.name});
//
//   Designation.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     return data;
//   }
// }

class Educations {
  int? id;
  String? level;
  String? major;
  String? exam;
  String? board;
  String? result;
  String? institute;
  String? startDate;
  String? endDate;
  String? duration;
  String? status;
  String? createdAt;
  String? updatedAt;

  Educations(
      {this.id,
      this.level,
      this.major,
      this.exam,
      this.board,
      this.result,
      this.institute,
      this.startDate,
      this.endDate,
      this.duration,
      this.status,
      this.createdAt,
      this.updatedAt});

  Educations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    level = json['level'];
    major = json['major'];
    exam = json['exam'];
    board = json['board'];
    result = json['result'];
    institute = json['institute'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    duration = json['duration'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['level'] = level;
    data['major'] = major;
    data['exam'] = exam;
    data['board'] = board;
    data['result'] = result;
    data['institute'] = institute;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['duration'] = duration;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Experiences {
  int? id;
  String? employer;
  String? business;
  String? designation;
  String? department;
  String? responsibilities;
  String? location;
  String? startDate;
  String? endDate;
  String? jobType;
  String? duration;
  String? status;
  String? createdAt;
  String? updatedAt;

  Experiences(
      {this.id,
      this.employer,
      this.business,
      this.designation,
      this.department,
      this.responsibilities,
      this.location,
      this.startDate,
      this.endDate,
      this.jobType,
      this.duration,
      this.status,
      this.createdAt,
      this.updatedAt});

  Experiences.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employer = json['employer'];
    business = json['business'];
    designation = json['designation'];
    department = json['department'];
    responsibilities = json['responsibilities'];
    location = json['location'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    jobType = json['job_type'];
    duration = json['duration'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['employer'] = employer;
    data['business'] = business;
    data['designation'] = designation;
    data['department'] = department;
    data['responsibilities'] = responsibilities;
    data['location'] = location;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['job_type'] = jobType;
    data['duration'] = duration;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Certifications {
  int? id;
  int? applicantId;
  String? name;
  String? institute;
  String? location;
  String? startDate;
  String? endDate;
  String? status;
  String? createdAt;
  String? updatedAt;

  Certifications(
      {this.id,
      this.applicantId,
      this.name,
      this.institute,
      this.location,
      this.startDate,
      this.endDate,
      this.status,
      this.createdAt,
      this.updatedAt});

  Certifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    applicantId = json['applicant_id'];
    name = json['name'];
    institute = json['institute'];
    location = json['location'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['applicant_id'] = applicantId;
    data['name'] = name;
    data['institute'] = institute;
    data['location'] = location;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Trainings {
  int? id;
  int? applicantId;
  String? name;
  String? topics;
  String? institute;
  String? location;
  String? startDate;
  String? endDate;
  String? status;
  String? createdAt;
  String? updatedAt;

  Trainings(
      {this.id,
      this.applicantId,
      this.name,
      this.topics,
      this.institute,
      this.location,
      this.startDate,
      this.endDate,
      this.status,
      this.createdAt,
      this.updatedAt});

  Trainings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    applicantId = json['applicant_id'];
    name = json['name'];
    topics = json['topics'];
    institute = json['institute'];
    location = json['location'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['applicant_id'] = applicantId;
    data['name'] = name;
    data['topics'] = topics;
    data['institute'] = institute;
    data['location'] = location;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class References {
  int? id;
  int? applicantId;
  String? name;
  String? organization;
  String? designation;
  String? address;
  String? email;
  String? phone;
  String? relation;
  String? status;
  String? createdAt;
  String? updatedAt;

  References(
      {this.id,
      this.applicantId,
      this.name,
      this.organization,
      this.designation,
      this.address,
      this.email,
      this.phone,
      this.relation,
      this.status,
      this.createdAt,
      this.updatedAt});

  References.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    applicantId = json['applicant_id'];
    name = json['name'];
    organization = json['organization'];
    designation = json['designation'];
    address = json['address'];
    email = json['email'];
    phone = json['phone'];
    relation = json['relation'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['applicant_id'] = applicantId;
    data['name'] = name;
    data['organization'] = organization;
    data['designation'] = designation;
    data['address'] = address;
    data['email'] = email;
    data['phone'] = phone;
    data['relation'] = relation;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class ResumeLanguages {
  int? id;
  int? applicantId;
  String? name;
  String? reading;
  String? writing;
  String? speaking;
  String? status;
  String? createdAt;
  String? updatedAt;

  ResumeLanguages(
      {this.id,
      this.applicantId,
      this.name,
      this.reading,
      this.writing,
      this.speaking,
      this.status,
      this.createdAt,
      this.updatedAt});

  ResumeLanguages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    applicantId = json['applicant_id'];
    name = json['name'];
    reading = json['reading'];
    writing = json['writing'];
    speaking = json['speaking'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['applicant_id'] = applicantId;
    data['name'] = name;
    data['reading'] = reading;
    data['writing'] = writing;
    data['speaking'] = speaking;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

// To parse this JSON data, do
//
//     final resumeModel = resumeModelFromJson(jsonString);
//
// import 'dart:convert';
//
// ResumeModel resumeModelFromJson(String str) => ResumeModel.fromJson(json.decode(str));
//
// String resumeModelToJson(ResumeModel data) => json.encode(data.toJson());
//
// class ResumeModel {
//   bool? success;
//   String? message;
//   Data? data;
//
//   ResumeModel({
//     this.success,
//     this.message,
//     this.data,
//   });
//
//   factory ResumeModel.fromJson(Map<String, dynamic> json) => ResumeModel(
//     success: json["success"],
//     message: json["message"],
//     data: json["data"] == null ? null : Data.fromJson(json["data"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "success": success,
//     "message": message,
//     "data": data?.toJson(),
//   };
// }
//
// class Data {
//   int? userId;
//   String? name;
//   String? email;
//   String? phone;
//   DateTime? dateOfBirth;
//   String? gender;
//   dynamic address;
//   dynamic about;
//   String? profilePhoto;
//   String? coverImage;
//   Designation? designation;
//   int? applicantId;
//   String? fatherName;
//   String? motherName;
//   String? nationality;
//   int? bloodGroup;
//   String? maritalStatus;
//   String? weight;
//   String? height;
//   String? alternativeEmail;
//   String? secondaryMobile;
//   String? emergencyContact;
//   String? presentAddress;
//   String? permanentAddress;
//   int? presentSalary;
//   int? expectedSalary;
//   String? expectedJobType;
//   String? expectedJobLevel;
//   List<String>? preferredJobLocations;
//   List<String>? preferredOrganizationTypes;
//   List<Designation>? preferredJobCategories;
//   List<String>? skills;
//   String? careerObjective;
//   String? careerSummary;
//   String? specialQualification;
//   List<String>? keywords;
//   dynamic disability;
//   List<Education>? educations;
//   List<Experience>? experiences;
//   List<Certification>? certifications;
//   List<Certification>? trainings;
//   List<Reference>? references;
//   List<ResumeLanguage>? resumeLanguages;
//
//   Data({
//     this.userId,
//     this.name,
//     this.email,
//     this.phone,
//     this.dateOfBirth,
//     this.gender,
//     this.address,
//     this.about,
//     this.profilePhoto,
//     this.coverImage,
//     this.designation,
//     this.applicantId,
//     this.fatherName,
//     this.motherName,
//     this.nationality,
//     this.bloodGroup,
//     this.maritalStatus,
//     this.weight,
//     this.height,
//     this.alternativeEmail,
//     this.secondaryMobile,
//     this.emergencyContact,
//     this.presentAddress,
//     this.permanentAddress,
//     this.presentSalary,
//     this.expectedSalary,
//     this.expectedJobType,
//     this.expectedJobLevel,
//     this.preferredJobLocations,
//     this.preferredOrganizationTypes,
//     this.preferredJobCategories,
//     this.skills,
//     this.careerObjective,
//     this.careerSummary,
//     this.specialQualification,
//     this.keywords,
//     this.disability,
//     this.educations,
//     this.experiences,
//     this.certifications,
//     this.trainings,
//     this.references,
//     this.resumeLanguages,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     userId: json["user_id"],
//     name: json["name"],
//     email: json["email"],
//     phone: json["phone"],
//     dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
//     gender: json["gender"],
//     address: json["address"],
//     about: json["about"],
//     profilePhoto: json["profile_photo"],
//     coverImage: json["cover_image"],
//     designation: json["designation"] == null ? null : Designation.fromJson(json["designation"]),
//     applicantId: json["applicant_id"],
//     fatherName: json["father_name"],
//     motherName: json["mother_name"],
//     nationality: json["nationality"],
//     bloodGroup: json["blood_group"],
//     maritalStatus: json["marital_status"],
//     weight: json["weight"],
//     height: json["height"],
//     alternativeEmail: json["alternative_email"],
//     secondaryMobile: json["secondary_mobile"],
//     emergencyContact: json["emergency_contact"],
//     presentAddress: json["present_address"],
//     permanentAddress: json["permanent_address"],
//     presentSalary: json["present_salary"],
//     expectedSalary: json["expected_salary"],
//     expectedJobType: json["expected_job_type"],
//     expectedJobLevel: json["expected_job_level"],
//     preferredJobLocations: json["preferred_job_locations"] == null ? [] : List<String>.from(json["preferred_job_locations"]!.map((x) => x)),
//     preferredOrganizationTypes: json["preferred_organization_types"] == null ? [] : List<String>.from(json["preferred_organization_types"]!.map((x) => x)),
//     preferredJobCategories: json["preferred_job_categories"] == null ? [] : List<Designation>.from(json["preferred_job_categories"]!.map((x) => Designation.fromJson(x))),
//     skills: json["skills"] == null ? [] : List<String>.from(json["skills"]!.map((x) => x)),
//     careerObjective: json["career_objective"],
//     careerSummary: json["career_summary"],
//     specialQualification: json["special_qualification"],
//     keywords: json["keywords"] == null ? [] : List<String>.from(json["keywords"]!.map((x) => x)),
//     disability: json["disability"],
//     educations: json["educations"] == null ? [] : List<Education>.from(json["educations"]!.map((x) => Education.fromJson(x))),
//     experiences: json["experiences"] == null ? [] : List<Experience>.from(json["experiences"]!.map((x) => Experience.fromJson(x))),
//     certifications: json["certifications"] == null ? [] : List<Certification>.from(json["certifications"]!.map((x) => Certification.fromJson(x))),
//     trainings: json["trainings"] == null ? [] : List<Certification>.from(json["trainings"]!.map((x) => Certification.fromJson(x))),
//     references: json["references"] == null ? [] : List<Reference>.from(json["references"]!.map((x) => Reference.fromJson(x))),
//     resumeLanguages: json["resumeLanguages"] == null ? [] : List<ResumeLanguage>.from(json["resumeLanguages"]!.map((x) => ResumeLanguage.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "user_id": userId,
//     "name": name,
//     "email": email,
//     "phone": phone,
//     "date_of_birth": "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
//     "gender": gender,
//     "address": address,
//     "about": about,
//     "profile_photo": profilePhoto,
//     "cover_image": coverImage,
//     "designation": designation?.toJson(),
//     "applicant_id": applicantId,
//     "father_name": fatherName,
//     "mother_name": motherName,
//     "nationality": nationality,
//     "blood_group": bloodGroup,
//     "marital_status": maritalStatus,
//     "weight": weight,
//     "height": height,
//     "alternative_email": alternativeEmail,
//     "secondary_mobile": secondaryMobile,
//     "emergency_contact": emergencyContact,
//     "present_address": presentAddress,
//     "permanent_address": permanentAddress,
//     "present_salary": presentSalary,
//     "expected_salary": expectedSalary,
//     "expected_job_type": expectedJobType,
//     "expected_job_level": expectedJobLevel,
//     "preferred_job_locations": preferredJobLocations == null ? [] : List<dynamic>.from(preferredJobLocations!.map((x) => x)),
//     "preferred_organization_types": preferredOrganizationTypes == null ? [] : List<dynamic>.from(preferredOrganizationTypes!.map((x) => x)),
//     "preferred_job_categories": preferredJobCategories == null ? [] : List<dynamic>.from(preferredJobCategories!.map((x) => x.toJson())),
//     "skills": skills == null ? [] : List<dynamic>.from(skills!.map((x) => x)),
//     "career_objective": careerObjective,
//     "career_summary": careerSummary,
//     "special_qualification": specialQualification,
//     "keywords": keywords == null ? [] : List<dynamic>.from(keywords!.map((x) => x)),
//     "disability": disability,
//     "educations": educations == null ? [] : List<dynamic>.from(educations!.map((x) => x.toJson())),
//     "experiences": experiences == null ? [] : List<dynamic>.from(experiences!.map((x) => x.toJson())),
//     "certifications": certifications == null ? [] : List<dynamic>.from(certifications!.map((x) => x.toJson())),
//     "trainings": trainings == null ? [] : List<dynamic>.from(trainings!.map((x) => x.toJson())),
//     "references": references == null ? [] : List<dynamic>.from(references!.map((x) => x.toJson())),
//     "resumeLanguages": resumeLanguages == null ? [] : List<dynamic>.from(resumeLanguages!.map((x) => x.toJson())),
//   };
// }
//
// class Certification {
//   int? id;
//   int? applicantId;
//   String? name;
//   String? institute;
//   String? location;
//   DateTime? startDate;
//   DateTime? endDate;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//   String? topics;
//
//   Certification({
//     this.id,
//     this.applicantId,
//     this.name,
//     this.institute,
//     this.location,
//     this.startDate,
//     this.endDate,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.topics,
//   });
//
//   factory Certification.fromJson(Map<String, dynamic> json) => Certification(
//     id: json["id"],
//     applicantId: json["applicant_id"],
//     name: json["name"],
//     institute: json["institute"],
//     location: json["location"],
//     startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
//     endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
//     status: json["status"],
//     createdAt: json["created_at"],
//     updatedAt: json["updated_at"],
//     topics: json["topics"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "applicant_id": applicantId,
//     "name": name,
//     "institute": institute,
//     "location": location,
//     "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
//     "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
//     "status": status,
//     "created_at": createdAt,
//     "updated_at": updatedAt,
//     "topics": topics,
//   };
// }
//
// class Designation {
//   int? id;
//   String? name;
//
//   Designation({
//     this.id,
//     this.name,
//   });
//
//   factory Designation.fromJson(Map<String, dynamic> json) => Designation(
//     id: json["id"],
//     name: json["name"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//   };
// }
//
// class Education {
//   int? id;
//   String? level;
//   String? major;
//   String? exam;
//   String? board;
//   String? result;
//   String? institute;
//   DateTime? startDate;
//   DateTime? endDate;
//   String? duration;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//
//   Education({
//     this.id,
//     this.level,
//     this.major,
//     this.exam,
//     this.board,
//     this.result,
//     this.institute,
//     this.startDate,
//     this.endDate,
//     this.duration,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory Education.fromJson(Map<String, dynamic> json) => Education(
//     id: json["id"],
//     level: json["level"],
//     major: json["major"],
//     exam: json["exam"],
//     board: json["board"],
//     result: json["result"],
//     institute: json["institute"],
//     startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
//     endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
//     duration: json["duration"],
//     status: json["status"],
//     createdAt: json["created_at"],
//     updatedAt: json["updated_at"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "level": level,
//     "major": major,
//     "exam": exam,
//     "board": board,
//     "result": result,
//     "institute": institute,
//     "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
//     "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
//     "duration": duration,
//     "status": status,
//     "created_at": createdAt,
//     "updated_at": updatedAt,
//   };
// }
//
// class Experience {
//   int? id;
//   String? employer;
//   String? business;
//   String? designation;
//   dynamic department;
//   dynamic responsibilities;
//   String? location;
//   DateTime? startDate;
//   DateTime? endDate;
//   dynamic jobType;
//   String? duration;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//
//   Experience({
//     this.id,
//     this.employer,
//     this.business,
//     this.designation,
//     this.department,
//     this.responsibilities,
//     this.location,
//     this.startDate,
//     this.endDate,
//     this.jobType,
//     this.duration,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory Experience.fromJson(Map<String, dynamic> json) => Experience(
//     id: json["id"],
//     employer: json["employer"],
//     business: json["business"],
//     designation: json["designation"],
//     department: json["department"],
//     responsibilities: json["responsibilities"],
//     location: json["location"],
//     startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
//     endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
//     jobType: json["job_type"],
//     duration: json["duration"],
//     status: json["status"],
//     createdAt: json["created_at"],
//     updatedAt: json["updated_at"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "employer": employer,
//     "business": business,
//     "designation": designation,
//     "department": department,
//     "responsibilities": responsibilities,
//     "location": location,
//     "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
//     "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
//     "job_type": jobType,
//     "duration": duration,
//     "status": status,
//     "created_at": createdAt,
//     "updated_at": updatedAt,
//   };
// }
//
// class Reference {
//   int? id;
//   int? applicantId;
//   String? name;
//   String? organization;
//   String? designation;
//   String? address;
//   String? email;
//   String? phone;
//   String? relation;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//
//   Reference({
//     this.id,
//     this.applicantId,
//     this.name,
//     this.organization,
//     this.designation,
//     this.address,
//     this.email,
//     this.phone,
//     this.relation,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory Reference.fromJson(Map<String, dynamic> json) => Reference(
//     id: json["id"],
//     applicantId: json["applicant_id"],
//     name: json["name"],
//     organization: json["organization"],
//     designation: json["designation"],
//     address: json["address"],
//     email: json["email"],
//     phone: json["phone"],
//     relation: json["relation"],
//     status: json["status"],
//     createdAt: json["created_at"],
//     updatedAt: json["updated_at"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "applicant_id": applicantId,
//     "name": name,
//     "organization": organization,
//     "designation": designation,
//     "address": address,
//     "email": email,
//     "phone": phone,
//     "relation": relation,
//     "status": status,
//     "created_at": createdAt,
//     "updated_at": updatedAt,
//   };
// }
//
// class ResumeLanguage {
//   int? id;
//   int? applicantId;
//   String? name;
//   String? reading;
//   String? writing;
//   String? speaking;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//
//   ResumeLanguage({
//     this.id,
//     this.applicantId,
//     this.name,
//     this.reading,
//     this.writing,
//     this.speaking,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory ResumeLanguage.fromJson(Map<String, dynamic> json) => ResumeLanguage(
//     id: json["id"],
//     applicantId: json["applicant_id"],
//     name: json["name"],
//     reading: json["reading"],
//     writing: json["writing"],
//     speaking: json["speaking"],
//     status: json["status"],
//     createdAt: json["created_at"],
//     updatedAt: json["updated_at"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "applicant_id": applicantId,
//     "name": name,
//     "reading": reading,
//     "writing": writing,
//     "speaking": speaking,
//     "status": status,
//     "created_at": createdAt,
//     "updated_at": updatedAt,
//   };
// }
