import 'package:flutter/material.dart';

class TopHader extends StatelessWidget {
  final text;
  final image;
  TopHader({this.text, this.image});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 28,
            ),
          ),
          Image.asset(
            image,
            height: 170,
            fit: BoxFit.fitHeight,
          )
        ],
      ),
    );
  }
}
