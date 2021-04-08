import 'package:flutter/material.dart';

import 'package:med_app/UI/splash/splash_screen.dart';
import 'package:med_app/UI/Login.dart';
import 'package:med_app/UI/Signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: Splash(),

  }
}
