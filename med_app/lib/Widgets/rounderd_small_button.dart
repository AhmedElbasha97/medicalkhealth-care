import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/services/auth.dart';
import 'package:provider/provider.dart';

class RoundedSmallButton extends StatelessWidget {
  final String text;
  final password;
  final email;
  final String confirm_password;
  final String username;
  final type;
  RoundedSmallButton(
      {this.text,
      this.password,
      this.email,
      this.username,
      this.confirm_password,
      this.type});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Align(
        alignment: Alignment.center,
        child: Container(
          width: constraints.maxWidth - 150,
          height: 50,
          // ignore: deprecated_member_use
          child: RaisedButton(
            onPressed: () async {
              // Navigate to the second screen using a named route.
              // Navigator.pushNamed(context, '/${this.navigation}');
              switch (type) {
                case 'login':
                  context
                      .read<AuthService>()
                      .signInEmail(context, email, password);
                  break;
                case 'doctor':
                  context.read<AuthService>().signUpEmail(
                      context: context,
                      email: email,
                      password: password,
                      confirmpassword: confirm_password,
                      username: username,
                      type: type);
                  break;
                case 'user':
                  context.read<AuthService>().signUpEmail(
                      context: context,
                      email: email,
                      password: password,
                      confirmpassword: confirm_password,
                      username: username,
                      type: type);
                  break;
              }
            },
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            color:
                (type == 'doctor') ? ColorsCollection.mainColor : Colors.white,
            textColor:
                (type == 'doctor') ? Colors.white : ColorsCollection.mainColor,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: ColorsCollection.mainColor,
                  width: 1,
                  style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
      );
    });
  }
}
