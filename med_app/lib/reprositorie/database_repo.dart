import 'package:med_app/models/doctor.dart';
import 'package:med_app/services/database.dart';

class DatabaseRepositories {
  DataBaseService _doctorService = DataBaseService();
  Future<List<Doctor>> fetchDoctorsBySpecialty(speciality) {
    return _doctorService.fetchDoctorsBySpecialty(speciality);
  }
  Future<dynamic> fetchDoctor(id) {
    return _doctorService.fetchDoctor(id);
  }
}