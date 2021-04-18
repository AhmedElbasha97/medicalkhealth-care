import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/UI/doctors/doctor_booking_screen/doctor_booking_screen.dart';

class AppointmentPage extends StatelessWidget {
  final appointment;
  final doctorImage;
  final callback;

  AppointmentPage({this.appointment, this.doctorImage, this.callback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.black,
          title: Text('Appointment Details'),
          backgroundColor: ColorsCollection.mainColor,
          elevation: 0.0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: ColorsCollection.mainColor, width: 5.0),
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(doctorImage),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.user,
                              size: 35.0,
                              color: ColorsCollection.mainColor,
                            ),
                          ],
                        ),
                        title: Text('Doctor Name'),
                        subtitle: Text('Ahmed Samy'),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.format_list_bulleted_outlined,
                              size: 35.0,
                              color: ColorsCollection.mainColor,
                            ),
                          ],
                        ),
                        title: Text('Speciality'),
                        subtitle: Text('Dermatology'),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.event_note,
                              size: 35.0,
                              color: ColorsCollection.mainColor,
                            ),
                          ],
                        ),
                        title: Text('Date'),
                        subtitle: Text('17-04-2021'),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.schedule,
                              size: 35.0,
                              color: ColorsCollection.mainColor,
                            ),
                          ],
                        ),
                        title: Text('Hour'),
                        subtitle: Text('10:00 AM'),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.local_atm,
                              size: 35.0,
                              color: ColorsCollection.mainColor,
                            ),
                          ],
                        ),
                        title: Text('Fees'),
                        subtitle: Text('200 EGP'),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.video_call,
                              size: 35.0,
                              color: ColorsCollection.mainColor,
                            ),
                          ],
                        ),
                        title: Text('Call Type'),
                        subtitle: Text('Video Call'),
                      ),
                    ),
                  ],
                ),
                ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.info,
                        size: 35.0,
                        color: ColorsCollection.mainColor,
                      ),
                    ],
                  ),
                  title: Text('Status'),
                  subtitle: Text('Pending Payment'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text(
                        "View Doctor's Profile",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DoctorBookingScreen(
                                      userId: appointment.doctorId,
                                    )));
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 3.0,
                        primary: Colors.white,
                        onPrimary: ColorsCollection.mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          side: BorderSide(
                              color: ColorsCollection.mainColor, width: 1.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Text(
                          "Cancel Appointment",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        onPressed: () {
                          callback();
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 3.0,
                          primary: Colors.red[400],
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            side:
                                BorderSide(color: Colors.red[400], width: 1.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
