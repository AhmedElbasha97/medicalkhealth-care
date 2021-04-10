import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med_app/UI/auth/login/Login.dart';
import 'package:med_app/Widgets/directed_link.dart';
import 'package:med_app/Widgets/rounderd_small_button.dart';
import 'package:med_app/Widgets/social_media_button.dart';
import 'package:med_app/Widgets/text_field.dart';
import 'package:med_app/Widgets/top_hader.dart';
import 'package:med_app/Styles/colors.dart';

class SignUp extends StatelessWidget {
  final myEmailController = TextEditingController();
  final myPasswordController = TextEditingController();
  final myConfirmPasswordController = TextEditingController();
  final myUsernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          controller: myUsernameController,
                          label: "UserName",
                          hint: "enter Your UserName"),
                      SizedBox(height: 12),
                      TextFieldComp(
                          controller: myEmailController,
                          label: "Email",
                          hint: "example@email.com"),
                      SizedBox(height: 12),
                      TextFieldComp(
                          controller: myPasswordController,
                          label: "Password",
                          hint: "enter Your Password"),
                      SizedBox(height: 12),
                      TextFieldComp(
                          controller: myConfirmPasswordController,
                          label: "Confirm Password",
                          hint: "re-enter Your Password"),
                      SizedBox(height: 12),
                      RoundedSmallButton(
                          text: "Signup as a Doctor",
                          email: myEmailController.text,
                          username: myUsernameController.text,
                          password: myPasswordController.text,
                          confirm_password: myConfirmPasswordController.text,
                          type: "doctor"),
                      SizedBox(height: 12),
                      RoundedSmallButton(
                          text: "Signup as a Patient",
                          email: myEmailController.text,
                          username: myUsernameController.text,
                          password: myPasswordController.text,
                          confirm_password: myConfirmPasswordController.text,
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
    );
  }
}
