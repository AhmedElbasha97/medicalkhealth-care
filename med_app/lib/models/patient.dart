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
  List<PatientAppointment> appointment;
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
            ? List<PatientAppointment>.from(
                json["appointment"].map((x) => PatientAppointment.fromJson(x)))
            : [],
        balance: json["balance"],
        bloodHighPressure: json["bloodHighPressure"],
        bloodLowPressure: json["bloodLowPressure"],
        bloodSugar: json["bloodSugar"],
        email: json["email"],
        gender: json["gender"],
        height: json["height"],
        medicalNotes:
            (json.keys.contains('medicalNotes')) ? List<String>.from(json["medicalNotes"].map((x) => x)) : [],
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

// To parse this JSON data, do
//
//     final apointment = apointmentFromJson(jsonString);

class PatientAppointment {
    PatientAppointment({
        this.callMethod,
        this.channelName,
        this.date,
        this.doctorAvatar,
        this.doctorId,
        this.doctorName,
        this.hour,
        this.patientPhoneNum,
        this.paymentMethod,
        this.symptoms,
        this.token,
    });

    String callMethod;
    String channelName;
    String date;
    String doctorAvatar;
    String doctorId;
    String doctorName;
    String hour;
    String patientPhoneNum;
    String paymentMethod;
    String symptoms;
    String token;

    factory PatientAppointment.fromJson(Map<dynamic, dynamic> json) => PatientAppointment(
        callMethod: json["callMethod"]  ,
        channelName: json["channelName"],
        date: json["date"],
        doctorAvatar: json["doctorAvatar"],
        doctorId: json["doctorId"],
        doctorName: json["doctorName"],
        hour: json["hour"],
        patientPhoneNum: json["patientPhoneNum"],
        paymentMethod: json["paymentMethod"],
        symptoms: json["symptoms"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "callMethod": callMethod,
        "channelName": channelName,
        "date": date,
        "doctorAvatar": doctorAvatar,
        "doctorId": doctorId,
        "doctorName": doctorName,
        "hour": hour,
        "patientPhoneNum": patientPhoneNum,
        "paymentMethod": paymentMethod,
        "symptoms": symptoms,
        "token": token,
    };
}


