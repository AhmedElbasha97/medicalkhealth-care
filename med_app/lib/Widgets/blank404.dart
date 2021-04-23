import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/Widgets/intro.dart';

class Blank404 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/404.png'),
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Text(
            'No Internet Connection',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width: 150,
          height: 50,
          child: ElevatedButton(
            child: Text(
              'Refresh',
              style: TextStyle(fontSize: 18.0),
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  new MaterialPageRoute(builder: (context) => new Intro()));
            },
            style: ElevatedButton.styleFrom(
              elevation: 3.0,
              primary: Colors.grey[100],
              onPrimary: ColorsCollection.mainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
