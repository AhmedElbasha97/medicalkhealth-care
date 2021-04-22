import 'package:flutter/cupertino.dart';
import 'package:med_app/models/doctor.dart';
import 'package:med_app/models/patient.dart';
import 'package:med_app/models/token.dart';
import 'package:med_app/repository/database_repo.dart';

class AppProvider extends ChangeNotifier {
  String userId;
  List<Doctor> doctors;
  Doctor doctor;
  Patient patient;
  String doctorName;
  Token token;
  String type;
  bool logout = false;
  List<PatientAppointment> patientAppointments;
  List<DoctorAppointment> doctorAppointments;
  DatabaseRepositories _databaseRepositories = DatabaseRepositories();
  AppProvider({patientId, speciality, doctorId, userId}) {
    if (userId != null) {
      getUserType(userId);
    }
    if (speciality != null) {
      getDoctorsBySpecialty(speciality);
    }
    if (doctorId != null) {
      getDoctorById(doctorId);
    }
    if (patientId != null) {
      getPatientById(patientId);
    }
    if (doctorName != null) {
      generateToken(doctorName);
    }
  }

  void getDoctorsBySpecialty(speciality) {
    _databaseRepositories.fetchDoctorsBySpecialty(speciality).then((doctors) {
      this.doctors = doctors;
      notifyListeners();
    });
  }

  void getDoctorById(id) {
    _databaseRepositories.fetchDoctor(id).then((doctor) {
      this.doctor = doctor;
      this.doctorAppointments = doctor.appointment;
      this.userId = this.doctor.userId;
      notifyListeners();
    });
  }

  void getPatientById(id) {
    _databaseRepositories.fetchPatient(id).then((patient) {
      this.patient = patient;
      this.patientAppointments = this.patient.appointment;
      this.userId = this.patient.userId;
      notifyListeners();
    });
  }

  void generateToken(doctorName) {
    _databaseRepositories.generateToken(doctorName).then((token) {
      this.token = token;
      notifyListeners();
    });
  }

  // void getPatientApointmentlen(){
  //     notifyListeners();
  // }
  void getUserType(userId) {
    this.logout = false;

    _databaseRepositories.getUserType(userId).then((value) {
      this.type = value;
      print("prov $userId");
      print("prov type: ${this.type}");
      if (type == "patient") {
        getPatientById(userId);
      } else {
        getDoctorById(userId);
      }
    });
  }

  void clear() {
    this.patient = null;
    this.doctor = null;
    this.type = null;
    this.logout = true;
  }

  void refresh() {
    notifyListeners();
  }

//  void getParent(id){
//    _databaseRepositories.getParent(id).then((value) {print(value);});

//  }

}
