import 'dart:convert';

import 'package:intl/intl.dart';

Patient patientFromJson(String str) => Patient.fromJson(json.decode(str));

String patientToJson(Patient data) => json.encode(data.toJson());

class Patient {
  Patient({
    this.age,
    this.appointment,
    this.balance,
    this.bloodHighPressure,
    this.bloodLowPressure,
    this.bloodSugar,
    this.email,
    this.gender,
    this.height,
    this.medicalNotes,
    this.name,
    this.userAvatar,
    this.userId,
    this.username,
    this.weight,
  });

  String age;
  List<Appointment> appointment;
  String balance;
  String bloodHighPressure;
  String bloodLowPressure;
  String bloodSugar;
  String email;
  String gender;
  String height;
  List<String> medicalNotes;
  String name;
  String userAvatar;
  String userId;
  String username;
  String weight;

  factory Patient.fromJson(Map<dynamic, dynamic> json) => Patient(
        age: json["age"],
        appointment: (json.keys.contains('appointment'))
            ? List<Appointment>.from(
                json["appointment"].map((x) => Appointment.fromJson(x)))
            : [],
        balance: json["balance"],
        bloodHighPressure: json["bloodHighPressure"],
        bloodLowPressure: json["bloodLowPressure"],
        bloodSugar: json["bloodSugar"],
        email: json["email"],
        gender: json["gender"],
        height: json["height"],
        medicalNotes: (json.keys.contains('medicalNotes'))
            ? List<String>.from(json["medicalNotes"])
            : [],
        name: json["name"],
        userAvatar: json["userAvatar"],
        userId: json["userId"],
        username: json["username"],
        weight: json["weight"],
      );

  Map<dynamic, dynamic> toJson() => {
        "age": age,
        "appointment": List<dynamic>.from(appointment.map((x) => x.toJson())),
        "balance": balance,
        "bloodHighPressure": bloodHighPressure,
        "bloodLowPressure": bloodLowPressure,
        "bloodSugar": bloodSugar,
        "email": email,
        "gender": gender,
        "height": height,
        "medicalNotes": List<dynamic>.from(medicalNotes.map((x) => x)),
        "name": name,
        "userAvatar": userAvatar,
        "userId": userId,
        "username": username,
        "weight": weight,
      };
}

class Appointment {
  Appointment(
      {this.callMethod,
      this.day,
      this.doctorAvatar,
      this.doctorId,
      this.doctorName,
      this.hour,
      this.paymentMethod,
      this.fees,
      this.symptoms,
      this.caseFile,
      this.doctorSpeciality});

  String callMethod;
  String day;
  String doctorAvatar;
  String doctorId;
  String doctorName;
  String hour;
  String paymentMethod;
  String caseFile;
  String doctorSpeciality;
  String fees;
  String symptoms;

  factory Appointment.fromJson(Map<dynamic, dynamic> json) => Appointment(
      callMethod: json["callMethod"],
      day: json["date"],
      doctorAvatar: json["doctorAvatar"],
      doctorId: json["doctorId"],
      doctorName: json["doctorName"],
      hour: json["hour"],
      paymentMethod: json['paymentMethod'],
      caseFile: json['caseFile'],
      fees: json['fees'],
      symptoms: json['symptoms'],
      doctorSpeciality: json['doctorSpeciality']);

  Map<dynamic, dynamic> toJson() => {
        "callMethod": callMethod,
        "date": day,
        "doctorAvatar": doctorAvatar,
        "doctorId": doctorId,
        "doctorName": doctorName,
        "hour": hour,
        "paymentMethod": paymentMethod,
        "caseFile": caseFile,
        "doctorSpeciality": doctorSpeciality,
        "fees": fees,
        "symptoms": symptoms
      };
}
