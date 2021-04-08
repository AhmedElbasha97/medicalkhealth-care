import 'package:flutter/material.dart';

class SocialMediaButton extends StatelessWidget {
  final icon;
  SocialMediaButton({this.icon});
  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size(54, 54), //button width and height
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Material(
          elevation: 16,
          shadowColor: Colors.black,
          color: Color(0xFF00A1A7),
          child: InkWell(
            splashColor: Colors.white12,
            onTap: () {},
            child: Center(
              child: Icon(
                icon,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
