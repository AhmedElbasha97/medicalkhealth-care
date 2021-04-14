import 'package:flutter/material.dart';
import 'package:med_app/models/doctor.dart';
import 'package:med_app/reprositorie/database_repo.dart';

class DatabaseProvider extends ChangeNotifier {
  List<Doctor> Doctors;
  Doctor doctor;
  DatabaseRepositories databaseRepositories = DatabaseRepositories();
  DatabaseProvider({speciality, id}) {
    if (speciality != null) {
      getDoctorsBySpecialty(speciality);
    }
    if (id != null) {
      getDoctorById(id);
    }
  }

  void getDoctorsBySpecialty(speciality) {
    databaseRepositories.fetchDoctorsBySpecialty(speciality).then((doctors) {
      Doctors = doctors;
      notifyListeners();
    });
  }

  void getDoctorById(id) {
    databaseRepositories.fetchDoctor(id).then((doctor) {
      this.doctor = doctor;
      notifyListeners();
    });
  }
}
