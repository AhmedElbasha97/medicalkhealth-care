import 'package:flutter/cupertino.dart';
import 'package:med_app/models/doctor.dart';
import 'package:med_app/repository/patient_profile_repo.dart';

class DoctorProvider extends ChangeNotifier {
  List<Doctor> doctors;
  Doctor doctor;
  DatabaseRepositories _databaseRepositories = DatabaseRepositories();
  DoctorProvider({speciality, doctorId}) {
    if (speciality != null) {
      getDoctorsBySpecialty(speciality);
    }
    if (doctorId != null) {
      getDoctorById(doctorId);
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
}
