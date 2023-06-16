// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
    String? deviceId;
    String? deviceName;
    String? deviceOs;
    String? deviceNumber;
    String? userNameOrEmailAddress;
    String? password;

    Login({
        this.deviceId,
        this.deviceName,
        this.deviceOs,
        this.deviceNumber,
        this.userNameOrEmailAddress,
        this.password,
    });

    factory Login.fromJson(Map<String, dynamic> json) => Login(
        deviceId: json["deviceId"],
        deviceName: json["deviceName"],
        deviceOs: json["deviceOS"],
        deviceNumber: json["deviceNumber"],
        userNameOrEmailAddress: json["userNameOrEmailAddress"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "deviceId": deviceId,
        "deviceName": deviceName,
        "deviceOS": deviceOs,
        "deviceNumber": deviceNumber,
        "userNameOrEmailAddress": userNameOrEmailAddress,
        "password": password,
    };
}
