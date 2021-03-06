import 'package:firebase_database/firebase_database.dart';
import 'package:med_app/models/doctor.dart';

class DoctorService {
  static FirebaseDatabase database = new FirebaseDatabase();

  final ref = FirebaseDatabase.instance.reference();

  Future<List<Doctor>> fetchDoctorsBySpecialty(speciality) async {
    Map<dynamic, dynamic> values;
    List<Doctor> doctors = [];
    await ref
        .child('users/')
        .orderByChild("speciality")
        .equalTo(speciality)
        .once()
        .then((DataSnapshot data) {
      values = data.value;
    });
    if (values != null) {
      values.forEach((key, values) {
        doctors.add(Doctor.fromJson(values));
      });
      return doctors;
    } else {
      return null;
    }
  }

  Future<Doctor> fetchDoctor(id) async {
    Map<dynamic, dynamic> values;
    Doctor doctor;
    await ref.child('users/$id').once().then((DataSnapshot data) {
      values = data.value;
    });
    if (values != null) {
      doctor = Doctor.fromJson(values);
      return doctor;
    } else {
      return null;
    }
  }

  Future<String> getUserType(id) async {
    var user;
    await ref
        .child('users/$id')
        .child("userType")
        .once()
        .then((DataSnapshot data) {
      user = data.value;
    });
    if (user != null) {
      return user;
    } else {
      return null;
    }
  }
}
