import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med_app/UI/PatientProfile/patient_edit_info_widget.dart';

import 'package:med_app/models/Patient.dart';
import 'package:flutter/cupertino.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/Widgets/userProfile_info_widget.dart';

// ignore: must_be_immutable
class PatientInfoWidget extends StatefulWidget {
  final text;
  final color;
  final String cardLabel;
  final IconData icon;
  final buttonNavigation;
  Patient patient;

  PatientInfoWidget(
      {this.text,
      this.color,
      this.cardLabel,
      this.icon,
      this.patient,
      this.buttonNavigation});

  @override
  _PatientInfoWidgetState createState() => _PatientInfoWidgetState();
}

class _PatientInfoWidgetState extends State<PatientInfoWidget> {
  bool changePassword = false;
  String _newPassword;

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
                  child: Text('Profile Information',
                      style:
                          TextStyle(color: ColorsCollection.splashTitleColor))),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  child: Icon(
                    Icons.edit,
                    color: ColorsCollection.splashTitleColor,
                  ),
                  onTap: () {
                    setState(() {
                      changePassword = false;
                    });
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            PatientEditInfoWidget(patient: widget.patient)));
                  },
                ),
              ),
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
                UserProfileInfoWidget(
                    icon: Icons.person,
                    infoTitle: 'username : ',
                    infoValue: widget.patient.username),
                UserProfileInfoWidget(
                    icon: FontAwesomeIcons.heartbeat,
                    infoTitle: 'Blood-Sugar  : ',
                    infoValue: widget.patient.bloodSugar),
                UserProfileInfoWidget(
                    icon: FontAwesomeIcons.heartbeat,
                    infoTitle: 'Blood Preassure High : ',
                    infoValue: widget.patient.bloodHighPressure),
                UserProfileInfoWidget(
                    icon: FontAwesomeIcons.heartbeat,
                    infoTitle: 'Blood Preassure Low  : ',
                    infoValue: widget.patient.bloodLowPressure),
                UserProfileInfoWidget(
                    icon: Icons.height,
                    infoTitle: 'Height : ',
                    infoValue: widget.patient.height),
                UserProfileInfoWidget(
                    icon: Icons.line_weight_outlined,
                    infoTitle: 'Weight : ',
                    infoValue: widget.patient.weight),
                UserProfileInfoWidget(
                    icon: Icons.supervised_user_circle,
                    infoTitle: 'Age : ',
                    infoValue: widget.patient.age),
                Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                      child: Divider(
                        thickness: 1,
                        color: ColorsCollection.mainColor,
                      ),
                    ),
                    (changePassword)
                        ? Column(children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 8.0, top: 15, left: 30, right: 30),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    fillColor: ColorsCollection.mainColor,
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: ColorsCollection.mainColor,
                                          width: 5.0),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    labelStyle: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Proxima',
                                        fontWeight: FontWeight.bold),
                                    labelText: 'New Password'),
                                onChanged: (text) {
                                  setState(() {
                                    _newPassword = text;
                                  });
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                (_newPassword != null &&
                                        _newPassword.length > 8)
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        // ignore: deprecated_member_use
                                        child: FlatButton(
                                            color: Colors.transparent,
                                            minWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .25,
                                            shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: ColorsCollection
                                                        .mainColor,
                                                    width: 1,
                                                    style: BorderStyle.solid),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            onPressed: () {
                                              setState(() {
                                                changePassword = false;
                                              });
                                              void _changePassword() async {
                                                final FirebaseAuth
                                                    firebaseAuth =
                                                    FirebaseAuth.instance;
                                                User currentUser =
                                                    firebaseAuth.currentUser;
                                                if (_newPassword.length > 8) {
                                                  currentUser
                                                      .updatePassword(
                                                          _newPassword)
                                                      .then((_) {
                                                    print(
                                                        "Successfully changed password");
                                                  }).catchError((err) {
                                                    print(
                                                        "Password can't be changed" +
                                                            err.toString());
                                                  });
                                                }
                                              }
                                            },
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 15, bottom: 15),
                                                child: Text(
                                                  "Update",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ))))
                                    : Text(''),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  // ignore: deprecated_member_use
                                  child: FlatButton(
                                      color: Colors.transparent,
                                      minWidth:
                                          MediaQuery.of(context).size.width *
                                              .25,
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: ColorsCollection.mainColor,
                                              width: 1,
                                              style: BorderStyle.solid),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      onPressed: () {
                                        setState(() {
                                          changePassword = false;
                                        });
                                      },
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15, bottom: 15),
                                          child: Text(
                                            "Cancel",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ))),
                                ),
                              ],
                            )
                          ])
                        : Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20),
                            child: GestureDetector(
                                child: Text('Change Your Pssword',
                                    style: TextStyle(
                                        color: ColorsCollection.mainColor
                                            .withOpacity(.6),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)),
                                onTap: () {
                                  setState(() {
                                    changePassword = !changePassword;
                                    _newPassword = '';
                                  });
                                }),
                          )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
