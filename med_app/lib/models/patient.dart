// class Patient {
//   Patient({
//     this.age,
//     this.appointment,
//     this.balance,
//     this.bloodHighPressure,
//     this.bloodLowPressure,
//     this.bloodSuagr,
//     this.email,
//     this.gender,
//     this.height,
//     this.medicalNotes,
//     this.name,
//     this.userAvatar,
//     this.userId,
//     this.username,
//     this.weight,
//   });

//   String age;
//   List<Appointment> appointment;
//   String balance;
//   String bloodHighPressure;
//   String bloodLowPressure;
//   String bloodSuagr;
//   String email;
//   String gender;
//   String height;
//   List<dynamic> medicalNotes;
//   String name;
//   String userAvatar;
//   String userId;
//   String username;
//   String weight;
// }

// class Appointment {
//   Appointment({
//     this.date,
//     this.doctorAvatar,
//     this.doctorId,
//     this.doctorName,
//     this.hour,
//   });

//   String date;
//   String doctorAvatar;
//   String doctorId;
//   String doctorName;
//   String hour;

//   factory Appointment.fromJson(Map<dynamic, dynamic> json) => Appointment(
//         date: json["date"],
//         doctorAvatar: json["doctorAvatar"],
//         doctorId: json["doctorId"],
//         doctorName: json["doctorName"],
//         hour: json["hour"],
//       );

//   Map<dynamic, dynamic> toJson() => {
//         "date": date,
//         "doctorAvatar": doctorAvatar,
//         "doctorId": doctorId,
//         "doctorName": doctorName,
//         "hour": hour,
//       };
// }

// To parse this JSON data, do
//
//     final patient = patientFromJson(jsonString);

import 'dart:convert';

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
            ? List<Appointment>.from(
                json["medicalNotes"].map((x) => Appointment.fromJson(x)))
            : [],
        // medicalNotes: List<String>.from(json["medicalNotes"].map((x) => x)),
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
  Appointment({
    this.callMethod,
    this.date,
    this.doctorAvatar,
    this.doctorId,
    this.doctorName,
    this.hour,
  });

  String callMethod;
  String date;
  String doctorAvatar;
  String doctorId;
  String doctorName;
  String hour;

  factory Appointment.fromJson(Map<dynamic, dynamic> json) => Appointment(
        callMethod: json["callMethod"],
        date: json["date"],
        doctorAvatar: json["doctorAvatar"],
        doctorId: json["doctorId"],
        doctorName: json["doctorName"],
        hour: json["hour"],
      );

  Map<dynamic, dynamic> toJson() => {
        "callMethod": callMethod,
        "date": date,
        "doctorAvatar": doctorAvatar,
        "doctorId": doctorId,
        "doctorName": doctorName,
        "hour": hour,
      };
}
