import 'package:flutter/material.dart';
import 'package:med_app/UI/PatientProfile/patient_profile_widget.dart';
import 'package:med_app/provider/patient_provider.dart';
import 'package:provider/provider.dart';

import 'doctor_profile_widget.dart';

class DcotorProfile extends StatefulWidget {
  final String id;
  final String patientId;
  DcotorProfile({Key key, this.id, this.patientId}) : super(key: key);

  @override
  _DcotorProfileState createState() => _DcotorProfileState();
}

class _DcotorProfileState extends State<DcotorProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Consumer<PateintProvider>(
        builder: (context, databaseProvider, _) {
          return (databaseProvider.doctor != null)
              ? DoctorProfileWidget(doctor: databaseProvider.doctor)
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
