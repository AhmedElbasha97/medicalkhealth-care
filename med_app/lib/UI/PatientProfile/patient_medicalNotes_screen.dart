import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/UI/PatientProfile/patient_medicalNotes_widget.dart';
import 'package:med_app/provider/patient_provider.dart';
import 'package:provider/provider.dart';

class PatientMedicalNotesScreen extends StatefulWidget {
  final String id;
  final String patientId;
  PatientMedicalNotesScreen({Key key, this.id, this.patientId})
      : super(key: key);

  @override
  _PatientMedicalNotesScreenState createState() =>
      _PatientMedicalNotesScreenState();
}

class _PatientMedicalNotesScreenState extends State<PatientMedicalNotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          color: ColorsCollection.splashTitleColor,
          onPressed: () => {
            Navigator.of(context).pop(),
          },
        ),
        title: Text(
          'Your Medical Notes',
          style: TextStyle(
              color: ColorsCollection.splashTitleColor,
              fontWeight: FontWeight.normal,
              fontSize: 22),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
      ),
      body: Consumer<PaitentDatabaseProvider>(
        builder: (context, databaseProvider, _) {
          return (databaseProvider.patient.medicalNotes != null)
              ? ListView.builder(
                  itemCount: databaseProvider.patient.medicalNotes.length,
                  itemBuilder: (ctx, index) {
                    final medicalNote =
                        databaseProvider.patient.medicalNotes[index];
                    return PatientMedicalNotesWidget(
                      medicalNote: medicalNote,
                      index: index,
                    );
                  })
              : Center(
                  child: Center(
                  child: Image(
                    image: AssetImage('assets/medicalnoteBG.png'),
                  ),
                ));
        },
      ),
    );
  }
}
