import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/UI/Drugs/drugs_card_widget.dart';
import 'package:med_app/UI/drug_reminder/screens/welcome/reminderIntro.dart';
import 'package:med_app/UI/spcialitypage/speciality_page.dart';

import 'DrugsList.dart';

class DrugsMainPageScreen extends StatelessWidget {
  final String id;
  DrugsMainPageScreen({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              DrugsMainPageWidget(
                buttonNavigation: DrugsList(),
                bg: 'assets/drugs.png',
                title: 'Drugs',
                subTtitle:
                    'Online medical resource dedicated to offering detailed and current pharmaceutical information on brand and generic egyptian drugs and their prices.',
              ),
              DrugsMainPageWidget(
                  bg: 'assets/consultation.jpg',
                  title: 'Consultation',
                  buttonNavigation: SpecialityPage(
                    speciality: 'Pharmacist',
                  ),
                  subTtitle:
                      'Online doctors see and treat patients virtually using telehealth. With virtual visits, you can see a doctor online and get medical advice along with necessary prescriptions.'),
              DrugsMainPageWidget(
                  buttonNavigation: ReminderIntro(),
                  bg: 'assets/reminders.jpg',
                  title: 'Reminders',
                  subTtitle:
                      'Remembering to take your medications at the right time and the right dosage can be hard for anyone. Our drug reminder to help you remember your medications schedule.')
            ]),
          )),
    );
  }
}
