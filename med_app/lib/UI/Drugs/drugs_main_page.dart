import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/UI/Drugs/drugs_card_widget.dart';
import 'package:med_app/UI/drug_reminder/screens/welcome/reminderIntro.dart';
import 'package:med_app/UI/spcialitypage/speciality_page.dart';

import 'DrugsList.dart';

class DrugsMainPageScreen extends StatelessWidget {
  final String id;
  DrugsMainPageScreen({Key key, this.id }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
  onWillPop: () async => false,
          child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('Drugs',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                )),
            shadowColor: Colors.transparent,
            backgroundColor: ColorsCollection.mainColor,
          ),
          backgroundColor: Color(0xFFFFFFFF),
          body: SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              DrugsMainPageWidget(
                  buttonNavigation: DrugsList(),
                  bg: 'assets/drugs.png',
                  title: 'Drugs',
                  subTtitle:
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s'),
              DrugsMainPageWidget(
                  bg: 'assets/consultation.jpg',
                  title: 'Consultation',
                  buttonNavigation: SpecialityPage(
                    speciality: 'Pharmacist',
                  ),
                  subTtitle:
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s'),
              DrugsMainPageWidget(
                  buttonNavigation: ReminderIntro(),
                  bg: 'assets/reminders.jpg',
                  title: 'Reminders',
                  subTtitle:
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s')
            ]),
          )),
    );
  }
}
