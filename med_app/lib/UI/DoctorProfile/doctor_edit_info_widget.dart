import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/Widgets/userProfile_edit.dart';
import 'package:med_app/models/doctor.dart';
import 'package:med_app/provider/app_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DoctorEditInfoWidget extends StatefulWidget {
  final text;
  final color;
  final String cardLabel;
  final IconData icon;
  final String patientId;
  Doctor doctor;

  DoctorEditInfoWidget({
    this.text,
    this.color,
    this.cardLabel,
    this.icon,
    this.doctor,
    this.patientId,
  });

  @override
  _DoctorEditInfoWidgetState createState() => _DoctorEditInfoWidgetState();
}

class _DoctorEditInfoWidgetState extends State<DoctorEditInfoWidget> {
  bool edit = false;

  static FirebaseDatabase database = new FirebaseDatabase();

  final counterRef = database.reference().child('counter');
  DatabaseReference userRef = database.reference();
  String bloodSugar,
      bloodPreassureHigh,
      bloodPreassureLow,
      experience,
      bio,
      age,
      name;
  void updateUser() async {
    var user = userRef.child('users/${widget.doctor.userId}');

    await user.update({
      'bio': (bio != null && bio.length > 0 && bio.length < 120)
          ? bio
          : widget.doctor.bio,
      'experience': (experience != null && experience.length > 0)
          ? experience
          : widget.doctor.experience,
      'name': (name != null && name.length > 0) ? name : widget.doctor.name,
      'age': (age != null && age.length > 0) ? age : widget.doctor.age,
    }).then((_) {
      print('Transaction  committed.');
      AppProvider provider = Provider.of<AppProvider>(context, listen: false);
      provider.getDoctorById('${widget.doctor.userId}');
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
                  isBio: false,
                  keyboardTypeNumber: false,
                  callback: (val) => setState(() => name = val),
                  infoTitle: 'name  ',
                  infoValue: widget.doctor.name),
              UserProfileInfoEditWidget(
                  isBio: false,
                  keyboardTypeNumber: true,
                  callback: (val) => setState(() => experience = val),
                  infoTitle: 'experience  ',
                  infoValue: widget.doctor.experience),
              UserProfileInfoEditWidget(
                  isBio: false,
                  keyboardTypeNumber: true,
                  callback: (val) => setState(() => age = val),
                  infoTitle: 'age  ',
                  infoValue: widget.doctor.age),
              UserProfileInfoEditWidget(
                  keyboardTypeNumber: false,
                  isBio: true,
                  callback: (val) => setState(() => bio = val),
                  infoTitle: 'bio   ',
                  infoValue: widget.doctor.bio),
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
