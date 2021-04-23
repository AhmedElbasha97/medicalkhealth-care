import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:med_app/Styles/colors.dart';

import 'package:med_app/Widgets/start.dart';
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
  addPatient(height, weight, highBlood, lowBlood, sugar) async {
    if(validateUsername(_nameText)) {
      if (int.parse(_ageText)>=0){
        if ((int.parse(weight) >= 0) && (int.parse(weight) <= 500)) {
          if ((int.parse(height) >= 30) && (int.parse(height) <= 250)) {
            if ((int.parse(sugar)>=100)&&(int.parse(sugar)<=700)) {
              if((int.parse(lowBlood) >= 60) && (int.parse(lowBlood) <= 100)){
                if ((int.parse(highBlood) >= 100) && (int.parse(highBlood) <= 180)) {
    // inputData();
    var user = userRef.child('users/${widget.userId}');
    final TransactionResult transactionResult =
        await counterRef.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;
      return mutableData;
    });
    String type = "patient";
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
        "name": _nameText,
        "userType": type
      }).then((_) {
        print('Transaction  committed.');
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => Start()));
      });
    } else {
      print('Transaction not committed.');
      if (transactionResult.error != null) {
        showAlert(context, "oop's something goes wrong", "${transactionResult.error.message}");
      }
    }}else{
                  showAlert(context, "blood pressures high is not valid",
                      "please enter valid high pressure");
                }
              } else {
                showAlert(context, "blood pressure low is not valid",
                    "please enter valid low pressure");
              }
            } else {
              showAlert(context, "blood sugar is not valid",
                  "please enter valid blood sugar");
            }
          } else {
            showAlert(
                context, "your height isn't valid",
                "please Enter Valid height");
          }
        } else {
          showAlert(
              context, "your weight isn't valid", "pleas Enter Valid weight");
        }
      } else {
        showAlert(
            context, "age is not valid", "please enter valid age");
      }
    }else{
      showAlert(
          context, "name is not valid", "please enter valid name");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
                          maxCharacter:50,
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
                          maxCharacter: 2,
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
                            keyboardTypeNumber: true,maxCharacter: 3,),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: TextFieldComp(
                            label: "What is your height",
                            hint: "Enter your height in cm",
                            controller: height,
                            keyboardTypeNumber: true,maxCharacter: 3),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: TextFieldComp(
                            label: 'What is your blood sugar',
                            hint: "Enter your blood sugar",
                            controller: sugar,
                            keyboardTypeNumber: true,maxCharacter: 3),
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
                                        maxLength: 3,
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
                                        maxLength: 3,
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
      ),
    );
  }
  bool validateUsername(String value) {
    String pattern = r"^(\w|( \w)){0,20}$";
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
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
