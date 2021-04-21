import 'package:flutter/material.dart';
import 'package:med_app/UI/PatientProfile/patient_profile_widget.dart';
import 'package:med_app/provider/app_provider.dart';
import 'package:provider/provider.dart';

class PatientProfile extends StatefulWidget {
  final String id;
  final String patientId;
  final bool navigateFromOtherScreen;
  PatientProfile({Key key, this.id, this.patientId, this.navigateFromOtherScreen=false}) : super(key: key);

  @override
  _PatientProfileState createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("patient profile");
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Consumer<AppProvider>(
        builder: (context, appProvider, _) {
          return (appProvider.patient != null)
              ? PatientProfileWidget(patient: appProvider.patient, navigateFromAnotherScreen: widget.navigateFromOtherScreen,)
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
