import 'dart:convert';

List<Drugs> drugsFromJson(String str) => List<Drugs>.from(json.decode(str).map((x) => Drugs.fromJson(x)));

String drugsToJson(List<Drugs> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Drugs {
  Drugs({
    this.descripti,
    this.image,
    this.name,
    this.ingridients,
    this.price,
  });

  String descripti;
  String image;
  String name;
  List<String> ingridients;
  String price;

  factory Drugs.fromJson(Map<String, dynamic> json) => Drugs(
    descripti: json["Descripti"],
    image: json["Image"],
    name: json["Name"],
    ingridients: List<String>.from(json["ingridients"].map((x) => x)),
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "Descripti": descripti,
    "Image": image,
    "Name": name,
    "ingridients": List<dynamic>.from(ingridients.map((x) => x)),
    "price": price,
  };
}
