import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eservices/controllers/update_image_controller.dart';
import 'package:eservices/utils/ui_helper.dart';

import '../models/user.dart';
import '../services/api_caller.dart';
import '../services/urls.dart';
import 'auth_controller.dart';

class UpdateProfileController extends GetxController {
  User? user = Get.find<AuthController>().user;
  @override
  void onInit() {
    super.onInit();
    nameController.text = user?.name ?? '';
    emailController.text = user?.email ?? '';
    phoneController.text = user?.phone ?? '';
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  File? profileImage;
  bool loading = false;

  Map<String, String?> validationErrors = {};

  updateBirthDay(String value) {
    birthdayController.text = value;
    update();
  }

  Future<bool> updateProfile({required designationId, required gender}) async {
    loading = true;
    update();
    if (Get.find<UpdateImageController>().profileImage != null) {
      await Get.find<UpdateImageController>().updateImage();
    }
    final response = await ApiCaller().postRequest(Urls.updateProfile, body: {
      'name': nameController.text.trim(),
      'email': emailController.text.trim(),
      'phone': phoneController.text.trim(),
      'date_of_birth': birthdayController.text.trim(),
      'designation': designationId,
      'gender': gender,
    });
    var responseData = await response.responseData;
    if (response.isSuccess && responseData['success'] == true) {
      // Get.find<AuthController>().user?.name = responseData['data']['name'];
      // Get.find<AuthController>().user?.email = responseData['data']['email'];
      // Get.find<AuthController>().user?.phone = responseData['data']['phone'];
      // Get.find<AuthController>().user?.gender = responseData['data']['gender'];
      // Get.find<AuthController>().user?.dateOfBirth = responseData['data']['date_of_birth'];
      // Get.find<AuthController>().user?.designation = responseData['data']['designation'];
      Get.find<AuthController>()
          .updateUserInformation(User.fromJson(responseData['data']));
      profileImage = null;
      loading = false;
      validationErrors = {};
      update();
      UiHelper.showSnackBar(
          text: responseData['message'] ?? 'Successfully updated',
          error: false);
      return true;
    } else {
      if (response.statusCode == 422 &&
          response.responseData is Map<String, dynamic>) {
        // Extract validation errors from responseData['data']
        validationErrors = (response.responseData as Map<String, dynamic>).map(
          (key, value) => MapEntry(key, (value as List<dynamic>).join(', ')),
        );
      } else {
        validationErrors = {};
        // Handle general errors
        UiHelper.showSnackBar(
            text: response.errorMessage ?? 'An unknown error occurred',
            error: true);
      }

      loading = false;
      update();
      return false;
    }
  }

  // Future<bool> updateProfile({required int jobId, required String message}) async {
  //   loading = true;
  //   update();
  //   final request = http.MultipartRequest('POST', Uri.parse(Urls.updateProfile));
  //   request.headers['Authorization'] = 'Bearer ${AuthController.token}';
  //   request.fields['job_id'] = jobId.toString();
  //   request.fields['message'] = message;
  //   if (profileImage != null) {
  //     request.files.add(http.MultipartFile.fromBytes('cv', File(profileImage!.path).readAsBytesSync(),
  //         filename: profileImage!.path));
  //   }
  //   final response = await request.send();
  //   final responseBody = await http.Response.fromStream(response);
  //   final responseData = jsonDecode(responseBody.body);
  //   if (response.statusCode == 200) {
  //     loading = false;
  //     update();
  //     return true;
  //   } else {
  //     loading = false;
  //     update();
  //     log("${jsonDecode(responseBody.body)}");
  //     return true;
  //   }
  // }

  Future<void> pickProfileImage() async {
    // FilePickerResult? result = await FilePicker.platform.pickFiles(
    //   type: FileType.custom,
    //   allowedExtensions: ['pdf'],
    // );
    XFile? result = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (result != null) {
      profileImage = File(result.path);
      update();
    }
  }
}
