// To parse this JSON data, do
//
//     final patient = patientFromJson(jsonString);

import 'dart:convert';

Patient patientFromJson(String str) => Patient.fromJson(json.decode(str));

String patientToJson(Patient data) => json.encode(data.toJson());

class Patient {
  Patient({
    this.appointment,
    this.bloodSugar,
    this.bloodHighPressure,
    this.bloodLowPressure,
    this.email,
    this.height,
    this.age,
    this.gender,
    this.medicalNotes,
    this.userAvatar,
    this.balance,
    this.userId,
    this.weight,
    this.username,
    this.name,
  });

  List<Appointment> appointment;
  String bloodSugar;
  String bloodHighPressure;
  String bloodLowPressure;
  String email;
  String height;
  String age;
  String gender;
  List<String> medicalNotes;
  String userAvatar;
  String balance;
  String userId;
  String weight;
  String username;
  String name;

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        appointment: List<Appointment>.from(
            json["appointment"].map((x) => Appointment.fromJson(x))),
        bloodSugar: json["bloodSugar"],
        bloodHighPressure: json["bloodHighPressure"],
        bloodLowPressure: json["bloodLowPressure"],
        email: json["email"],
        height: json["height"],
        age: json["age"],
        gender: json["gender"],
        medicalNotes: List<String>.from(json["medicalNotes"].map((x) => x)),
        userAvatar: json["userAvatar"],
        balance: json["balance"],
        userId: json["userId"],
        weight: json["weight"],
        username: json["username"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "appointment": List<dynamic>.from(appointment.map((x) => x.toJson())),
        "bloodSugar": bloodSugar,
        "bloodHighPressure": bloodHighPressure,
        "bloodLowPressure": bloodLowPressure,
        "email": email,
        "height": height,
        "age": age,
        "gender": gender,
        "medicalNotes": List<dynamic>.from(medicalNotes.map((x) => x)),
        "userAvatar": userAvatar,
        "balance": balance,
        "userId": userId,
        "weight": weight,
        "username": username,
        "name": name,
      };
}

class Appointment {
  Appointment({
    this.date,
    this.hour,
    this.doctorAvatar,
    this.doctorId,
    this.doctorName,
    this.callMethod,
  });

  String date;
  String hour;
  String doctorAvatar;
  String doctorId;
  String doctorName;
  String callMethod;

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        date: json["date"],
        hour: json["hour"],
        doctorAvatar: json["doctorAvatar"],
        doctorId: json["doctorId"],
        doctorName: json["doctorName"],
        callMethod: json["callMethod"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "hour": hour,
        "doctorAvatar": doctorAvatar,
        "doctorId": doctorId,
        "doctorName": doctorName,
        "callMethod": callMethod,
      };
}
