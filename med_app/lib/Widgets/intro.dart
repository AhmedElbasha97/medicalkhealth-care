import 'package:after_layout/after_layout.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:med_app/UI/auth/login/Login.dart';
import 'package:med_app/UI/splash/splash_screen.dart';
import 'package:med_app/Widgets/NavBar.dart';
import 'package:med_app/Widgets/blank404.dart';
import 'package:med_app/Widgets/start.dart';
import 'package:med_app/provider/app_provider.dart';
import 'package:med_app/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> with AfterLayoutMixin<Intro> {
  Future checkFirstSeen() async {
    context.read<AuthService>().getCurrentUser().then((user) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool _seen = (prefs.getBool('seen') ?? false);
      // String id = prefs.getString('userid');
      bool CheckValue = prefs.containsKey('userid');

      var connectivityResult = await (Connectivity().checkConnectivity());

      if (connectivityResult == ConnectivityResult.none) {
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => new Blank404()));
      } else {
        if (CheckValue && _seen) {
          Navigator.of(context).pushReplacement(
              new MaterialPageRoute(builder: (context) => new Start()));
        } else if (_seen) {
          Navigator.of(context).pushReplacement(
              new MaterialPageRoute(builder: (context) => new Login()));
        } else {
          await prefs.setBool('seen', true);
          Navigator.of(context).pushReplacement(
              new MaterialPageRoute(builder: (context) => new Splash()));
        }
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
