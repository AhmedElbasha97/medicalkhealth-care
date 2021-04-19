import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/UI/Blogs/Blogs_Main_Screen.dart';
import 'package:med_app/UI/callpages/index.dart';
import 'package:med_app/Widgets/NavBar.dart';
import 'package:med_app/models/doctor.dart';
import 'package:med_app/models/patient.dart';
import 'package:med_app/provider/app_provider.dart';
import 'package:med_app/services/auth.dart';
import 'package:provider/provider.dart';

class MedicalNoteScreen extends StatefulWidget {
  Patient patient;
  MedicalNoteScreen({Key key, this.patient}) : super(key: key);

  @override
  _MedicalNoteScreenState createState() => _MedicalNoteScreenState();
}

class _MedicalNoteScreenState extends State<MedicalNoteScreen> {
  static FirebaseDatabase database = new FirebaseDatabase();

  final counterRef = database.reference().child('counter');
  DatabaseReference userRef = database.reference();
  String medicalNote = '';

  void updateUserMedicalRecord() async {
    var user = userRef.child(
        'users/${widget.patient.userId}/medicalNotes/${(widget.patient.medicalNotes.length) == 0 ? 0 : widget.patient.medicalNotes.length}');
    if (medicalNote != null && medicalNote.length > 0) {
      await user.set({medicalNote}).then((_) async {
        print('Transaction  committed.');
        var userId = await context.read<AuthService>().getCurrentUser();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Nav(userid: userId.uid)));
      });
    } else {
      var userId = await context.read<AuthService>().getCurrentUser();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Nav(userid: userId.uid)));
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.patient);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              'Medical Note',
              style: TextStyle(
                  color: ColorsCollection.splashTitleColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 22),
            ),
          ),
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 15, left: 20, right: 20, top: 25),
              child: TextFormField(
                maxLength: 1500,
                maxLines: 5,
                decoration: InputDecoration(
                    fillColor: ColorsCollection.mainColor,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: ColorsCollection.mainColor, width: 5.0),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                    ),
                    labelStyle: TextStyle(
                        fontSize: 23,
                        fontFamily: 'Proxima',
                        fontWeight: FontWeight.bold),
                    labelText: 'Medical Note'),
                onChanged: (text) async {
                  setState(() {
                    medicalNote = text;
                  });
                },
              ),
            ),
            // ignore: deprecated_member_use
            FlatButton(
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
                  "Send",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              onPressed: () {
                updateUserMedicalRecord();
              },
            )
          ],
        ));
  }
}
