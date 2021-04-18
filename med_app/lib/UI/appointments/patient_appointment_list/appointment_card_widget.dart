import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:med_app/UI/appointments/appointment_page/appointment_page.dart';
import 'package:med_app/models/doctor.dart';
import 'package:med_app/models/patient.dart';
import 'package:med_app/provider/app_provider.dart';
import 'package:med_app/repository/database_repo.dart';
import 'package:provider/provider.dart';

class AppointmentCard extends StatefulWidget {
  static FirebaseDatabase database = new FirebaseDatabase();
  final userId;
  final appointment;
  final appointments;
  final index;
  final userType;
  AppointmentCard(
      {this.appointment,
      this.userId,
      this.appointments,
      this.index,
      this.userType});

  @override
  _AppointmentCardState createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  DatabaseReference userRef = AppointmentCard.database.reference();

  String downloadURL;
  bool isPatient;

  getImageUrl(imagepath) async {
    downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref(imagepath)
        .getDownloadURL();
    return downloadURL;
  }

  deleteAppointment() async {
    DatabaseRepositories _repo = DatabaseRepositories();

    var app = userRef.child('users/${widget.userId}');
    var appDoctor = userRef.child(
        'users/${isPatient ? widget.appointment.doctorId : widget.appointment.patientId}');

    widget.appointments.removeAt(widget.index);
    var newApps = widget.appointments.map((e) => e.toJson()).toList();

    if (widget.userType == 'patient') {
      Doctor doctor = await _repo.fetchDoctor(widget.appointment.doctorId);
      var docApps = doctor.appointment;
      print(docApps);
      docApps
          .removeWhere((element) => element.token == widget.appointment.token);
      var docAppsMapped = docApps.map((e) => e.toJson()).toList();
      await app.update({"appointment": newApps}).then((_) {
        appDoctor.update({"appointment": docAppsMapped});
        print('Transaction  committed.');
        AppProvider provider = Provider.of<AppProvider>(context, listen: false);
        provider.getPatientById(widget.userId);
      });
    } else {
      Patient patient = await _repo.fetchPatient(widget.appointment.patientId);
      var patApps = patient.appointment;
      patApps
          .removeWhere((element) => element.token == widget.appointment.token);
      var patAppsMapped = patApps.map((e) => e.toJson()).toList();
      await app.update({"appointment": newApps}).then((_) {
        appDoctor.update({"appointment": patAppsMapped});
        print('Transaction  committed.');
        AppProvider provider = Provider.of<AppProvider>(context, listen: false);
        provider.getPatientById(widget.userId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    isPatient = (widget.userType == 'patient');
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
                                    widget.appointment.day.toString(),
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
                                      widget.appointment.hour.toString(),
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
                                    Image: downloadURL,
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
                                deleteAppointment();
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
