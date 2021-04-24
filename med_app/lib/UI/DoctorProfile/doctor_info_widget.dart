import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/Widgets/userProfile_info_widget.dart';
import 'package:med_app/models/doctor.dart';
import 'package:med_app/services/auth.dart';
import 'doctor_edit_info_widget.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DoctorInfoWidget extends StatefulWidget {
  final text;
  final color;
  final String cardLabel;
  final IconData icon;
  final buttonNavigation;
  Doctor doctor;

  DoctorInfoWidget(
      {this.text,
      this.color,
      this.cardLabel,
      this.icon,
      this.doctor,
      this.buttonNavigation});

  @override
  _DoctorInfoWidgetState createState() => _DoctorInfoWidgetState();
}

class _DoctorInfoWidgetState extends State<DoctorInfoWidget> {
  bool changePassword = false;
  String _newPassword;
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

  void _changePassword() async {
    User currentUser = await context.read<AuthService>().getCurrentUser();
    if (_newPassword.length > 8) {
      currentUser.updatePassword(_newPassword).then((_) {
        showAlert(context, "Password Change", "Successfully");
      }).catchError((err) {
        showAlert(context, "Password Change", "Failed");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    RegExp regExp = new RegExp(pattern);

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
                            DoctorEditInfoWidget(doctor: widget.doctor)));
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
                    infoTitle: 'name : ',
                    infoValue: widget.doctor.name),
                UserProfileInfoWidget(
                    icon: Icons.language_outlined,
                    infoTitle: 'languages : ',
                    infoValue: widget.doctor.languages.join(' , ')),
                UserProfileInfoWidget(
                    icon: FontAwesomeIcons.moneyBill,
                    infoTitle: 'Balance : ',
                    infoValue: widget.doctor.balance),
                UserProfileInfoWidget(
                    icon: Icons.info,
                    infoTitle: 'Profession : ',
                    infoValue: widget.doctor.profession),
                (widget.doctor.speciality != null)
                    ? UserProfileInfoWidget(
                        icon: FontAwesomeIcons.info,
                        infoTitle: 'speciality : ',
                        infoValue: widget.doctor.speciality)
                    : Text(''),
                UserProfileInfoWidget(
                    icon: Icons.line_weight_outlined,
                    infoTitle: 'Experience : ',
                    infoValue: widget.doctor.experience),
                UserProfileInfoWidget(
                    icon: Icons.supervised_user_circle,
                    infoTitle: 'Age : ',
                    infoValue: widget.doctor.age),
                UserProfileInfoWidget(
                    icon: FontAwesomeIcons.user,
                    infoTitle: 'Bio  : ',
                    infoValue: widget.doctor.bio),
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
                                        regExp.hasMatch(_newPassword))
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
                                              _changePassword();
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

  void showAlert(context, lable, message) {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(lable),
          content: Text(message),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
