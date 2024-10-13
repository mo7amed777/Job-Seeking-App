import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:eservices/utils/ui_helper.dart';

import '../services/urls.dart';
import 'auth_controller.dart';

class ApplyJobController extends GetxController {
  File? resume;
  String? resumeName;
  bool loading = false;

  Future<void> pickResume() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      resume = File(result.files.single.path!);
      resumeName = result.files.single.name;
      update();
    }
  }

  Future<bool> applyJob({required int jobId, required String message}) async {
    loading = true;
    update();
    final request = http.MultipartRequest('POST', Uri.parse(Urls.applyJob));
    request.headers['Authorization'] = 'Bearer ${AuthController.token}';
    request.fields['job_id'] = jobId.toString();
    request.fields['message'] = message;
    if (resume != null) {
      request.files.add(http.MultipartFile.fromBytes(
          'cv', File(resume!.path).readAsBytesSync(),
          filename: resume!.path));
    }
    final response = await request.send();
    final responseBody = await http.Response.fromStream(response);
    final responseData = jsonDecode(responseBody.body);

    if (response.statusCode == 200) {
      loading = false;
      UiHelper.showSnackBar(
          text: responseData['message'] ?? 'An unknown error occurred',
          error: false);
      update();
      return true;
    } else {
      UiHelper.showSnackBar(
          text: responseData['message'] ?? 'An unknown error occurred',
          error: true);
      loading = false;
      update();
      return false;
    }
  }

  void removeResume() {
    resume == null;
    resumeName == null;
    update();
  }
}
