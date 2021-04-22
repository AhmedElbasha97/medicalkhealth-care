import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/Widgets/userProfile_edit.dart';
import 'package:med_app/models/patient.dart';
import 'package:med_app/provider/app_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PatientEditInfoWidget extends StatefulWidget {
  final text;
  final color;
  final String cardLabel;
  final IconData icon;
  final String patientId;
  Patient patient;

  PatientEditInfoWidget({
    this.text,
    this.color,
    this.cardLabel,
    this.icon,
    this.patient,
    this.patientId,
  });

  @override
  _PatientInfoWidgetState createState() => _PatientInfoWidgetState();
}

class _PatientInfoWidgetState extends State<PatientEditInfoWidget> {
  bool edit = false;

  static FirebaseDatabase database = new FirebaseDatabase();

  final counterRef = database.reference().child('counter');
  DatabaseReference userRef = database.reference();
  String bloodSugar,
      bloodPreassureHigh,
      bloodPreassureLow,
      height,
      wieght,
      age,
      name;
  void updateUser() async {
    var user = userRef.child('users/${widget.patient.userId}');

    await user.update({
      'bloodSugar': (bloodSugar != null && bloodSugar.length > 0)
          ? bloodSugar
          : widget.patient.bloodSugar,
      'bloodHighPressure':
          (bloodPreassureHigh != null && bloodPreassureHigh.length > 0)
              ? bloodPreassureHigh
              : widget.patient.bloodHighPressure,
      'bloodLowPressure':
          (bloodPreassureLow != null && bloodPreassureLow.length > 0)
              ? bloodPreassureLow
              : widget.patient.bloodLowPressure,
      'height': (height != null && height.length > 0)
          ? height
          : widget.patient.height,
      'weight': (wieght != null && wieght.length > 0)
          ? wieght
          : widget.patient.weight,
      'name': (name != null && name.length > 0) ? name : widget.patient.name,
      'age': (age != null && age.length > 0) ? age : widget.patient.age,
    }).then((_) {
      print('Transaction  committed.');
      AppProvider provider = Provider.of<AppProvider>(context, listen: false);
      provider.getPatientById(widget.patient.userId);
      print("edite: ${provider.patient.name}");
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          color: ColorsCollection.splashTitleColor,
          onPressed: () => {Navigator.of(context).pop()},
        ),
        title: Row(
          children: [
            Expanded(
                flex: 4,
                child: Text('Edit  Your Profile',
                    style:
                        TextStyle(color: ColorsCollection.splashTitleColor))),
          ],
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              UserProfileInfoEditWidget(
                  keyboardTypeNumber: false,
                  callback: (val) => setState(() => name = val),
                  infoTitle: 'username  ',
                  infoValue: widget.patient.username),
              UserProfileInfoEditWidget(
                  keyboardTypeNumber: true,
                  callback: (val) => setState(() => bloodSugar = val),
                  infoTitle: 'Blood-Sugar   ',
                  infoValue: widget.patient.bloodSugar),
              UserProfileInfoEditWidget(
                  keyboardTypeNumber: true,
                  callback: (val) => setState(() => bloodPreassureHigh = val),
                  infoTitle: 'BloodPreassureHigh  ',
                  infoValue: widget.patient.bloodHighPressure),
              UserProfileInfoEditWidget(
                  keyboardTypeNumber: true,
                  callback: (val) => setState(() => bloodPreassureLow = val),
                  infoTitle: 'BloodPreassureLow   ',
                  infoValue: widget.patient.bloodLowPressure),
              UserProfileInfoEditWidget(
                  keyboardTypeNumber: true,
                  callback: (val) => setState(() => height = val),
                  infoTitle: 'Height  ',
                  infoValue: widget.patient.height),
              UserProfileInfoEditWidget(
                  keyboardTypeNumber: true,
                  callback: (val) => setState(() => wieght = val),
                  infoTitle: 'Weight  ',
                  infoValue: widget.patient.weight),
              UserProfileInfoEditWidget(
                  keyboardTypeNumber: true,
                  callback: (val) => setState(() => age = val),
                  infoTitle: 'age  ',
                  infoValue: widget.patient.age),
              Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 20, right: 20),
                    child: Divider(
                      thickness: 1,
                      color: ColorsCollection.mainColor,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        color: ColorsCollection.mainColor,
                        minWidth: MediaQuery.of(context).size.width * .45,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: ColorsCollection.mainColor,
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: Text(
                            "Update",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                        onPressed: () async {
                          updateUser();
                        },
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
