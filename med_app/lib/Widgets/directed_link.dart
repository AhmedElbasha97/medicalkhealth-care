import 'package:flutter/material.dart';

class DirectedLink extends StatelessWidget {
  final text;
  final navigation;
  final color;
  DirectedLink({this.text, this.navigation, this.color});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.pushNamed(context, '/${this.navigation}');
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => this.navigation));
      },
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.grey,
          fontSize: 16,
        ),
      ),
    );
  }
}
