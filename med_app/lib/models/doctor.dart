
import 'dart:convert';

// Doctor doctorFromJson(String str) => Doctor.fromJson(json.decode(str));

// String doctorToJson(Doctor data) => json.encode(data.toJson());

class Doctor {
    Doctor({
        this.appointment,
        this.appointmentAv,
        this.bio,
        this.documents,
        this.email,
        this.profession,
        this.speciality,
        this.userId,
        this.doctorAvatare,
        this.nameUser,
    });

    List<Appointment> appointment;
    List<AppointmentAv> appointmentAv;
    String bio;
    Documents documents;
    String email;
    String profession;
    String speciality;
    String userId;
    String doctorAvatare;
    String nameUser;

    // factory Doctor.fromJson(Map<dynamic, dynamic> json) => Doctor(
    //     appointment: List<Appointment>.from(json["Appointment"].map((x) => Appointment.fromJson(x))),
    //     appointmentAv: List<AppointmentAv>.from(json["Appointment-AV"].map((x) => AppointmentAv.fromJson(x))),
    //     bio: json["Bio"],
    //     documents: Documents.fromJson(json["Documents"]),
    //     email: json["Email"],
    //     profession: json["Profession"],
    //     speciality: json["Speciality"],
    //     userId: json["User-Id"],
    //     doctorAvatare: json["doctor-avatare"],
    //     nameUser: json["name-user"],
    // );

    // Map<String, dynamic> toJson() => {
    //     "Appointment": List<dynamic>.from(appointment.map((x) => x.toJson())),
    //     "Appointment-AV": List<dynamic>.from(appointmentAv.map((x) => x.toJson())),
    //     "Bio": bio,
    //     "Documents": documents.toJson(),
    //     "Email": email,
    //     "Profession": profession,
    //     "Speciality": speciality,
    //     "User-Id": userId,
    //     "doctor-avatare": doctorAvatare,
    //     "name-user": nameUser,
    // };
}

class Appointment {
    Appointment({
        this.appointmentTime,
        this.avatarPath,
        this.patientId,
        this.patientName,
    });

    String appointmentTime;
    String avatarPath;
    int patientId;
    String patientName;

    factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        appointmentTime: json["Appointment-time"],
        avatarPath: json["Avatar-Path"],
        patientId: json["Patient-ID"],
        patientName: json["Patient-Name"],
    );

    Map<String, dynamic> toJson() => {
        "Appointment-time": appointmentTime,
        "Avatar-Path": avatarPath,
        "Patient-ID": patientId,
        "Patient-Name": patientName,
    };
}

class AppointmentAv {
    AppointmentAv({
        this.appointmentAv,
        this.availablity,
    });

    String appointmentAv;
    bool availablity;

    factory AppointmentAv.fromJson(Map<String, dynamic> json) => AppointmentAv(
        appointmentAv: json["Appointment-av"],
        availablity: json["Availablity"],
    );

    Map<String, dynamic> toJson() => {
        "Appointment-av": appointmentAv,
        "Availablity": availablity,
    };
}

class Documents {
    Documents({
        this.candidate,
        this.certificate,
        this.id,
    });

    String candidate;
    String certificate;
    String id;

    factory Documents.fromJson(Map<String, dynamic> json) => Documents(
        candidate: json["Candidate"],
        certificate: json["Certificate"],
        id: json["ID"],
    );

    Map<String, dynamic> toJson() => {
        "Candidate": candidate,
        "Certificate": certificate,
        "ID": id,
    };
}


