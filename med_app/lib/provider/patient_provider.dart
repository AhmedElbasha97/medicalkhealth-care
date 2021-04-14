import 'package:flutter/cupertino.dart';
import 'package:med_app/models/Patient.dart';
import 'package:med_app/repository/patient_profile_repo.dart';

class PaitentDatabaseProvider extends ChangeNotifier {
  Patient patient;
  DatabaseRepositories _databaseRepositories = DatabaseRepositories();
  PaitentDatabaseProvider(id) {
    getPatientById(id);
    notifyListeners();
  }

  void getPatientById(id) {
    _databaseRepositories.fetchPatient(id).then((patient) {
      this.patient = patient;
      notifyListeners();
    });
  }
}
