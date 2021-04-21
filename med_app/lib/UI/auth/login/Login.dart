import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/UI/auth/RestPassword/ResetPassswordScreen.dart';
import 'package:med_app/UI/auth/signup/Signup.dart';
import 'package:med_app/Widgets/directed_link.dart';
import 'package:med_app/Widgets/rounderd_small_button.dart';
import 'package:med_app/Widgets/social_media_button.dart';
import 'package:med_app/Widgets/text_field.dart';
import 'package:med_app/Widgets/top_hader.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final myEmailController = TextEditingController();
  String email="";
  String password="";
  final myPasswordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: ColorsCollection.mainColor,
        body: Stack(children: [
          Positioned(
              top: 80,
              left: 0,
              right: 0,
              child: Container(
                child: TopHader(
                    text: 'Login\nTo Your\nAccount', image: "assets/gbimage.png"),
              )),
          DraggableScrollableSheet(
              initialChildSize: 0.7,
              minChildSize: 0.7,
              maxChildSize: 0.7,
              builder: (context, scrollController) {

                return Container(
                  width: double.infinity,
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
                        TextFieldComp(onChange:true,label: "Email", hint: "example@email.com",callback: (val){
                          setState(() {
                            email = val;
                          });
                        },),
                        SizedBox(height: 16),
                        TextFieldComp(onChange: true,
                            label: "Password", hint: "enter Your Password",callback: (val){
                          setState(() {
                            password = val;
                          });
                          },),
                        SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ResetScreen()));
                            },
                            child: Text(
                              'Forgot Password ?',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        RoundedSmallButton(text: "Login",email: email ,password: password,type: 'login'),
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
                          text: 'Don\'t have account ? Sign Up Now',
                          navigation: SignUp(),
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
