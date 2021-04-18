import 'package:flutter/material.dart';
import 'package:med_app/UI/DoctorProfile/doctor_edit_info_widget.dart';
import 'package:med_app/UI/PatientProfile/patient_info_widget.dart';
import 'package:med_app/provider/patient_provider.dart';
import 'package:provider/provider.dart';

import 'doctor_info_widget.dart';

class DoctorInfoScreen extends StatefulWidget {
  final String id;
  final String patientId;
  DoctorInfoScreen({Key key, this.id, this.patientId}) : super(key: key);

  @override
  _DoctorInfoScreenState createState() => _DoctorInfoScreenState();
}

class _DoctorInfoScreenState extends State<DoctorInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Consumer<PateintProvider>(
        builder: (context, databaseProvider, _) {
          return (databaseProvider.doctor != null)
              ? DoctorInfoWidget(doctor: databaseProvider.doctor)
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
