import 'package:get/get.dart';
import 'package:eservices/services/api_caller.dart';
import 'package:eservices/services/urls.dart';

class EditResumeController extends GetxController {
  Future<bool> editPersonalDetails(
      {required name,
      required email,
      required phone,
      required fathersName,
      required mothersName,
      required dateOfBirth,
      required gender,
      required maritalStatus,
      required nationality}) async {
    final response =
        await ApiCaller().postRequest(Urls.editResumePersonalInfo, body: {
      'name': name,
      'email': email,
      'phone': phone,
      'father_name': fathersName,
      'mother_name': mothersName,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'marital_status': maritalStatus,
      'nationality': nationality,
    });
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> editAddressDetails(
      {required presentAddress, required permanentAddress}) async {
    final response =
        await ApiCaller().postRequest(Urls.editResumeAddressInfo, body: {
      'present_address': presentAddress,
      'permanent_address': permanentAddress,
    });
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> editCareerInfo({
    required careerObjective,
    required careerSummary,
    required presentSalary,
    required expectedSalary,
    required jobLevel,
    required jobType,
  }) async {
    final response =
        await ApiCaller().postRequest(Urls.editResumeCareerInfo, body: {
      'career_objective': careerObjective,
      'career_summary': careerSummary,
      'present_salary': presentSalary,
      'expected_salary': expectedSalary,
      'job_level': jobLevel,
      'job_type': jobType,
    });
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> addNewExperience(
      {required companyName,
      required employer,
      required designation,
      required startDate,
      required endDate,
      required address}) async {
    final response =
        await ApiCaller().postRequest(Urls.editResumeAddExperience, body: {
      'business': companyName,
      'designation': designation,
      'start_date': startDate,
      'end_date': endDate,
      'location': address,
      'employer': employer,
      'status': '0',
    });
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateExperience(
      {required id,
      required companyName,
      required employer,
      required designation,
      required startDate,
      required endDate,
      required address}) async {
    final response =
        await ApiCaller().putRequest(Urls.editResumeUpdateExperience, body: {
      'id': id,
      'business': companyName,
      'designation': designation,
      'start_date': startDate,
      'end_date': endDate,
      'location': address,
      'employer': employer,
      'status': '0',
    });
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteExperience({required id}) async {
    final response =
        await ApiCaller().deleteRequest(Urls.editResumeDeleteExperience(id));
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> addNewEducation({
    required level,
    required exam,
    required major,
    required institute,
    required result,
    required startDate,
    required endDate,
  }) async {
    final response =
        await ApiCaller().postRequest(Urls.editResumeAddEducation, body: {
      'level': level,
      'exam': exam,
      'major': major,
      'institute': institute,
      'result': result,
      'start_date': startDate,
      'end_date': endDate,
    });
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateEducation({
    required id,
    required level,
    required exam,
    required major,
    required institute,
    required result,
    required startDate,
    required endDate,
  }) async {
    final response =
        await ApiCaller().putRequest(Urls.editResumeUpdateEducation, body: {
      'id': id,
      'level': level,
      'exam': exam,
      'major': major,
      'institute': institute,
      'result': result,
      'start_date': startDate,
      'end_date': endDate,
    });
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteEducation({required id}) async {
    final response =
        await ApiCaller().deleteRequest(Urls.editResumeDeleteEducation(id));
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> addNewTraining({
    required name,
    required topics,
    required institute,
    required location,
    required startDate,
    required endDate,
  }) async {
    final response =
        await ApiCaller().postRequest(Urls.editResumeAddTraining, body: {
      "name": name,
      "topics": topics,
      "institute": institute,
      "location": location,
      "start_date": startDate,
      "end_date": endDate,
    });
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateTraining({
    required id,
    required name,
    required topics,
    required institute,
    required location,
    required startDate,
    required endDate,
  }) async {
    final response =
        await ApiCaller().putRequest(Urls.editResumeUpdateTraining, body: {
      "id": id,
      "name": name,
      "topics": topics,
      "institute": institute,
      "location": location,
      "start_date": startDate,
      "end_date": endDate,
    });
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteTraining({required id}) async {
    final response =
        await ApiCaller().deleteRequest(Urls.editResumeDeleteTraining(id));
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> addNewLanguage({
    required name,
    required reading,
    required writing,
    required speaking,
  }) async {
    final response =
        await ApiCaller().postRequest(Urls.editResumeAddLanguage, body: {
      "name": name,
      "reading": reading,
      "writing": writing,
      "speaking": speaking,
    });
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateLanguage({
    required id,
    required name,
    required reading,
    required writing,
    required speaking,
  }) async {
    final response =
        await ApiCaller().putRequest(Urls.editResumeUpdateLanguage, body: {
      "id": id,
      "name": name,
      "reading": reading,
      "writing": writing,
      "speaking": speaking,
    });
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteLanguage({required id}) async {
    final response =
        await ApiCaller().deleteRequest(Urls.editResumeDeleteLanguage(id));
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> addNewReference({
    required name,
    required organization,
    required designation,
    required address,
    required email,
    required phone,
    required relation,
  }) async {
    final response =
        await ApiCaller().postRequest(Urls.editResumeAddReference, body: {
      "name": name,
      "organization": organization,
      "designation": designation,
      "address": address,
      "email": email,
      "phone": phone,
      "relation": relation,
    });
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateReference({
    required id,
    required name,
    required organization,
    required designation,
    required address,
    required email,
    required phone,
    required relation,
  }) async {
    final response =
        await ApiCaller().putRequest(Urls.editResumeUpdateReference, body: {
      "id": id,
      "name": name,
      "organization": organization,
      "designation": designation,
      "address": address,
      "email": email,
      "phone": phone,
      "relation": relation,
    });
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteReference({required id}) async {
    final response =
        await ApiCaller().deleteRequest(Urls.editResumeDeleteReference(id));
    if (response.isSuccess) {
      return true;
    } else {
      return false;
    }
  }
}
