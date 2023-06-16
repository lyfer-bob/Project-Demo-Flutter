// To parse this JSON data, do
//
//     final menu = menuFromJson(jsonString);

import 'dart:convert';

List<Menu> menuFromJson(String str) =>
    List<Menu>.from(json.decode(str).map((x) => Menu.fromJson(x)));

String menuToJson(List<Menu> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Menu {
  String? id;
  double? price;
  String? name;
  String? category;
  String? picUrl;

  Menu({
    this.id,
    this.price,
    this.name,
    this.category,
    this.picUrl,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        id: json["id"],
        price: json["price"]?.toDouble(),
        name: json["name"],
        category: json["category"],
        picUrl: json["picUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "name": name,
        "category": category,
        "picUrl": picUrl,
      };
}
