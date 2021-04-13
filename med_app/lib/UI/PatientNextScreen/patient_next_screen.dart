import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
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

  final height = TextEditingController();
  final weight = TextEditingController();
  final highBlood = TextEditingController();
  final lowBlood = TextEditingController();
  final sugar = TextEditingController();

  // var uid;
  // final FirebaseAuth auth = FirebaseAuth.instance;
  // void inputData() {
  //   final User user = auth.currentUser;
  //   uid = user.uid;
  // }

  addPatient(height, weight, highBlood, lowBlood, sugar) async {
    // inputData();
    var user = userRef.child('Uesrs/Patients/${widget.userId}');
    final TransactionResult transactionResult =
        await counterRef.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;
      return mutableData;
    });

    if (transactionResult.committed) {
      user.set(<String, String>{
        "Appointment": '',
        "Blood-Sugar": sugar.text,
        "BloodPreassureHigh": highBlood.text,
        "BloodPreassureLow": lowBlood.text,
        "Email": widget.email,
        "Height": height.text,
        "To-Do": '',
        "User-Avatar": '',
        "Balance": '250',
        "User-Id": widget.userId,
        "Wieght": weight.text,
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
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFieldComp(
                          label: "What is your weight",
                          hint: "Enter your weight",
                          controller: weight,
                          keyboardTypeNumber: true),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFieldComp(
                          label: "What is your height",
                          hint: "Enter your height",
                          controller: height,
                          keyboardTypeNumber: true),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFieldComp(
                          label: 'What is your blood sugar',
                          hint: "Enter your blood sugar",
                          controller: sugar,
                          keyboardTypeNumber: true),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 10.0, left: 5.0),
                              child: Text(
                                'What is your blood pressure ?',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Proxima',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
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
                                              const Radius.circular(40.0),
                                            )),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(40.0),
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
                                              const Radius.circular(40.0),
                                            )),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(40.0),
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
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.29,
              ),
              Container(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFF00A1A7) // foreground
                      ),
                  onPressed: () {
                    addPatient(height, weight, highBlood, lowBlood, sugar);
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
