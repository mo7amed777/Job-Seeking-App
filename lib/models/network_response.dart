class NetworkResponse {
  final int? statusCode;
  final bool isSuccess;
  final dynamic responseData;
  final String? errorMessage;

  NetworkResponse(
      {this.statusCode = -1,
      required this.isSuccess,
      this.responseData,
      this.errorMessage = 'Something went wrong'});
}
