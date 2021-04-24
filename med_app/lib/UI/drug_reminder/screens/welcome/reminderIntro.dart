import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/home.dart';
import 'reminderWelcome.dart';

class ReminderIntro extends StatefulWidget {
  @override
  _ReminderIntroState createState() => _ReminderIntroState();
}

class _ReminderIntroState extends State<ReminderIntro>
    with AfterLayoutMixin<ReminderIntro> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new ReminderHome()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new ReminderWelcome()));
    }
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
