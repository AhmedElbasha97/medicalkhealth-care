// import 'package:flutter/cupertino.dart';
// import 'package:med_app/models/Patient.dart';
// import 'package:med_app/repository/patient_profile_repo.dart';
// class PateintProvider extends ChangeNotifier {
//   Patient patient;
//   DatabaseRepositories _databaseRepositories = DatabaseRepositories();
//   PateintProvider({patientId, speciality, doctorId}) {
//     getPatientById(patientId);
//   }

//   void getPatientById(id) {
//     _databaseRepositories.fetchPatient(id).then((patient) {
//       this.patient = patient;
//       notifyListeners();
//     });
//   }
// }
