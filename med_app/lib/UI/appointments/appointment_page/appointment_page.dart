import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/UI/callpages/index.dart';

class AppointmentPage extends StatefulWidget {
  final userType;
  final appointment;
  final Image;
  final callback;

  AppointmentPage({this.appointment, this.Image, this.callback, this.userType});

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  var isPatient;
  var appointmentHour;
  DateTime appointmentDay;
  DateTime appointmentDate;

  @override
  void initState() {
    appointmentHour = DateFormat.jm().parse(widget.appointment.hour);
    appointmentDay = DateFormat('yyyy-MM-dd').parse(widget.appointment.day);
    appointmentDate = appointmentDay.add(
        Duration(hours: appointmentHour.hour, minutes: appointmentHour.minute));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isPatient = (widget.userType == 'patient');
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
                      height: MediaQuery.of(context).size.width * 0.45,
                      width: MediaQuery.of(context).size.width * 0.45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: ColorsCollection.mainColor, width: 5.0),
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(widget.Image),
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
                              ? widget.appointment.doctorName
                              : widget.appointment.patientName),
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
                            subtitle: Text(widget.appointment.doctorSpeciality),
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
                          subtitle: Text(widget.appointment.day),
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
                          subtitle: Text(widget.appointment.hour),
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
                          subtitle: Text(widget.appointment.fees.toString()),
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
                          subtitle: Text(widget.appointment.callMethod),
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
                    callbackDelete: widget.callback,
                    appointmentDate: appointmentDate,
                    method: widget.appointment.callMethod,
                    channelName: widget.appointment.channelName,
                    token: widget.appointment.token,
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
                          widget.callback();
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
