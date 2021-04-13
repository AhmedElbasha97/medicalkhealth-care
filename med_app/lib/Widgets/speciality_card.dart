import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:med_app/UI/spcialitypage/speciality_page.dart';
import 'package:med_app/models/doctor.dart';
import 'package:med_app/models/speciality.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

getImgeUrl(imagepath) async {
  String downloadURL = await firebase_storage.FirebaseStorage.instance
      .ref(imagepath)
      .getDownloadURL();
  print(downloadURL);
  return downloadURL;
}

class SpecialityCard extends StatefulWidget {
  final Speciality item;
  SpecialityCard(this.item);
  static FirebaseDatabase database = new FirebaseDatabase();

  @override
  _SpecialityCardState createState() => _SpecialityCardState();
}

class _SpecialityCardState extends State<SpecialityCard> {
  final fb = FirebaseDatabase.instance;
  //   List<Doctor> docs = [];
  // List<Map<dynamic, dynamic>> retrievedName = [];
  // Map<dynamic, dynamic> values;
  @override
  Widget build(BuildContext context) {
    // final ref = fb.reference();
    return InkWell(
        splashColor: Colors.grey.withAlpha(15),
        onTap: () async {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SpecialityPage(speciality:widget.item.speciality)));
        },
        child: Card(
          child: Column(
            children: [
              Expanded(
                child: Image.asset(widget.item.image),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  widget.item.speciality,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              )
            ],
          ),
        ));

  }
}
