import 'package:flutter/material.dart';
import 'package:med_app/provider/app_provider.dart';
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
    print("doc profile");
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Consumer<AppProvider>(
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
