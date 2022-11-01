import 'dart:convert';
import 'package:http/http.dart' as http;

class RestAPI {
  Future getData({
    required String url,
    dynamic body,
  }) async {
    var client = http.Client();
    var response = await client
        .post(Uri.parse(url), body: JsonEncoder().convert(body), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "lang": "TH",
    });
    return jsonDecode(response.body.trim());
  }
}
