import 'package:flutter/material.dart';
import 'package:med_app/provider/app_provider.dart';
import 'package:provider/provider.dart';

import 'doctor_profile_widget.dart';

class DoctorProfile extends StatefulWidget {
  final String id;
  final String patientId;
  final navigateFromOtherScreen;
  DoctorProfile({Key key, this.id, this.patientId, this.navigateFromOtherScreen=false, }) : super(key: key);

  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  @override
  Widget build(BuildContext context) {
    print("doc profile");
    return WillPopScope(
  onWillPop: () async => widget.navigateFromOtherScreen,
          child: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: Consumer<AppProvider>(
          builder: (context, databaseProvider, _) {
            return (databaseProvider.doctor != null)
                ? DoctorProfileWidget(doctor: databaseProvider.doctor, navigateOtherScreen: widget.navigateFromOtherScreen, )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}
