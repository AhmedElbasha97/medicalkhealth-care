import 'package:med_app/models/doctor.dart';
import 'package:med_app/services/database.dart';
import 'package:med_app/services/patient_profile.dart';

class DatabaseRepositories {
  PatientService _patientService = PatientService();
  DoctorService _doctorService = DoctorService();

  Future<dynamic> fetchPatient(id) {
    return _patientService.fetchPatient(id);
  }

  Future<List<Doctor>> fetchDoctorsBySpecialty(speciality) {
    return _doctorService.fetchDoctorsBySpecialty(speciality);
  }

  Future<Doctor> fetchDoctor(id) {
    return _doctorService.fetchDoctor(id);
  }
}
