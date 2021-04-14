import 'package:med_app/services/patient_profile.dart';

class DatabaseRepositories {
  DataBaseService _patientService = DataBaseService();

  Future<dynamic> fetchPatient(id) {
    return _patientService.fetchPatient(id);
  }
}
