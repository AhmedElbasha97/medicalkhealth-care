import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:med_app/UI/auth/login/Login.dart';
import 'package:med_app/UI/auth/signup/Signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth;
  AuthService(this._auth);
  //
  Stream<User> get authStateChanges => _auth.authStateChanges();
  // String authState() {
  //   FirebaseAuth.instance.authStateChanges().listen((User user) {
  //     if (user == null) {
  //       return "signed out";
  //     } else {
  //       return 'signed in';
  //     }
  //   });
  // }
  addStringToSF(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('userid', id);
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
  //signin annonmasly
  // Future signInAnon(context) async {
  //   try {
  //     UserCredential userCredential = await _auth.signInAnonymously();
  //     //  Navigator.of(context).push(
  //     //      MaterialPageRoute(builder: (context) => Home();

  //     return userCredential;
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  //signin email
  Future<String> signInEmail(context, email, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SignUp()));
      return "Signd in";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showAlert(
            context, 'No user found for that email', "Please Check Your Email");

        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        showAlert(context, 'wrong-password', "Please Reenter Your Email");

        return 'Wrong password.';
      }
    }
  }

  //register email & password
  Future<String> signUpEmail(
      {context, email, username, confirmpassword, password, type}) async {
   if(confirmpassword ==password){
      try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final userid = userCredential.user.uid;
      addStringToSF(userid);
      //  Navigator.of(context).push(
      //            MaterialPageRoute(builder: (context) => (type!='doctor')?PatientNextScreen(email,username,userid):DoctorNextScreen(email,username,userid)));

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showAlert(context, 'weak-password', "Please Type Stronger Password");
      } else if (e.code == 'email-already-i n-use') {
        showAlert(
            context, 'email-already-in-use', "Please Enter Another Email");
      }
    } catch (e) {
      showAlert(
            context, 'opps', e);
      }
    }
    else{
      print("$confirmpassword,$password");
       showAlert(
            context, "The Confirm Password didn't Match", "Please re-type  matched password and confirm password");
    }
  }

  //signout
  void SignOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
