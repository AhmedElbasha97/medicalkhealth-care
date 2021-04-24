import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';

class PatientMedicalNotesWidget extends StatelessWidget {
  final String medicalNote;
  final int index;

  const PatientMedicalNotesWidget({Key key, this.medicalNote, this.index})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 0, top: 10),
        child: new Container(
            child: Card(
                elevation: 5,
                shadowColor: ColorsCollection.mainColor,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 25,
                                  top: 25,
                                ),
                                child: Row(children: [
                                  Expanded(
                                    flex: 4,
                                    child: Text(medicalNote,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color:
                                                ColorsCollection.secondaryColor,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16)),
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]))));
  }
}
