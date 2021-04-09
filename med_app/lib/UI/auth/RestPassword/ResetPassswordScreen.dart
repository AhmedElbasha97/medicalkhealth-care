import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:med_app/Widgets/text_field.dart';

class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  String _email;
  // final auth = FirebaseAuth.instance;
  bool _hasFocus = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp),
          color: Colors.grey,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(''),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Text(
              "Reset Your Password",
              style: TextStyle(
                  color: Color.fromRGBO(21, 104, 102, 1),
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Text(
              "Input your E-Mail Address below, we will send you way to reset your password",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextFieldComp(
                      label: "Email-Address", hint: "Example@gmail.com"))),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.07,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Color.fromRGBO(21, 104, 102, 1),
                  onPressed: () {
                    // auth.sendPasswordResetEmail(email: _email);
                    showDialog<void>(
                      context: context,
                      // false = user must tap button, true = tap outside dialog
                      builder: (BuildContext dialogContext) {
                        return AlertDialog(
                          title: Text('Your Password Has Been Reset'),
                          content: Text("Please Go And Check Your E-Mail"),
                          actions: <Widget>[
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
                  },
                  child: Text(
                    "Reset Your Password",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
