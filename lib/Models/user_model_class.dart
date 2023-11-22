// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

List<UserModel> userModelFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel extends Equatable {
  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final Address? address;
  final String? phone;
  final String? website;
  final Company? company;

  const UserModel({
    this.id,
    this.name,
    this.username,
    this.email,
    this.address,
    this.phone,
    this.website,
    this.company,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
    username: json["username"] ?? "",
    email: json["email"] ?? "",
    address: json.containsKey("address") ? json["address"] != null ? Address.fromJson(json["address"]) :null :null,
    phone: json["phone"] ?? "",
    website: json["website"] ?? "",
    company: json.containsKey("company") ? json["company"] != null ? Company.fromJson(json["company"]) :null :null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "username": username,
    "email": email,
    "address": address!.toJson(),
    "phone": phone,
    "website": website,
    "company": company!.toJson(),
  };

  @override
  List<Object?> get props => [id, name, username, email, address, phone, website, company];
}

class Address {
  String? street;
  String? suite;
  String? city;
  String? zipcode;
  Geo? geo;

  Address({
    this.street,
    this.suite,
    this.city,
    this.zipcode,
    this.geo,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    street: json["street"] ?? "",
    suite: json["suite"] ?? "",
    city: json["city"] ?? "",
    zipcode: json["zipcode"] ?? "",
    geo: json.containsKey("geo") ? json["geo"] != null ? Geo.fromJson(json["geo"]) :null :null,
  );

  Map<String, dynamic> toJson() => {
    "street": street,
    "suite": suite,
    "city": city,
    "zipcode": zipcode,
    "geo": geo!.toJson(),
  };
}

class Geo {
  String? lat;
  String? lng;

  Geo({
    this.lat,
    this.lng,
  });

  factory Geo.fromJson(Map<String, dynamic> json) => Geo(
    lat: json["lat"] ?? "",
    lng: json["lng"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}

class Company {
  String? name;
  String? catchPhrase;
  String? bs;

  Company({
    this.name,
    this.catchPhrase,
    this.bs,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    name: json["name"] ?? "",
    catchPhrase: json["catchPhrase"] ?? "",
    bs: json["bs"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "catchPhrase": catchPhrase,
    "bs": bs,
  };
}
