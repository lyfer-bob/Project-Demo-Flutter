class ApiPath {
  ApiPath();

  static const String _apiPath =
      'https://rehlnnzmnii3vunend7gatv7zq0ydqwa.lambda-url.ap-southeast-1.on.aws';
  static const String getToken = '$_apiPath/token/generate';
  static const String getOtp = '$_apiPath/otp/request';
  static const String register = '$_apiPath/customer/register';
}
