// To parse this JSON data, do
//
//     final offersModel = offersModelFromJson(jsonString);

import 'dart:convert';

List<Offers> offersModelFromJson(String str) =>
    List<Offers>.from(json.decode(str).map((x) => Offers.fromJson(x)));

String offersModelToJson(List<Offers> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Offers {
  Offers({
    this.id,
    this.title,
    this.artitle,
    this.address,
    this.ardesc,
    this.detials,
    this.detailsar,
    this.email,
    this.endesc,
    this.mobile,
    this.newprice,
    this.oldprice,
    this.price,
    this.latitude,
    this.longitude,
    this.catName,
    this.catArname,
  });

  int? id;
  String? title;
  String? artitle;
  String? address;
  String? ardesc;
  String? detials;
  String? detailsar;
  String? email;
  String? endesc;
  String? mobile;
  double? newprice;
  double? oldprice;
  double? price;
  int? latitude;
  int? longitude;
  String? catName;
  String? catArname;

  factory Offers.fromJson(Map<String, dynamic> json) => Offers(
        id: json["id"],
        title: json["title"],
        artitle: json["artitle"],
        address: json["address"],
        ardesc: json["ardesc"],
        detials: json["detials"],
        detailsar: json["detailsar"],
        email: json["email"],
        endesc: json["endesc"],
        mobile: json["mobile"],
        newprice: json["newprice"],
        oldprice: json["oldprice"],
        price: json["price"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        catName: json["cat_name"],
        catArname: json["cat_arname"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "artitle": artitle,
        "address": address,
        "ardesc": ardesc,
        "detials": detials,
        "detailsar": detailsar,
        "email": email,
        "endesc": endesc,
        "mobile": mobile,
        "newprice": newprice,
        "oldprice": oldprice,
        "price": price,
        "latitude": latitude,
        "longitude": longitude,
        "cat_name": catName,
        "cat_arname": catArname,
      };
}
