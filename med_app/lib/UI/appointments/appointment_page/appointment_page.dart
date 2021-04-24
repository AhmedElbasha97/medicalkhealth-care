import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/UI/callpages/index.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_database/firebase_database.dart';

// ignore: must_be_immutable
class AppointmentPage extends StatefulWidget {
  static FirebaseDatabase database = new FirebaseDatabase();
  final userType;
  final appointment;
  // ignore: non_constant_identifier_names
  final Imagee;
  final callback;

  AppointmentPage(
      {this.appointment, this.Imagee, this.callback, this.userType});

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  DatabaseReference userRef = AppointmentPage.database.reference();

  String downloadURL;
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

  getImageUrl(imagepath) async {
    downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref(imagepath)
        .getDownloadURL();
    return downloadURL;
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
            Expanded(
              flex: 7,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.4,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: ColorsCollection.mainColor, width: 5.0),
                          image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(widget.Imagee),
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
                            title: isPatient
                                ? Text('Doctor Name')
                                : Text('Patient Name'),
                            subtitle: Text(isPatient
                                ? "${widget.appointment.doctorName}"
                                : "${widget.appointment.patientName}"),
                          ),
                        ),
                        (isPatient)
                            ? Expanded(
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
                                  subtitle: Text(
                                      widget.appointment.doctorSpeciality ??
                                          ''),
                                ),
                              )
                            : Expanded(
                                flex: 1,
                                child: ListTile(
                                  leading: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.sick,
                                        size: 35.0,
                                        color: ColorsCollection.mainColor,
                                      ),
                                    ],
                                  ),
                                  title: Text('Symptoms'),
                                  subtitle:
                                      Text(widget.appointment.symptoms ?? ''),
                                ),
                              )
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
                            subtitle: Text("${widget.appointment.day}"),
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
                            subtitle: Text("${widget.appointment.hour}"),
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
                            subtitle: Text("${widget.appointment.fees} EGP"),
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
                            subtitle: Text("${widget.appointment.callMethod}"),
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
                                  FontAwesomeIcons.info,
                                  size: 35.0,
                                  color: ColorsCollection.mainColor,
                                ),
                              ],
                            ),
                            title: Text('Status'),
                            subtitle: Text('${widget.appointment.status}'),
                          ),
                        ),
                        if (!isPatient)
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 30.0, left: 15.0),
                              child: Container(
                                height: 48,
                                child: ElevatedButton(
                                  child: Text(
                                    "Show Case",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: 'Proxima',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: widget.appointment.caseFile != null
                                      ? () async {
                                          await showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (_) => GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: FutureBuilder(
                                                future: getImageUrl(widget
                                                    .appointment.caseFile),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    return Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height,
                                                      child: Image(
                                                        image: NetworkImage(
                                                            snapshot.data),
                                                      ),
                                                    );
                                                  }
                                                  return Text('');
                                                },
                                              ),
                                            ),
                                          );
                                        }
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    // elevation: 3.0,
                                    primary: Colors.grey[100],
                                    onPrimary: ColorsCollection.mainColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    IndexPage(
                      status: widget.appointment.status,
                      callbackDelete: widget.callback,
                      appointmentDate: appointmentDate,
                      method: widget.appointment.callMethod,
                      channelName: widget.appointment.channelName,
                      token: widget.appointment.token,
                      id: (widget.userType != 'patient')
                          ? widget.appointment.patientId
                          : widget.appointment.doctorId,
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
                              side: BorderSide(
                                  color: Colors.red[400], width: 1.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
