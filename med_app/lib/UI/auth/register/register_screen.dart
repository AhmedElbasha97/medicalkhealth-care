import 'package:flutter/material.dart';
import 'package:med_app/UI//auth/register/register_button.dart';
import 'package:med_app/UI/auth/login/Login.dart';
import 'package:med_app/UI/auth/signup/Signup.dart';

class ResgisterScreen extends StatelessWidget {
  const ResgisterScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            automaticallyImplyLeading: false),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image(
                  image: AssetImage('assets/Logo.png'),
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.9),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ResgisterButtonWidget(
                    buttonInnerText: 'Login',
                    buttonBG: false,
                    buttonNavigation: Login(),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10),
                      // ignore: deprecated_member_use
                      child: ResgisterButtonWidget(
                        buttonInnerText: 'Register',
                        buttonBG: true,
                        buttonNavigation: SignUp(),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
