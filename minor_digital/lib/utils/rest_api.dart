import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:minor_digital/utils/route/route_apipath.dart';

class RestAPI {
  static final _singleton = RestAPI();
  static RestAPI get instance => _singleton;

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  var client = http.Client();
  final _header = {"Content-Type": "application/json"};

  Future getToken(String url, var body) async {
    try {
      var response =
          await client.post(Uri.parse(url), body: json.encode(body), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      });

      if (response.statusCode.toString() == '200') {
        // Todo : add token in header
        _header.addAll({
          "Authorization": "Bearer " '${json.decode(response.body)['token']}'
        });
      } else {
        logger.w(
            'waring get token  statusCode ${response.statusCode} : ${response.body}');
      }
    } catch (e) {
      logger.e('error get token ${e.toString()}');
    }
  }

  Future get(String url) async {
    var response = await client.get(Uri.parse(url), headers: _header);
    return _returnResponse(response);
  }

  Future post(String url, var body, {String appId = 'xxxxxxx'}) async {
    final checkHeader = _header;

    if (url == ApiPath.getOtp) {
      // Todo :  add application-id" in header when getOtp
      checkHeader.addAll({"application-id": appId});
    } else {
      // Todo :  remove application-id" in header when getOtp
      checkHeader.removeWhere((key, value) => key == "application-id");
    }

    var response = await client.post(Uri.parse(url),
        body: json.encode(body), headers: checkHeader);

    return _returnResponse(response, url: url);
  }

  Future put(String url, var body) async {
    var response = await client.put(Uri.parse(url),
        body: json.encode(body), headers: _header);
    return _returnResponse(response);
  }

  Future delete(String url, var body) async {
    var response = await client.delete(Uri.parse(url),
        body: json.encode(body), headers: _header);
    return _returnResponse(response);
  }

  dynamic _returnResponse(http.Response response, {String? url}) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body.trim());
      case 201:
        return jsonDecode(response.body.trim());
      case 400:
        if (url == ApiPath.register || url == ApiPath.getOtp) {
          return jsonDecode(response.body.trim());
        } else {
          logger.e('Error case 400 : ${response.body.toString()}');
          break;
        }
      case 403:
        logger.e('Error case 403 : ${response.body.toString()}');
        break;
      case 404:
        logger.e('Error case 404 : Not found ');
        break;
      case 500:
        logger.e('Error case 500 :Internal Server Error ');
        break;
      default:
        logger.e('Error case  ${response.statusCode} :  ${response.body}');
        break;
    }
  }
}
