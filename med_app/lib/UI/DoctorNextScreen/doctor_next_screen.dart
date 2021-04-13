import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:med_app/Widgets/UploadCard.dart';
import 'package:med_app/Widgets/text_field.dart';

class DoctorNextScreen extends StatefulWidget {
  final email;
  final userId;
  final username;

  DoctorNextScreen({this.email, this.userId, this.username});
  @override
  _DoctorNextScreenState createState() => _DoctorNextScreenState();
}

class _DoctorNextScreenState extends State<DoctorNextScreen> {
  var _selectedProfession = '';
  var profession = ['Doctor', 'Pharmacist', 'Nutritionist'];
  var specialities = [
    'Dermatology',
    'Dentistry',
    'Psychiatry',
    'Pediatrics',
    'Neurology',
    'Orthopedics',
    'Gynaecology and Infertility',
    'Ear, Nose and Throat',
    'Cardiology and Vascular',
    'Allergy and Immunology',
    'Andrology and Male Infertility',
    'Audiology',
    'Cardiology and Thoracic',
    'Chest and Respiratory',
    'Diabetes and Endocrinology',
    'Diagnostic Radiology',
    'Dietitian and Nutrition',
    'Family Medicine',
    'Oncology',
    'Gastroenterology and Endoscopy',
    'General Practice'
  ];

  static FirebaseDatabase database = new FirebaseDatabase();
  final counterRef = database.reference().child('counter');
  DatabaseReference userRef = database.reference();

  var speciality, certificate, id, candidate;

  addDoctor(profession, speciality, certificate, id, candidate) async {
    var user = userRef.child('Uesrs/Doctors/${widget.userId}');
    final TransactionResult transactionResult =
        await counterRef.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;
      return mutableData;
    });

    if (transactionResult.committed) {
      user.set(<String, dynamic>{
        "Appointment": '',
        "Appointment-AV": '',
        "Bio": '',
        "Documents": {
          "Certificate": certificate,
          "ID": id,
          "Candidate": candidate
        },
        "Email": widget.email,
        "Profession": profession,
        "Speciality": speciality,
        "User-Id": widget.userId,
        "name-user": widget.username,
      }).then((_) {
        print('Transaction  committed.');
      });
    } else {
      print('Transaction not committed.');
      if (transactionResult.error != null) {
        print(transactionResult.error.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.black,
          title: Text(''),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, bottom: 10.0, left: 10.0),
                    child: Text(
                      'Choose Your Profession:',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Proxima',
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10.0, left: 10.0, right: 10.0),
                      child: DropDown(
                        hint: Text('choose Profession'),
                        items: ['Doctor', 'Pharmacist', 'Nutritionist'],
                        onChanged: (val) {
                          setState(() {
                            _selectedProfession = val;
                            print(_selectedProfession);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                (_selectedProfession == 'Doctor')
                    ? Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: DropDown(
                          hint: Text('choose Speciality'),
                          items: specialities,
                          onChanged: (val) {
                            setState(() {
                              speciality = val;
                            });
                          },
                        ),
                      )
                    : SizedBox(height: 1),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, left: 5.0),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, bottom: 10.0, left: 10.0, right: 10.0),
                    child: Text(
                      'Upload Your Documents:',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Proxima',
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      UploadCard(
                          title: "Enter Your Certificate",
                          asset: "assets/documents.jpg",
                          certType: 'Certificate',
                          callback: (val) => setState(() => certificate = val)),
                      UploadCard(
                          title: "Enter Your ID",
                          asset: "assets/ID.png",
                          certType: 'ID',
                          callback: (val) => setState(() => id = val)),
                      UploadCard(
                          title: "Enter Your Candidate Card",
                          asset: "assets/Candidate.png",
                          certType: 'Candidate',
                          callback: (val) => setState(() => candidate = val))
                    ],
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFF00A1A7) // foreground
                      ),
                  onPressed: () {
                    addDoctor(_selectedProfession, speciality, certificate, id,
                        candidate);
                  },
                  child: Text(
                    'Finish',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Proxima',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
