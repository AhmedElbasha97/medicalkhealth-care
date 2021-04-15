import 'package:flutter/material.dart';
import 'package:med_app/UI/PatientProfile/patient_info_widget.dart';
import 'package:med_app/provider/app_provider.dart';
import 'package:med_app/provider/patient_provider.dart';
import 'package:provider/provider.dart';

class PatientInfoScreen extends StatefulWidget {
  final String id;
  final String patientId;
  PatientInfoScreen({Key key, this.id, this.patientId}) : super(key: key);

  @override
  _PatientInfoScreenState createState() => _PatientInfoScreenState();
}

class _PatientInfoScreenState extends State<PatientInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Consumer<AppProvider>(
        builder: (context, appProvider, _) {
          return (appProvider.patient != null)
              ? PatientInfoWidget(patient:appProvider.patient)
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
