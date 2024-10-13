import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../models/user.dart';
import '../services/urls.dart';
import 'auth_controller.dart';

class UpdateImageController extends GetxController {
  User? user = Get.find<AuthController>().user;
  File? profileImage;
  bool loading = false;

  Future<bool> updateImage() async {
    loading = true;
    update();
    final request = http.MultipartRequest('POST', Uri.parse(Urls.updateImage));
    request.headers['Authorization'] = 'Bearer ${AuthController.token}';
    if (profileImage != null) {
      request.files.add(http.MultipartFile.fromBytes(
          'profile_photo', File(profileImage!.path).readAsBytesSync(),
          filename: profileImage!.path));
    }
    final response = await request.send();
    final responseBody = await http.Response.fromStream(response);
    final responseData = jsonDecode(responseBody.body);
    if (response.statusCode == 200) {
      Get.find<AuthController>().user?.profilePhoto = responseData['data']['profile_photo'];
      log("Success: ${response.statusCode}");
      loading = false;
      update();
      return true;
    } else {
      log(responseData);
      loading = false;
      update();
      log("${jsonDecode(responseBody.body)}");
      return true;
    }
  }

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
