import 'package:flutter/material.dart';
import 'package:med_app/UI/spcialitypage/speciality_page.dart';
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
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  SpecialityPage(speciality: widget.item.speciality)));
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  child: Image.asset(
                    widget.item.image,
                    fit: BoxFit.contain,
                  ),
                  width: MediaQuery.of(context).size.width / 4,
                  height: MediaQuery.of(context).size.width / 5.2,
                ),
                Center(
                  child: Text(
                    widget.item.speciality,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
