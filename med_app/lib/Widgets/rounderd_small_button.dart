import 'package:flutter/material.dart';

class RoundedSmallButton extends StatelessWidget {
  final String text;
  final String navigation;
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
              Navigator.pushNamed(context, '/${this.navigation}');
            },
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            color: Color(0xFF00A1A7),
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
