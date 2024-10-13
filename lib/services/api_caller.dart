import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:job_nect/utils/ui_helper.dart';

import '../controllers/auth_controller.dart';
import '../models/network_response.dart';

class ApiCaller {
  Future<NetworkResponse> getRequest(String url, {String? token}) async {
    //try {
    //log(url);
    final Response response = await get(Uri.parse(url), headers: {
      'Content-type': 'Application/json',
      'Authorization': 'Bearer ${(token ?? AuthController.token).toString()}',
    });
    // log(response.statusCode.toString());
    // log(response.headers.toString());
    // log(response.body);
    log('--------------\nurl: $url\nstatus code: ${response.statusCode}\nheader: ${response.headers}\nresponse: ${response.body}\n--------------');
    //final decodedData = await jsonDecode(response.body);

    if (response.statusCode == 200) {
      return NetworkResponse(
          statusCode: 200,
          isSuccess: true,
          responseData: jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      await AuthController.clearAuthData();
      AuthController.goToLogin();

      return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: '',
          responseData: '');
    } else if (response.statusCode == 500) {
      // await AuthController.clearAuthData();
      // AuthController.goToLogin();
      // UiHelper.showSnackBar(text: "Session Expired, please login", error: true);

      return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: '',
          //responseData: jsonDecode(response.body));
          responseData: '');
    } else {
      return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: '',
          //responseData: jsonDecode(response.body));
          responseData: '');
    }
    // } catch (e) {
    //   await AuthController.clearAuthData();
    //   await AuthController.goToLogin();
    //   return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    // }
  }

  Future<NetworkResponse> postRequest(String url,
      {Map<String, dynamic>? body, String? token, String? contentType}) async {
    try {
      // Sending POST request
      final Response response = await post(
        Uri.parse(url),
        headers: {
          'content-type': contentType ?? 'application/json',
          'Authorization':
              'Bearer ${(token ?? AuthController.token).toString()}',
        },
        body: jsonEncode(body),
      );

      log('--------------\nurl: $url\nbody: ${body.toString()}\nstatus code: ${response.statusCode}\nresponse: ${response.body}\n--------------');

      // Decode the response body
      dynamic decodedBody;
      try {
        decodedBody = jsonDecode(response.body);
      } catch (e) {
        log('Failed to decode response body: $e');
        decodedBody = null;
      }

      // Handle success response
      if (response.statusCode == 200) {
        return NetworkResponse(
          statusCode: 200,
          isSuccess: true,
          responseData: decodedBody,
        );
      }

      // Handle validation errors (422)
      if (response.statusCode == 422) {
        Map<String, dynamic>? data;
        String message = 'Validation failed';
        if (decodedBody is Map<String, dynamic>) {
          if (decodedBody.containsKey('message')) {
            message = decodedBody['message'];
          }
          if (decodedBody.containsKey('data')) {
            data = decodedBody['data'];
          }
        }

        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: message,
          responseData: data,
        );
      }

      // Handle unauthorized error (401)
      if (response.statusCode == 401) {
        await AuthController.clearAuthData();
        UiHelper.showSnackBar(
            text: "Session Expired, please login", error: true);
        AuthController.goToLogin();

        String errorMsg = 'Unauthorized access';
        if (decodedBody is Map<String, dynamic> &&
            decodedBody.containsKey('message')) {
          errorMsg = decodedBody['message'];
        }

        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: errorMsg,
          responseData: '',
        );
      }

      // Handle server error (500)
      if (response.statusCode == 500) {
        UiHelper.showSnackBar(text: "Internal Server Error", error: true);
        String errorMsg = 'Internal Server Error';
        if (decodedBody is Map<String, dynamic> &&
            decodedBody.containsKey('message')) {
          errorMsg = decodedBody['message'];
        }

        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: errorMsg,
          responseData: '',
        );
      }

      // Handle other errors
      String errorMsg = 'An error occurred';
      if (decodedBody is Map<String, dynamic> &&
          decodedBody.containsKey('message')) {
        errorMsg = decodedBody['message'];
      }

      return NetworkResponse(
        isSuccess: false,
        statusCode: response.statusCode,
        errorMessage: errorMsg,
        responseData: '',
      );
    } catch (e) {
      log('Error occurred: $e');
      return NetworkResponse(
        isSuccess: false,
        errorMessage: e.toString(),
        responseData: '',
      );
    }
  }

  // // Helper method to parse server-side error messages (optional if needed elsewhere)
  // String _parseErrorMessage(String responseBody) {
  //   try {
  //     final decodedResponse = jsonDecode(responseBody);
  //     if (decodedResponse is Map<String, dynamic>) {
  //       if (decodedResponse.containsKey('message')) {
  //         return decodedResponse['message'];
  //       }
  //       // Add more logic if your error messages are structured differently
  //     }
  //     return 'An unknown error occurred';
  //   } catch (e) {
  //     return 'Failed to parse error message';
  //   }
  // }

  // Similarly, modify other HTTP methods (getRequest, putRequest, deleteRequest) if needed

  Future<NetworkResponse> putRequest(String url,
      {Map<String, dynamic>? body, String? token, String? contentType}) async {
    //try {
    //log(url);
    //log(body.toString());
    final Response response = await put(
      Uri.parse(url),
      headers: {
        'content-type': contentType ?? 'application/json',
        'Authorization': 'Bearer ${(token ?? AuthController.token).toString()}',
      },
      body: jsonEncode(body),
    );
    // log(response.statusCode.toString());
    // log(response.headers.toString());
    // log(response.body);
    log('--------------\nurl: $url\nbody: ${body.toString()}\nstatus code: ${response.statusCode}\nheader: ${response.headers}\nresponse: ${response.body}\n--------------');
    //final decodedData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return NetworkResponse(
          statusCode: 200,
          isSuccess: true,
          responseData: jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      await AuthController.clearAuthData();
      UiHelper.showSnackBar(text: "Session Expired, please login", error: true);
      AuthController.goToLogin();
      return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: '',
          //responseData: jsonDecode(response.body));
          responseData: '');
    } else if (response.statusCode == 500) {
      await AuthController.clearAuthData();
      AuthController.goToLogin();
      UiHelper.showSnackBar(text: "Session Expired, please login", error: true);

      return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: '',
          //responseData: jsonDecode(response.body));
          responseData: '');
    } else {
      return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: '',
          //responseData: jsonDecode(response.body));
          responseData: '');
    }
    // } catch (e) {
    //   await AuthController.clearAuthData();
    //   await AuthController.goToLogin();
    //   return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    // }
  }

  Future<NetworkResponse> deleteRequest(String url, {String? token}) async {
    //try {
    final Response response = await delete(Uri.parse(url), headers: {
      'Content-type': 'Application/json',
      'Authorization': 'Bearer ${(token ?? AuthController.token).toString()}',
    });
    log('---------------------\n$url\n${response.statusCode}\n${response.headers}\n${response.body}\n---------------------');
    //final decodedData = await jsonDecode(response.body);
    if (response.statusCode == 200) {
      return NetworkResponse(
          statusCode: 200,
          isSuccess: true,
          responseData: jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      UiHelper.showSnackBar(text: "Session Expired, please login", error: true);
      await AuthController.clearAuthData();
      await AuthController.goToLogin();
      return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: '',
          //responseData: jsonDecode(response.body));
          responseData: '');
    } else if (response.statusCode == 500) {
      await AuthController.clearAuthData();
      AuthController.goToLogin();
      UiHelper.showSnackBar(text: "Session Expired, please login", error: true);

      return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: '',
          //responseData: jsonDecode(response.body));
          responseData: '');
    } else {
      return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: '',
          //responseData: jsonDecode(response.body));
          responseData: '');
    }
    // } catch (e) {
    //   await AuthController.clearAuthData();
    //   await AuthController.goToLogin();
    //   return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    // }
  }
}
