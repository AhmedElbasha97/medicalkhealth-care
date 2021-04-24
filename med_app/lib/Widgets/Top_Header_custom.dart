import 'package:flutter/material.dart';

class TopHaderCustom extends StatelessWidget {
  final text;
  final image;

  TopHaderCustom({this.text, this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: MediaQuery.of(context).size.height * 0.03,
            ),
          ),
          Image.asset(
            image,
            height: MediaQuery.of(context).size.height * 0.3,
            fit: BoxFit.fitHeight,
          )
        ],
      ),
    );
  }
}