import 'package:flutter/material.dart';
import 'package:med_app/UI/DoctorProfile/doctor_profile_cards.dart';
import 'package:med_app/UI/DoctorProfile/doctor_profile_settings/settings_about.dart';
import 'package:med_app/UI/DoctorProfile/doctor_profile_settings/settings_policy.dart';
import 'package:med_app/UI/DoctorProfile/doctor_profile_settings/settings_report.dart';
import 'package:med_app/UI/DoctorProfile/doctor_profile_settings/settings_terms.dart';

class DoctorSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        children: [
          DocotorCardWidget(
            cardLabel: 'Report an Issue',
            icon: Icons.app_settings_alt,
            buttonNavigation: SettingsReport(),
          ),
          DocotorCardWidget(
            cardLabel: 'Privacy Policy',
            icon: Icons.app_settings_alt,
            buttonNavigation: SettingsPolicy(),
          ),
          DocotorCardWidget(
            cardLabel: 'Terms of Use',
            icon: Icons.app_settings_alt,
            buttonNavigation: SettingsTerms(),
          ),
          DocotorCardWidget(
            cardLabel: 'About',
            icon: Icons.app_settings_alt,
            buttonNavigation: SettingsAbout(),
          )
        ],
      ),
    );
  }
}
