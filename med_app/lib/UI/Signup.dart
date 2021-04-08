import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med_app/Widgets/directed_link.dart';
import 'package:med_app/Widgets/rounderd_small_button.dart';
import 'package:med_app/Widgets/social_media_button.dart';
import 'package:med_app/Widgets/text_field.dart';
import 'package:med_app/Widgets/top_hader.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00A1A7),
      body: Stack(children: [
        Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Container(
              child: TopHader(
                  text: 'Signup\nTo Your\nAccount',
                  image: "lib/assets/gbimage.png"),
            )),
        DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.4,
            maxChildSize: 0.8,
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
                          label: "UserName", hint: "enter Your UserName"),
                      SizedBox(height: 16),
                      TextFieldComp(label: "Email", hint: "example@email.com'"),
                      SizedBox(height: 16),
                      TextFieldComp(
                          label: "Password", hint: "enter Your Password"),
                      SizedBox(height: 16),
                      TextFieldComp(
                          label: "Confirm Password",
                          hint: "re-enter Your Password"),
                      SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            'Forgot Password ?',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      RoundedSmallButton(text: "SignUp", navigation: "Login"),
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
                        navigation: "Login",
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              );
            }),
      ]),
    );
  }
}
