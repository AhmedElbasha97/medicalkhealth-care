import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/Widgets/NavBar.dart';
import 'package:med_app/Widgets/TextwithDropComp.dart';
import 'package:med_app/Widgets/text_field.dart';

// ignore: must_be_immutable
class PatientNextScreen extends StatefulWidget {
  static FirebaseDatabase database = new FirebaseDatabase();
  final email;
  final userId;
  final username;

  PatientNextScreen({this.email, this.userId, this.username});

  @override
  _PatientNextScreenState createState() => _PatientNextScreenState();
}

class _PatientNextScreenState extends State<PatientNextScreen> {
  final counterRef = PatientNextScreen.database.reference().child('counter');
  DatabaseReference userRef = PatientNextScreen.database.reference();

  final name = TextEditingController();
  final age = TextEditingController();
  final height = TextEditingController();
  final weight = TextEditingController();
  final highBlood = TextEditingController();
  final lowBlood = TextEditingController();
  final sugar = TextEditingController();
  String _selectedGender;
  String _nameText;
  String _ageText;

  // var uid;
  // final FirebaseAuth auth = FirebaseAuth.instance;
  // void inputData() {
  //   final User user = auth.currentUser;
  //   uid = user.uid;
  // }

  addPatient(height, weight, highBlood, lowBlood, sugar) async {
    // inputData();
    var user = userRef.child('users/patients/${widget.userId}');
    final TransactionResult transactionResult =
        await counterRef.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;
      return mutableData;
    });

    if (transactionResult.committed) {
      user.set(<String, dynamic>{
        "appointment": [],
        "bloodSugar": sugar,
        "bloodHighPressure": highBlood,
        "bloodLowPressure": lowBlood,
        "email": widget.email,
        "height": height,
        "age": _ageText,
        "gender": _selectedGender,
        "medicalNotes": [],
        "userAvatar":
            "/data/user/0/com.example.med_app/cache/file_picker/placeholder.jpg",
        "balance": "250",
        "userId": widget.userId,
        "weight": weight,
        "username": widget.username,
        "name": _nameText
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
        title: Text('Details'),
        backgroundColor: ColorsCollection.mainColor,
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 3.0),
          child: Icon(
            Icons.account_circle,
            size: 30.0,
          ),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 9,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: TextFieldComp(
                        label: 'What is your name*',
                        hint: "Enter your profile name",
                        controller: name,
                        callback: (val) {
                          setState(() {
                            _nameText = val;
                          });
                        },
                        onChange: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5.0),
                      child: TextFieldComp(
                          label: 'What is your age*',
                          hint: "Enter your age",
                          controller: age,
                          callback: (val) {
                            setState(() {
                              _ageText = val;
                            });
                          },
                          onChange: true,
                          keyboardTypeNumber: true),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 5.0, right: 5.0),
                      child: Row(
                        children: [
                          Text(
                            'What is your gender',
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Proxima',
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 5.0, left: 5.0, right: 5.0),
                      child: DropDown(
                        showUnderline: true,
                        isExpanded: true,
                        hint: Text('choose gender'),
                        items: ['Male', 'Female'],
                        onChanged: (val) {
                          setState(() {
                            _selectedGender = val;
                            print(_selectedGender);
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: TextFieldComp(
                          label: "What is your weight",
                          hint: "Enter your weight in kg",
                          controller: weight,
                          keyboardTypeNumber: true),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: TextFieldComp(
                          label: "What is your height",
                          hint: "Enter your height in cm",
                          controller: height,
                          keyboardTypeNumber: true),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: TextFieldComp(
                          label: 'What is your blood sugar',
                          hint: "Enter your blood sugar",
                          controller: sugar,
                          keyboardTypeNumber: true),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 15.0, left: 5.0),
                              child: Text(
                                'What is your blood pressure ?',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Proxima',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: TextFormField(
                                      controller: lowBlood,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: Color(0xFF02B4BB)),
                                            borderRadius:
                                                const BorderRadius.all(
                                              const Radius.circular(10.0),
                                            )),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(10.0),
                                          ),
                                          borderSide: BorderSide(
                                              width: 2, color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Text(
                                      '/',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    flex: 1),
                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: TextFormField(
                                      controller: highBlood,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: Color(0xFF02B4BB)),
                                            borderRadius:
                                                const BorderRadius.all(
                                              const Radius.circular(10.0),
                                            )),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(10.0),
                                          ),
                                          borderSide: BorderSide(
                                              width: 2, color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFF00A1A7) // foreground
                      ),
                  onPressed: (name.text.isNotEmpty && age.text.isNotEmpty)
                      ? () {
                          addPatient(height.text, weight.text, highBlood.text,
                              lowBlood.text, sugar.text);
                          print(_nameText);
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                Nav(),));
                        }
                      : null,
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
        ),
      ),
    );
  }
}
