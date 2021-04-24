import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/UI/Blogs/Blogs_Main_Screen.dart';
import 'package:med_app/UI/Drugs/drugs_card_widget.dart';
import 'package:med_app/UI/spcialitypage/speciality_page.dart';

class NutritionScreen extends StatelessWidget {
  final String id;
  NutritionScreen({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('Nutrition',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                )),
            shadowColor: Colors.transparent,
            backgroundColor: ColorsCollection.mainColor,
          ),
          backgroundColor: Color(0xFFFFFFFF),
          body: Stack(children: <Widget>[
            Positioned(
                top: 0,
                bottom: MediaQuery.of(context).size.width * 1,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorsCollection.mainColor,
                    // borderRadius: BorderRadius.only(
                    //   bottomRight: Radius.circular(10.0),
                    //   bottomLeft: Radius.circular(10.0),
                    // ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, top: 50),
                    child: Text(
                      'Make Your \n Consultation Now',
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                )),
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              DrugsMainPageWidget(
                  buttonNavigation: BlogHomescreen(
                    neturationNavigation: 1,
                    navigateFromOtherScreen: true,
                  ),
                  bg: 'assets/Blogs.jpg',
                  title: 'Nutritional Blogs',
                  subTtitle:
                      'Read the latest nutritional blogs and keep up with the trendy nutritional regimes where you can find practical solutions to achieve a healthy body.'),
              Padding(
                padding: const EdgeInsets.only(bottom: 55.0),
                child: DrugsMainPageWidget(
                    buttonNavigation: SpecialityPage(
                      speciality: 'Nutrition',
                    ),
                    bg: 'assets/consultation.jpg',
                    title: 'Nutritional Consultation',
                    subTtitle:
                        'Online nutritional consultation involves building a detailed picture of your lifestyle, eating habits, medical history and any concerns you have about your health and wellbeing.'),
              ),
            ]),
          ])),
    );
  }
}
