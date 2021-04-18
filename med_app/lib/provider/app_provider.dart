import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:med_app/models/doctor.dart';
import 'package:med_app/models/patient.dart';
import 'package:med_app/models/token.dart';
import 'package:med_app/repository/database_repo.dart';
import 'package:med_app/services/auth.dart';

class AppProvider extends ChangeNotifier {
  String userId;
  List<Doctor> doctors;
  Doctor doctor;
  Patient patient;
  String doctorName;
  Token token;
  String type;
  List<PatientAppointment> patientAppointments;
  List<DoctorAppointment> doctorAppointments; 
  DatabaseRepositories _databaseRepositories = DatabaseRepositories();
  AppProvider({patientId, speciality, doctorId,userId}) {
   
    if(userId!=null){  getUserType(userId);}

    if (speciality != null) {
      getDoctorsBySpecialty(speciality);
    }
    if (doctorId != null) {
      getDoctorById(doctorId);
    }
    if (patientId != null) {
      getPatientById(patientId);
    }
    if(doctorName!=null){
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
      this.doctorAppointments=doctor.appointment;
      notifyListeners();
    });
  }

  void getPatientById(id) {
    _databaseRepositories.fetchPatient(id).then((patient) {
      this.patient = patient;
      this.patientAppointments=this.patient.appointment;
      notifyListeners();
    });
  }
  void generateToken(doctorName){
    _databaseRepositories.generateToken(doctorName).then((token){
      this.token=token;
      notifyListeners();
    });
  }
  // void getPatientApointmentlen(){
  //     notifyListeners();
  // }
void getUserType(userId){
  print("prov $userId");
    _databaseRepositories.getUserType(userId).then((value)
    { 
          this.type=value;
          print("type:$type");
          if(type=="doctor"){
            getDoctorById(userId);
          }
          else{
            getPatientById(userId);
          }
    });

}

//  void getParent(id){
//    _databaseRepositories.getParent(id).then((value) {print(value);});

//  }
  
}
