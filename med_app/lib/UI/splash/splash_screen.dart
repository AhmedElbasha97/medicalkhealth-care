import 'package:flutter/material.dart';
import 'package:animated_onboarding/animated_onboarding.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/UI/register/register_screen.dart';
import 'package:med_app/UI/splash/splash_widget.dart';

class Splash extends StatelessWidget {
  final _pages = [
    OnboardingPage(
        child: SplashScreenWidget(
            mainTitle: 'Consult With Our Expert Doctors',
            subTitle:
                'Make An Appointment Any Time Lorem ipsum dolor sit amet Lorem',
            image: 'assets/splash1.png'),
        color: Colors.grey[300]),
    OnboardingPage(
        child: SplashScreenWidget(
            mainTitle: 'Make An Appointment Any Time',
            subTitle:
                'Make An Appointment Any Time Lorem ipsum dolor sit amet Lorem',
            image: 'assets/splash2.png'),
        color: Colors.grey[200]),
    OnboardingPage(
        child: SplashScreenWidget(
            mainTitle: 'Identifying Your Problems By Our Experts',
            subTitle:
                'Make An Appointment Any Time Lorem ipsum dolor sit amet Lorem',
            image: 'assets/splash3.png'),
        color: Colors.white),
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedOnboarding(
      pages: _pages,
      pageController: PageController(),
      onFinishedButtonTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ResgisterScreen()));
      },
      topLeftChild: Text(
        "",
        style: TextStyle(color: ColorsCollection.mainColor, fontSize: 24),
      ),
      // ignore: deprecated_member_use
      topRightChild: FlatButton(
        child: Text(
          "Skip",
          style: TextStyle(
              fontSize: 16,
              color: ColorsCollection.mainColor,
              fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ResgisterScreen()));
        },
      ),
    );
  }
}
