import 'package:flutter/cupertino.dart';
import 'package:med_app/models/doctor.dart';
import 'package:med_app/reprositorie/database_repo.dart';

class DatabaseProvider extends ChangeNotifier {
  List<Doctor> Doctors;
  Doctor doctor;
  DatabaseRepositories _database_repositorie = DatabaseRepositories();
  DatabaseProvider({speciality, id}) {
    if (speciality!=null) {
      getDoctorsBySpecialty(speciality);
    } else if (id!=null) {
      getDoctorById(id);
    }
  }

  void getDoctorsBySpecialty(speciality) {
    _database_repositorie.fetchDoctorsBySpecialty(speciality).then((doctors) {
      Doctors = doctors;
      notifyListeners();
    });
  }

  void getDoctorById(id) {
    _database_repositorie.fetchDoctor(id).then((doctor) {
      this.doctor = doctor;
      notifyListeners();
    });
  }
}
