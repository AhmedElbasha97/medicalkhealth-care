import 'package:firebase_database/firebase_database.dart';
import 'package:med_app/models/doctor.dart';

class DataBaseService {
  static FirebaseDatabase database = new FirebaseDatabase();

  final ref = FirebaseDatabase.instance.reference();


  Future<List<Doctor>> fetchDoctorsBySpecialty(speciality) async {
    Map<dynamic, dynamic> values;
    List<Map<dynamic, dynamic>> retrievedName = [];
    List<Doctor> doctors = [];

    await ref
        .child('Uesrs/Doctors')
        .orderByChild("Speciality")
        .equalTo(speciality)
        .once()
        .then((DataSnapshot data) {
      values = data.value;
      
    });
    if (values != null) {
        values.forEach((key, values) {
          retrievedName.add(values);
     
  
          doctors.add(Doctor(
            appointment:
                (values["Appointment"] != "") ? values["Appointment"] : [],
            appointmentAv: (values["Appointment-AV"] != "")
                ? values["Appointment-AV"]
                : [],
            bio: values["Bio"],
            documents: Documents(
                candidate: values["Documents"]["Candidate"],
                certificate: values["Documents"]["Certificate"],
                id: values["Documents"]["ID"]),
            speciality: values["Speciality"],
            doctorAvatare: (values["Doctor-Avatar"]!="")? values["Doctor-Avatar"]:"https://toppng.com/uploads/preview/roger-berry-avatar-placeholder-11562991561rbrfzlng6h.png",
            userId: values["User-Id"],
            nameUser: values["name-user"],
          ));
        });
        print(doctors);
      return doctors;
      }
      else{
         return null;
      }
    
    
  
  }

Future<Doctor> fetchDoctor(id) async {
    Map<dynamic, dynamic> values;
    Map<dynamic, dynamic> retrievedName ;
    Doctor doctor ;

    await ref
        .child('Uesrs/Doctors')
        .orderByChild("User-Id")
        .equalTo(id)
        .once()
        .then((DataSnapshot data) {
      values = data.value;
      if (values != null) {
        values.forEach((key, values) {
          retrievedName=values;
          doctor=Doctor(
            appointment:
                (values["Appointment"] != "") ? values["Appointment"] : [],
            appointmentAv: (values["Appointment-AV"] != "")
                ? values["Appointment-AV"]
                : [],
            bio: values["Bio"],
            documents: Documents(
                candidate: values["Documents"]["Candidate"],
                certificate: values["Documents"]["Certificate"],
                id: values["Documents"]["ID"]),
            speciality: values["Speciality"],
            doctorAvatare:(values["Doctor-Avatar"]!="")? values["Doctor-Avatar"]:"https://toppng.com/uploads/preview/roger-berry-avatar-placeholder-11562991561rbrfzlng6h.png",
            userId: values["User-Id"],
            nameUser: values["nameUser"],
          );
        });
        print(doctor);
      return doctor;
      }
      else{
            throw Exception('FAILED TO Fetch doctor with this $id');
        
      }
    });
  }
}
