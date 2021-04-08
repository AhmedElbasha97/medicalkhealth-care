import 'package:flutter/material.dart';
import 'package:med_app/register/register_button.dart';

class ResgisterScreen extends StatelessWidget {
  const ResgisterScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image(image: AssetImage('assets/Logo.png'), height: 450, width: 250),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.only(right: 10),
                  // ignore: deprecated_member_use
                  child: ResgisterButtonWidget(
                    buttonInnerText: 'Login',
                    buttonBG: false,
                    buttonNavigation: 'Homescreen',
                  )),
              Padding(
                  padding: const EdgeInsets.only(left: 10),
                  // ignore: deprecated_member_use
                  child: ResgisterButtonWidget(
                      buttonInnerText: 'Register', buttonBG: true)),
            ],
          ),
        ],
      ),
    );
  }
}
