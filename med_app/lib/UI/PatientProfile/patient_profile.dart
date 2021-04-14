import 'package:flutter/material.dart';
import 'package:med_app/UI/PatientProfile/patient_profile_widget.dart';
import 'package:med_app/provider/patient_provider.dart';
import 'package:provider/provider.dart';

class PatientProfile extends StatefulWidget {
  final String id;
  final String patientId;
  PatientProfile({Key key, this.id, this.patientId}) : super(key: key);

  @override
  _PatientProfileState createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Consumer<DatabaseProvider>(
        builder: (context, databaseProvider, _) {
          return (databaseProvider.patient != null)
              ? PatientProfileWidget(patient: databaseProvider.patient)
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
