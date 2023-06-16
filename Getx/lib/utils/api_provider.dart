import 'dart:async';
import 'dart:io';
import 'package:get/get_connect/connect.dart';

class APIProvider {
  static const requestTimeOut = Duration(seconds: 25);
  final _client = GetConnect(timeout: requestTimeOut);

  static final _singleton = APIProvider();
  static APIProvider get instance => _singleton;

  Future get(String url, var body) async => await _request(url, body, 'get');

  Future post(String url, var body) async => await _request(url, body, 'post');

  Future put(String url, var body) async => await _request(url, body, 'put');

  Future delete(String url, var body) async =>
      await _request(url, body, 'delete');

  Future _request(String url, var body, String method) async {
    try {
      final response = await _client.request(
        url,
        method,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer Token",
          HttpHeaders.contentTypeHeader: 'application/json'
        },
        query: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: body,
      );
      return _returnResponse(response);
    } on TimeoutException catch (_) {
      throw TimeOutException(null);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  dynamic _returnResponse(Response<dynamic> response) {
    print('response= = ${response.body}');

    switch (response.statusCode) {
      case 200:
        return response.body;
      case 400:
        print('\x1B[31m Error case 400 : ${response.body.toString()} \x1B[0m');
        break;
      case 403:
        print('\x1B[31m Error case 403 : ${response.body.toString()} \x1B[0m');
        break;
      case 404:
        print('\x1B[31m Error case 404 : Not found \x1B[0m');
        break;
      case 500:
        print('\x1B[31m Error case 500 :Internal Server Error \x1B[0m');
        break;
      default:
        print(
            '\x1B[31m Error case  ${response.statusCode} :  ${response.statusText} \x1B[0m');
        break;
    }
  }
}

class AppException implements Exception {
  final code;
  final message;
  final details;

  AppException({this.code, this.message, this.details});

  String toString() {
    return "[$code]: $message \n $details";
  }
}

class FetchDataException extends AppException {
  FetchDataException(String? details)
      : super(
          code: "fetch-data",
          message: "Error During Communication",
          details: details,
        );
}

class BadRequestException extends AppException {
  BadRequestException(String? details)
      : super(
          code: "invalid-request",
          message: "Invalid Request",
          details: details,
        );
}

class UnauthorisedException extends AppException {
  UnauthorisedException(String? details)
      : super(
          code: "unauthorised",
          message: "Unauthorised",
          details: details,
        );
}

class InvalidInputException extends AppException {
  InvalidInputException(String? details)
      : super(
          code: "invalid-input",
          message: "Invalid Input",
          details: details,
        );
}

class AuthenticationException extends AppException {
  AuthenticationException(String? details)
      : super(
          code: "authentication-failed",
          message: "Authentication Failed",
          details: details,
        );
}

class TimeOutException extends AppException {
  TimeOutException(String? details)
      : super(
          code: "request-timeout",
          message: "Request TimeOut",
          details: details,
        );
}
