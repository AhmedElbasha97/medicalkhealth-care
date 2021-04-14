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
    this.age,
    this.gender,
    this.bio,
    this.experience,
    this.languages,
    this.balance,
    this.fees,
    this.rating,
    this.reviews,
    this.userAvatar,
    this.documents,
    this.callMethods,
    this.email,
    this.profession,
    this.speciality,
    this.userId,
    this.username,
    this.name,
  });

  List<Appointment> appointment;
  List<AvailableAppointment> availableAppointment;
  String age;
  String gender;
  String bio;
  String experience;
  List<String> languages;
  String balance;
  String fees;
  String rating;
  List<Review> reviews;
  String userAvatar;
  Documents documents;
  CallMethods callMethods;
  String email;
  String profession;
  String speciality;
  String userId;
  String username;
  String name;

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        appointment: List<Appointment>.from(
            json["appointment"].map((x) => Appointment.fromJson(x))),
        availableAppointment: List<AvailableAppointment>.from(
            json["availableAppointment"]
                .map((x) => AvailableAppointment.fromJson(x))),
        age: json["age"],
        gender: json["gender"],
        bio: json["bio"],
        experience: json["experience"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        balance: json["balance"],
        fees: json["fees"],
        rating: json["rating"],
        reviews:
            List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
        userAvatar: json["userAvatar"],
        documents: Documents.fromJson(json["documents"]),
        callMethods: CallMethods.fromJson(json["callMethods"]),
        email: json["email"],
        profession: json["profession"],
        speciality: json["speciality"],
        userId: json["userId"],
        username: json["username"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "appointment": List<dynamic>.from(appointment.map((x) => x.toJson())),
        "availableAppointment":
            List<dynamic>.from(availableAppointment.map((x) => x.toJson())),
        "age": age,
        "gender": gender,
        "bio": bio,
        "experience": experience,
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "balance": balance,
        "fees": fees,
        "rating": rating,
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
        "userAvatar": userAvatar,
        "documents": documents.toJson(),
        "callMethods": callMethods.toJson(),
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
    this.callMethod,
  });

  String date;
  String hour;
  String patientAvatar;
  String patientId;
  String patientName;
  String callMethod;

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        date: json["date"],
        hour: json["hour"],
        patientAvatar: json["patientAvatar"],
        patientId: json["patientId"],
        patientName: json["patientName"],
        callMethod: json["callMethod"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "hour": hour,
        "patientAvatar": patientAvatar,
        "patientId": patientId,
        "patientName": patientName,
        "callMethod": callMethod,
      };
}

class AvailableAppointment {
  AvailableAppointment({
    this.availableDay,
    this.availableHours,
  });

  String availableDay;
  List<String> availableHours;

  factory AvailableAppointment.fromJson(Map<String, dynamic> json) =>
      AvailableAppointment(
        availableDay: json["availableDay"],
        availableHours: List<String>.from(json["availableHours"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "availableDay": availableDay,
        "availableHours": List<dynamic>.from(availableHours.map((x) => x)),
      };
}

class CallMethods {
  CallMethods({
    this.chat,
    this.voice,
    this.video,
  });

  bool chat;
  bool voice;
  bool video;

  factory CallMethods.fromJson(Map<String, dynamic> json) => CallMethods(
        chat: json["chat"],
        voice: json["voice"],
        video: json["video"],
      );

  Map<String, dynamic> toJson() => {
        "chat": chat,
        "voice": voice,
        "video": video,
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

  factory Documents.fromJson(Map<String, dynamic> json) => Documents(
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

  factory Review.fromJson(Map<String, dynamic> json) => Review(
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
