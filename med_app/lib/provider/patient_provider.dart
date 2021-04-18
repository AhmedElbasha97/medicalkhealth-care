import 'package:flutter/cupertino.dart';
import 'package:med_app/models/Patient.dart';
import 'package:med_app/models/doctor.dart';
import 'package:med_app/repository/patient_profile_repo.dart';

class PateintProvider extends ChangeNotifier {
  Patient patient;
  Doctor doctor;
  DatabaseRepositories _databaseRepositories = DatabaseRepositories();
  PateintProvider({patientId, speciality, doctorId}) {
    if (doctorId != null) {
      getDoctorById(doctorId);
    }
    if (patientId != null) {
      getPatientById(patientId);
    }
  }

  void getPatientById(id) {
    _databaseRepositories.fetchPatient(id).then((patient) {
      this.patient = patient;
      notifyListeners();
    });
  }

  void getDoctorById(id) {
    _databaseRepositories.fetchDoctor(id).then((doctor) {
      this.doctor = doctor;
      notifyListeners();
    });
  }
}
