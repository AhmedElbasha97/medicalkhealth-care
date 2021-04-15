import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/UI/Blogs/Blogs_Main_Screen.dart';
import 'package:med_app/UI/Drugs/drugs_card_widget.dart';
import 'package:med_app/UI/PatientProfile/patient_profile_widget.dart';
import 'package:med_app/provider/patient_provider.dart';
import 'package:provider/provider.dart';

class NutritionScreen extends StatelessWidget {
  final String id;
  NutritionScreen({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0, top: 50),
                  child: Text(
                    'Make Your Consultation Now',
                    style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              )),
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            DrugsMainPageWidget(
                buttonNavigation: BlogHomescreen(neturationNavigation: 1),
                bg: 'assets/Blogs.jpg',
                title: 'Nutruitonal Blogs',
                subTtitle:
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s'),
            Padding(
              padding: const EdgeInsets.only(bottom: 55.0),
              child: DrugsMainPageWidget(
                  // buttonNavigation ,
                  bg: 'assets/consultation.jpg',
                  title: 'Nutruitonal Consultation',
                  subTtitle:
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s'),
            ),
          ]),
        ]));
  }
}
