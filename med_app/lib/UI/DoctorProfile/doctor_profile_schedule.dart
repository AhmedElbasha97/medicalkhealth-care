import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/Widgets/available_date_picker.dart';
import 'package:med_app/Widgets/available_hour_picker.dart';
import 'package:med_app/Widgets/text_field.dart';

class DoctorSchedule extends StatefulWidget {
  final doctorId;

  DoctorSchedule({this.doctorId});
  @override
  _DoctorScheduleState createState() => _DoctorScheduleState();
}

class _DoctorScheduleState extends State<DoctorSchedule> {
  static FirebaseDatabase database = new FirebaseDatabase();
  DatabaseReference userRef = database.reference();

  List<DateTime> _selectedDays = [];
  List<String> _selectedDates = [];
  List<dynamic> _selectedHours = [];
  final fees = TextEditingController();
  var test;

  addAvailableDate(stringDates) async {
    var doctor = userRef.child('users/${widget.doctorId}');
    var doctorFees = userRef.child('users/${widget.doctorId}/fees');
    await doctor.update({"availableAppointment": stringDates}).then((_) {
      print('Transaction  committed.');
    });
    await doctorFees.set(fees.text).then((_) {
      print('Transaction  committed.');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Schedule'),
        backgroundColor: ColorsCollection.mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
                      child: Text(
                        'Available Days:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
                      child: Text(
                        'Add the available days in which you can perform the medical sessions then the available hours selection will appear:',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    Row(
                      children: [
                        AvailableDatePicker(callback: (val) {
                          setState(() {
                            _selectedDays = val;
                          });
                          print(_selectedDays);
                        }),
                        if (_selectedDays.length != 0)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedDays = [];
                                    _selectedDates = [];
                                  });
                                },
                                child: Text('Reset Schedule'),
                                style: ElevatedButton.styleFrom(
                                  elevation: 3.0,
                                  primary: Colors.red[400],
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                )),
                          )
                      ],
                    ),
                    if (_selectedDays.length != 0)
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: AvailableHourPicker(callback: (val) {
                          setState(() {
                            _selectedHours = val;
                            _selectedDates = _selectedDays
                                .map((e) => DateFormat('yyyy-MM-dd')
                                    .format(e)
                                    .toString())
                                .toList();
                          });
                          print(_selectedHours);
                        }),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, bottom: 10.0, top: 10.0),
                      child: Text(
                        'Session Fees:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    ),
                    TextFieldComp(
                      label: 'How much\'s the fees of your session',
                      hint: 'The value is in EGP',
                      keyboardTypeNumber: true,
                      controller: fees,
                      callback: (val) {
                        setState(() {
                          test = val;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: (_selectedDates.length != 0 &&
                            _selectedHours.length != 0)
                        ? () {
                            var stringDates = _selectedDates
                                .map<Map<String, dynamic>>((e) => {
                                      "availableDay": e,
                                      "availableHours": _selectedHours
                                    })
                                .toList();
                            addAvailableDate(stringDates);
                          }
                        : null,
                    child: Text(
                      'Submit Schedule',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 3.0,
                      primary: ColorsCollection.mainColor,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
