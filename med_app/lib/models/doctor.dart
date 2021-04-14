// To parse this JSON data, do
//
//     final doctor = doctorFromJson(jsonString);

import 'dart:convert';

Doctor doctorFromJson(String str) => Doctor.fromJson(json.decode(str));

String doctorToJson(Doctor data) => json.encode(data.toJson());

class Doctor {
  Doctor({
    this.appointment,
    this.availableAppointment,
    this.balance,
    this.bio,
    this.experience,
    this.languages,
    this.fees,
    this.rating,
    this.reviews,
    this.userAvatar,
    this.documents,
    this.email,
    this.profession,
    this.speciality,
    this.userId,
    this.username,
    this.name,
  });

  List<Appointment> appointment;
  List<AvailableAppointment> availableAppointment;
  String balance;
  String bio;
  String experience;
  List<String> languages;
  String fees;
  String rating;
  List<Review> reviews;
  String userAvatar;
  Documents documents;
  String email;
  String profession;
  String speciality;
  String userId;
  String username;
  String name;

  factory Doctor.fromJson(Map<dynamic, dynamic> json) => Doctor(
        appointment: List<Appointment>.from(
            json["appointment"].map((x) => Appointment.fromJson(x))),
        availableAppointment: List<AvailableAppointment>.from(
            json["availableAppointment"]
                .map((x) => AvailableAppointment.fromJson(x))),
        balance: json["balance"],
        bio: json["bio"],
        experience: json["experience"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        fees: json["fees"],
        rating: json["rating"],
        reviews:
            List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
        userAvatar: json["userAvatar"],
        documents: Documents.fromJson(json["documents"]),
        email: json["email"],
        profession: json["profession"],
        speciality: json["speciality"],
        userId: json["userId"],
        username: json["username"],
        name: json["name"],
      );

  Map<dynamic, dynamic> toJson() => {
        "appointment": List<dynamic>.from(appointment.map((x) => x.toJson())),
        "availableAppointment":
            List<dynamic>.from(availableAppointment.map((x) => x.toJson())),
        "balance": balance,
        "bio": bio,
        "experience": experience,
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "fees": fees,
        "rating": rating,
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
        "userAvatar": userAvatar,
        "documents": documents.toJson(),
        "email": email,
        "profession": profession,
        "speciality": speciality,
        "userId": userId,
        "username": username,
        "name": name,
      };
}

class Appointment {
  Appointment({
    this.date,
    this.hour,
    this.patientAvatar,
    this.patientId,
    this.patientName,
  });

  String date;
  String hour;
  String patientAvatar;
  String patientId;
  String patientName;

  factory Appointment.fromJson(Map<dynamic, dynamic> json) => Appointment(
        date: json["date"],
        hour: json["hour"],
        patientAvatar: json["patientAvatar"],
        patientId: json["patientId"],
        patientName: json["patientName"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "hour": hour,
        "patientAvatar": patientAvatar,
        "patientId": patientId,
        "patientName": patientName,
      };
}

class AvailableAppointment {
  AvailableAppointment({
    this.availableDay,
    this.availableHours,
  });

  String availableDay;
  List<String> availableHours;

  factory AvailableAppointment.fromJson(Map<dynamic, dynamic> json) =>
      AvailableAppointment(
        availableDay: json["availableDay"],
        availableHours: List<String>.from(json["availableHours"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "availableDay": availableDay,
        "availableHours": List<dynamic>.from(availableHours.map((x) => x)),
      };
}

class Documents {
  Documents({
    this.certificate,
    this.id,
    this.candidate,
  });

  String certificate;
  String id;
  String candidate;

  factory Documents.fromJson(Map<dynamic, dynamic> json) => Documents(
        certificate: json["certificate"],
        id: json["id"],
        candidate: json["candidate"],
      );

  Map<String, dynamic> toJson() => {
        "certificate": certificate,
        "id": id,
        "candidate": candidate,
      };
}

class Review {
  Review({
    this.rating,
    this.date,
    this.review,
  });

  String rating;
  String date;
  String review;

  factory Review.fromJson(Map<dynamic, dynamic> json) => Review(
        rating: json["rating"],
        date: json["date"],
        review: json["review"],
      );

  Map<String, dynamic> toJson() => {
        "rating": rating,
        "date": date,
        "review": review,
      };
}
