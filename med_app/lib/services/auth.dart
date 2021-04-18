import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:med_app/UI/DoctorNextScreen/doctor_next_screen.dart';
import 'package:med_app/UI/PatientNextScreen/patient_next_screen.dart';
import 'package:med_app/Widgets/NavBar.dart';
import 'package:med_app/Widgets/start.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth;
  AuthService(this._auth);
  //
  Stream<User> get authStateChanges => _auth.authStateChanges();

 Future<String> getUserId() async{
    _auth
  .userChanges()
  .listen((User user) {
    if (user == null) {
      print('User is currently signed out!');
      return null;
    } else {
      print('User is signed in id ${user.uid}!');
      return   user.uid;
    }
  });
  }
// getStringValuesSF() async {

// SharedPreferences prefs = await SharedPreferences.getInstance();

// //Return String

// String stringValue = prefs.getString('stringValue');

// return stringValue;

// }
  addStringToSF(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userid', id);
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  bool validatePassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,10}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool validateUsername(String value) {
    String pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
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

  //signin email
  Future<String> signInEmail(context, email, password) async {
    if (validateEmail(email)) {
      if (validatePassword(password)) {
        try {
          UserCredential userCredential = await _auth
              .signInWithEmailAndPassword(email: email, password: password);
          final userid = userCredential.user.uid;
          addStringToSF(userid);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Start()));
          return "Signd in";
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            showAlert(context, 'No user found for that email',
                "Please Check Your Email");

            return 'No user found for that email.';
          } else if (e.code == 'wrong-password') {
            showAlert(context, 'wrong-password', "Please Reenter Your Email");

            return 'Wrong password.';
          }
        }
      } else {
        showAlert(context, "Your Password is Weak",
            "strong Password Must Contain this Criteria Minimum 8 and Maximum 10 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character");
      }
    } else {
      showAlert(context, "The E-mail You entered isn't valid",
          "Please Enter A Valid E-Mail");
    }
  }

  //register email & password
  Future<String> signUpEmail(
      {context, email, username, confirmpassword, password, type}) async {
    if (validateUsername(username)) {
      if (validateEmail(email)) {
        if (validatePassword(password)) {
          if (confirmpassword == password) {
            try {
              UserCredential userCredential =
                  await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);
              final userid = userCredential.user.uid;
              addStringToSF(userid);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => (type != 'doctor')
                      ? PatientNextScreen(
                          email: email, username: username, userId: userid)
                      : DoctorNextScreen(
                          email: email, username: username, userId: userid)));
            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                showAlert(
                    context, 'weak-password', "Please Type Stronger Password");
              } else if (e.code == 'email-already-i n-use') {
                showAlert(context, 'email-already-in-use',
                    "Please Enter Another Email");
              }
            } catch (e) {
              showAlert(context, 'opps', e);
            }
          } else {
            print("$confirmpassword,$password");
            showAlert(context, "The Confirm Password didn't Match",
                "Please re-type  matched password and confirm password");
          }
        } else {
          showAlert(context, "Your Password is Weak",
              "strong Password Must Contain this Criteria Minimum 8 and Maximum 10 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character");
        }
      } else {
        showAlert(context, "The E-mail You entered isn't valid",
            "Please Enter A Valid E-Mail");
      }
    } else {
      showAlert(context, "The user name isn't valid",
          "Please re-enter valid username");
    }
  }

//resetpassword
  Future<String> resetPassword({email, context}) {
    if (validateEmail(email)) {
      _auth.sendPasswordResetEmail(email: email);
      showAlert(context, "Your Password Has Been Reset",
          "Please Go And Check Your E-Mail");
    } else {
      showAlert(context, "The E-mail You entered isn't valid",
          "Please Enter A Valid E-Mail");
    }
  }

//Get current User

  Future <User>getCurrentUser() async {
    return await _auth.currentUser;
  }

  //signout
  void signOut() async {
    await _auth.signOut();
    print('u signout');
  }
}
