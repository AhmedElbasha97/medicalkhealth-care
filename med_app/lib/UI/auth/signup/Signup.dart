import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med_app/UI/auth/login/Login.dart';
import 'package:med_app/Widgets/directed_link.dart';
import 'package:med_app/Widgets/rounderd_small_button.dart';
import 'package:med_app/Widgets/social_media_button.dart';
import 'package:med_app/Widgets/text_field.dart';
import 'package:med_app/Widgets/top_hader.dart';
import 'package:med_app/Styles/colors.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
String email;

String password;

String rePassword;

String userName;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: ColorsCollection.mainColor,
        body: Stack(children: [
          Positioned(
              top: 40,
              left: 0,
              right: 0,
              child: Container(
                child: TopHader(
                    text: 'Signup\nTo Your\nAccount',
                    image: "assets/gbimage.png"),
              )),
          DraggableScrollableSheet(
              initialChildSize: 0.78,
              minChildSize: 0.78,
              maxChildSize: 1,
              builder: (context, scrollController) {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  margin: EdgeInsets.only(top: 32),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      color: Colors.white),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 40),
                        TextFieldComp(
                            callback: (val){
                              setState(() {
                                userName = val;
                              });
                            },
                            onChange: true,
                            label: "UserName",
                            hint: "enter Your UserName"),
                        SizedBox(height: 12),
                        TextFieldComp(
                            callback: (val){
                              setState(() {
                                email = val;
                              });
                            },
                            onChange: true,
                            label: "Email",
                            hint: "example@email.com"),
                        SizedBox(height: 12),
                        TextFieldComp(
                            callback: (val){
                              setState(() {
                                password = val;
                              });
                            },
                            onChange: true,
                            label: "Password",
                            hint: "enter Your Password"),
                        SizedBox(height: 12),
                        TextFieldComp(
                            callback: (val){
                              setState(() {
                                rePassword = val;
                              });
                            },
                            onChange: true,
                            label: "Confirm Password",
                            hint: "re-enter Your Password"),
                        SizedBox(height: 12),
                        RoundedSmallButton(
                            text: "Signup as a Doctor",
                            email: email,
                            username: userName,
                            password: password,
                            confirmPassword: rePassword,
                            type: "doctor"),
                        SizedBox(height: 12),
                        RoundedSmallButton(
                            text: "Signup as a Patient",
                            email: email,
                            username: userName,
                            password: password,
                            confirmPassword: rePassword,
                            type: "user"),
                        SizedBox(height: 12),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'OR',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SocialMediaButton(icon: FontAwesomeIcons.facebookF),
                            SizedBox(width: 16),
                            SocialMediaButton(icon: FontAwesomeIcons.google),
                            SizedBox(width: 16),
                            SocialMediaButton(icon: FontAwesomeIcons.twitter),
                          ],
                        ),
                        SizedBox(height: 18),
                        DirectedLink(
                          text: 'Already have account ? Login Now',
                          navigation: Login(),
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ]),
      ),
    );
  }
}
