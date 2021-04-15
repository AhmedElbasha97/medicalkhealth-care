import 'package:firebase_database/firebase_database.dart';
import 'package:med_app/models/patient.dart';


class PatientService {
  static FirebaseDatabase database = new FirebaseDatabase();

  final ref = FirebaseDatabase.instance.reference();

  Future<Patient> fetchPatient(userId) async {
    Map<dynamic, dynamic> values;
    Patient patient;

    await ref
        .child('users/patients/VO2CnrLJfJRb0sEKUH3ncNTGmgA2')
        .once()
        .then((DataSnapshot data) {
      values = data.value;
      print(values);
    });
    if (values != null) {
      patient = Patient.fromJson(values);

      print(patient);
      return patient;
    } else {
      return null;
    }
  }
}
