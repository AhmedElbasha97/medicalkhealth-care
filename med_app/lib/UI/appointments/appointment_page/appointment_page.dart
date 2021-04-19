import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/UI/callpages/index.dart';
import 'package:med_app/UI/doctors/doctor_booking_screen/doctor_booking_screen.dart';
import 'package:med_app/models/doctor.dart';
import 'package:med_app/models/patient.dart';

class AppointmentPage extends StatelessWidget {
  final userType;
  final appointment;
  final Image;
  final callback;

  AppointmentPage({this.appointment, this.Image, this.callback, this.userType});
  var isPatient;
  @override
  Widget build(BuildContext context) {
    isPatient = (userType == 'patient');
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
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                    child: Container(
                      height: MediaQuery.of(context).size.width * .45,
                      width: MediaQuery.of(context).size.width * .45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: ColorsCollection.mainColor, width: 5.0),
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(Image),
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
                          subtitle: Text(isPatient
                              ? appointment.doctorName
                              : appointment.patientName),
                        ),
                      ),
                      if (isPatient)
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
                            subtitle: Text(appointment.doctorSpeciality),
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
                          subtitle: Text(appointment.day),
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
                          subtitle: Text(appointment.hour),
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
                          subtitle: Text(appointment.fees.toString()),
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
                          subtitle: Text(appointment.callMethod),
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  IndexPage(
                    id: (userType != 'patient')
                        ? appointment.patientId
                        : appointment.doctorId,
                    method: appointment.callMethod,
                    channelName: appointment.channelName,
                    token: appointment.token,
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
