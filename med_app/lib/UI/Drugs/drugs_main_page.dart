import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/UI/Drugs/drugs_card_widget.dart';
import 'package:med_app/UI/PatientProfile/patient_profile_widget.dart';
import 'package:med_app/provider/patient_provider.dart';
import 'package:provider/provider.dart';

class DrugsMainPageScreen extends StatelessWidget {
  final String id;
  DrugsMainPageScreen({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Drugs',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              )),
          shadowColor: Colors.transparent,
          backgroundColor: ColorsCollection.mainColor,
        ),
        backgroundColor: Color(0xFFFFFFFF),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          DrugsMainPageWidget(
              // buttonNavigation: ,
              bg: 'assets/drugs.png',
              title: 'Drugs',
              subTtitle:
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s'),
          DrugsMainPageWidget(
              // buttonNavigation: ,
              bg: 'assets/consultation.jpg',
              title: 'Consultation',
              subTtitle:
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s'),
          DrugsMainPageWidget(
              // buttonNavigation: ,
              bg: 'assets/reminders.jpg',
              title: 'Reminders',
              subTtitle:
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s')
        ]));
  }
}
