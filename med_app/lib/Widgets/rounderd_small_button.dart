import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';

class RoundedSmallButton extends StatelessWidget {
  final String text;
  final navigation;
  RoundedSmallButton({this.text, this.navigation});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Align(
        alignment: Alignment.center,
        child: Container(
          width: constraints.maxWidth - 150,
          height: 50,
          child: RaisedButton(
            onPressed: () {
              // Navigate to the second screen using a named route.
              // Navigator.pushNamed(context, '/${this.navigation}');
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => this.navigation));
            },
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            color: ColorsCollection.mainColor,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
      );
    });
  }
}
