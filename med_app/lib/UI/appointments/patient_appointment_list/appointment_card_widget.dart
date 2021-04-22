import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:med_app/UI/appointments/appointment_page/appointment_page.dart';
import 'package:med_app/UI/appointments/appointment_page/session_notification.dart';
import 'package:med_app/Widgets/show_alert_dialog_widget.dart';
import 'package:med_app/models/doctor.dart';
import 'package:med_app/models/patient.dart';
import 'package:med_app/provider/app_provider.dart';
import 'package:med_app/repository/database_repo.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentCard extends StatefulWidget {
  static FirebaseDatabase database = new FirebaseDatabase();
  final appointment;
  final appointments;
  final index;
  final userType;
  final userId;
  AppointmentCard(
      {this.appointment,
      this.appointments,
      this.index,
      this.userType,
      this.userId});

  @override
  _AppointmentCardState createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  DatabaseReference userRef = AppointmentCard.database.reference();
  final SessionNotification _notifications = SessionNotification();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  DatabaseRepositories _repo = DatabaseRepositories();
  Doctor doctor;
  Patient patient;
  var appDoctor;
  var app;
  var appDoc;
  var availDates;
  var dateAppointment;
  SharedPreferences prefs;

  String downloadURL;
  bool isPatient;

  getImageUrl(imagepath) async {
    downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref(imagepath)
        .getDownloadURL();
    return downloadURL;
  }

  deleteAppointment() async {
    widget.appointments.removeAt(widget.index);
    var newApps = widget.appointments.map((e) => e.toJson()).toList();
SharedPreferences prefs = await SharedPreferences.getInstance();
    _notifications.removeNotify(
        prefs.getInt('notifyId'), flutterLocalNotificationsPlugin);

    doctor = await _repo
        .fetchDoctor(isPatient ? widget.appointment.doctorId : widget.userId);

    if (dateAppointment.difference(DateTime.now()).inMinutes > 0) {
      availDates = doctor.availableAppointment;
      var appointDay = widget.appointment.day;
      for (var i = 0; i < availDates.length; i++) {
        if (availDates[i].availableDay == appointDay) {
          availDates[i].availableHours.add(widget.appointment.hour);
          availDates[i].availableHours.sort((a, b) => DateFormat.jm()
              .parse(a)
              .hour
              .compareTo(DateFormat.jm().parse(b).hour));
        }
      }
      var availDatesMapped = availDates.map((e) => e.toJson()).toList();
      appDoc.update({"availableAppointment": availDatesMapped});
    }

    if (widget.userType == 'patient') {
      var docApps = doctor.appointment;
      docApps
          .removeWhere((element) => element.token == widget.appointment.token);
      var docAppsMapped = docApps.map((e) => e.toJson()).toList();
      await app.update({"appointment": newApps}).then((_) {
        appDoctor.update({"appointment": docAppsMapped});
        print('Transaction  committed.');
        AppProvider provider = Provider.of<AppProvider>(context, listen: false);
        provider.getUserType(widget.userId);
      });
    } else {
      patient = await _repo.fetchPatient(widget.appointment.patientId);
      var patApps = patient.appointment;
      patApps
          .removeWhere((element) => element.token == widget.appointment.token);
      var patAppsMapped = patApps.map((e) => e.toJson()).toList();
      await app.update({"appointment": newApps}).then((_) {
        appDoctor.update({"appointment": patAppsMapped});
        print('Transaction  committed.');
        AppProvider provider = Provider.of<AppProvider>(context, listen: false);
        provider.getUserType(widget.userId);
      });
    }
  }


  @override
  void initState() {
    isPatient = (widget.userType == 'patient');
    app = userRef.child('users/${widget.userId}');
    appDoctor = userRef.child(
        'users/${isPatient ? widget.appointment.doctorId : widget.appointment.patientId}');
    appDoc = userRef.child(
        'users/${isPatient ? widget.appointment.doctorId : widget.userId}');
    dateAppointment = DateFormat('yyyy-MM-dd')
        .parse(widget.appointment.day)
        .add(Duration(
            hours: (DateFormat.jm().parse(widget.appointment.hour).hour),
            minutes: (DateFormat.jm().parse(widget.appointment.hour).minute)));
    if (dateAppointment.difference(DateTime.now()).inMinutes < -30) {
      deleteAppointment();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 2.0),
      child: Container(
        height: 140,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(color: ColorsCollection.mainColor, width: 2.0),
          ),
          elevation: 5.0,
          child: Container(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: FutureBuilder(
                      future: getImageUrl(isPatient
                          ? widget.appointment.doctorAvatar
                          : widget.appointment.patientAvatar),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            width: MediaQuery.of(context).size.width / 4.5,
                            height: MediaQuery.of(context).size.width / 4.5,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(snapshot.data),
                                  fit: BoxFit.fill),
                            ),
                          );
                        }
                        return Text('');
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (!isPatient)
                            Text(
                              'Dr. ',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Proxima'),
                            ),
                          Text(
                            isPatient
                                ? widget.appointment.doctorName
                                : widget.appointment.patientName,
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Proxima'),
                          ),
                        ],
                      ),
                      Text(
                          isPatient ? widget.appointment.doctorSpeciality : ''),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.event,
                                  size: 25.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 3.0),
                                  child: Text(
                                    widget.appointment.day.toString() ?? '',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.schedule,
                                    size: 25.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 3.0),
                                    child: Text(
                                      widget.appointment.hour.toString() ?? '',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            child: Text("View Details"),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AppointmentPage(
                                    appointment: widget.appointment,
                                    Imagee: downloadURL,
                                    userType: widget.userType,
                                    callback: () {
                                      deleteAppointment();
                                    },
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 3.0,
                              primary: Colors.white,
                              onPrimary: ColorsCollection.mainColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(
                                    color: ColorsCollection.mainColor,
                                    width: 1.0),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: ElevatedButton(
                              child: Text("Cancel"),
                              onPressed: () {
                                showAlertDialog(
                                    context,
                                    "Are you sure to delete appointment?",
                                    deleteAppointment);
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 3.0,
                                primary: Colors.white,
                                onPrimary: Colors.red[400],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(
                                      color: Colors.red[400], width: 1.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                (widget.appointment.callMethod == "chat")
                    ? Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, right: 15.0),
                          child: Icon(
                            FontAwesomeIcons.solidCommentDots,
                            color: ColorsCollection.mainColor,
                          ),
                        ),
                      )
                    : (widget.appointment.callMethod == "voice")
                        ? Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, right: 15.0),
                              child: Icon(
                                Icons.phone_in_talk,
                                color: ColorsCollection.mainColor,
                                size: 26.0,
                              ),
                            ),
                          )
                        : Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, right: 15.0),
                              child: Icon(
                                FontAwesomeIcons.video,
                                color: ColorsCollection.mainColor,
                                size: 22.0,
                              ),
                            ),
                          )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
