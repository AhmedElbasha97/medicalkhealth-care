import 'package:after_layout/after_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:med_app/Widgets/NavBar.dart';
import 'package:med_app/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class Start extends StatefulWidget {
  
  @override
  _StartState createState() => _StartState();
}

class _StartState extends  State<Start>with AfterLayoutMixin<Start>

 {
  Future checkFirstSeen() async {
      context.read<AuthService>().getCurrentUser().then((user) async {
        print(user.uid);
        SharedPreferences prefs = await SharedPreferences.getInstance();
  String id = prefs.getString('userid') ;
  if (id!=null) {
    Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => new Nav(id)));
  } else {
  
    await prefs.setString('userid',user.uid);
    Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => new Nav(user.uid)));
  }
      });
  
}
 @override
void afterFirstLayout(BuildContext context) => checkFirstSeen();
@override
Widget build(BuildContext context) {
  return new Scaffold(
    body: new Center(
      child: CircularProgressIndicator(),
    ),
  );
}
}