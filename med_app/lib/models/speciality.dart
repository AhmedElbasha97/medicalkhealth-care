// To parse this JSON data, do
//
//     final Speciality = SpecialityFromJson(jsonString);

import 'dart:convert';

Speciality SpecialityFromJson(String str) => Speciality.fromJson(json.decode(str));

String SpecialityToJson(Speciality data) => json.encode(data.toJson());

class Speciality {
    Speciality({
        this.speciality,
        this.image,
    });

    String speciality;
    String image;

    factory Speciality.fromJson(Map<String, dynamic> json) => Speciality(
        speciality: json["speciality"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "speciality": speciality,
        "image": image,
    };
}
