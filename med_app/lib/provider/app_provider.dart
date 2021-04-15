import 'package:flutter/cupertino.dart';
import 'package:med_app/models/doctor.dart';
import 'package:med_app/models/patient.dart';
import 'package:med_app/repository/patient_profile_repo.dart';

class AppProvider extends ChangeNotifier {
  List<Doctor> doctors;
  Doctor doctor;
  Patient patient;

  DatabaseRepositories _databaseRepositories = DatabaseRepositories();
  AppProvider({patientId, speciality, doctorId}) {
    if (speciality != null) {
      getDoctorsBySpecialty(speciality);
    }
    if (doctorId != null) {
      getDoctorById(doctorId);
    }
    if (patientId != null) {
      getPatientById(patientId);
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
      notifyListeners();
    });
  }

  void getPatientById(id) {
    _databaseRepositories.fetchPatient(id).then((patient) {
      this.patient = patient;
      print(patient);
      notifyListeners();
    });
  }
}
