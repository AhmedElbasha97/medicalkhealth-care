import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';

class SplashScreenWidget extends StatelessWidget {
  final String mainTitle;
  final String subTitle;
  final String image;

  const SplashScreenWidget(
      {Key key,
      @required this.mainTitle,
      @required this.subTitle,
      @required this.image})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double totalWidth = MediaQuery.of(context).size.width;
    double totalheight = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Image(
            image: AssetImage(image),
            height: totalheight * .33,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: SizedBox(
            width: totalWidth * .85,
            child: Text(mainTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ColorsCollection.splashTitleColor,
                    fontSize: 25,
                    height: 1.5,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Center(
            child: SizedBox(
              width: totalWidth * .7,
              child: Text(subTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      height: 1.5,
                      color: Color(0xff9DA1A4).withOpacity(.8),
                      fontSize: 14,
                      fontWeight: FontWeight.normal)),
            ),
          ),
        ),
      ],
    );
  }
}
