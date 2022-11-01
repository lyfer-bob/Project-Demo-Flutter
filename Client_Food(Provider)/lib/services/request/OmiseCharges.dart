import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class OmiseCharges {
  getData(
    dynamic body,
  ) async {
    var client = http.Client();
    var response = await client.post(
      Uri.parse('https://api.omise.co/charges'),
      body: JsonEncoder().convert(body),
      headers: {
        HttpHeaders.authorizationHeader:
            'Basic ${base64Encode(utf8.encode('Secret key'))}', // Secret key
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );
    return jsonDecode(response.body.trim());
  }
}
