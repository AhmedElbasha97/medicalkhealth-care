import 'package:med_app/models/doctor.dart';
import 'package:med_app/models/patient.dart';
import 'package:med_app/models/token.dart';
import 'package:med_app/services/callservice.dart';
import 'package:med_app/services/database.dart';
import 'package:med_app/services/patient_profile.dart';

class DatabaseRepositories {
  PatientService _patientService = PatientService();
  DoctorService _doctorService = DoctorService();
  CallService _callService =CallService();
  
  Future<Patient> fetchPatient(id) {
    return _patientService.fetchPatient(id);
  }

  Future<List<Doctor>> fetchDoctorsBySpecialty(speciality) {
    return _doctorService.fetchDoctorsBySpecialty(speciality);
  }

  Future<Doctor> fetchDoctor(id) {
    return _doctorService.fetchDoctor(id);
  }
  Future<Token> generateToken(docrorName){
    return _callService.generateToken(docrorName);
  }
  Future<String> getUserType(id){
    return _doctorService.getUserType(id);
  }


}
