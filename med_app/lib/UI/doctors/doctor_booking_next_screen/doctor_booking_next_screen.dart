import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/UI/appointments/patient_appointment_list/appointment_list.dart';
import 'package:med_app/UI/doctors/doctor_booking_next_screen/sliding_booking_page.dart';
import 'package:med_app/Widgets/NavBar.dart';
import 'package:med_app/models/patient.dart';
import 'package:med_app/provider/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'progress_timeline_widget.dart';

class DoctorBookingNextScreen extends StatefulWidget {
  final userId;
  final daySelected;
  final hourSelected;
  final image;
  final avAppList;
  final List selectedHoursList;

  DoctorBookingNextScreen(
      {this.userId,
      this.daySelected,
      this.avAppList,
      this.hourSelected,
      this.image,
      this.selectedHoursList});
  @override
  _DoctorBookingNextScreenState createState() =>
      _DoctorBookingNextScreenState();
}

class _DoctorBookingNextScreenState extends State<DoctorBookingNextScreen> {
  var pageNumber = 0;
  Patient patient;
  bool isAppointed = false;
  ProgressTimeline progressTimeline;
  List<SingleState> states = [
    SingleState(stateTitle: 'Call Type'),
    SingleState(stateTitle: 'Details'),
    SingleState(stateTitle: 'Symptoms'),
    SingleState(stateTitle: 'Payment')
  ];

  @override
  void initState() {
    super.initState();
    progressTimeline = ProgressTimeline(
      states: states,
      iconSize: 35.0,
      checkedIcon: Icon(
        Icons.check_circle_outline,
        color: ColorsCollection.mainColor,
      ),
      connectorColor: ColorsCollection.mainColor,
      connectorWidth: 8.0,
      currentIcon: Icon(
        Icons.circle,
        color: ColorsCollection.mainColor,
      ),
      uncheckedIcon: Icon(
        Icons.circle,
        color: Colors.grey,
      ),
    );
    AppProvider provider = Provider.of<AppProvider>(context, listen: false);
    provider.getDoctorById(widget.userId);
    provider.getPatientById(provider.doctor.userId);
    patient = provider.patient;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black,
        title: Text('Booking Confirmation'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: ColorsCollection.mainColor,
        elevation: 0.0,
      ),
      body: Consumer<AppProvider>(
        builder: (context, databaseProvider, _) {
          return (databaseProvider.doctor != null)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: pageNumber == 0 ? 2 : 3,
                        child: ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 10.0, top: 15.0),
                              child: Row(
                                children: [
                                  Container(
                                    height: 70,
                                    width: 70,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(60.0),
                                      child: CachedNetworkImage(
                                        imageUrl: widget.image,
                                        placeholder: (
                                          context,
                                          url,
                                        ) =>
                                            Image.asset(
                                                'assets/images/placeholder.png'),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                                'assets/images/placeholder.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          databaseProvider.doctor.name,
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontFamily: 'Proxima',
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            databaseProvider.doctor.speciality),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0,
                                  top: 10.0,
                                  right: 8.0,
                                  bottom: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.local_atm,
                                        size: 25.0,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 3.0),
                                        child: Text(
                                          databaseProvider.doctor.fees,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 3.0),
                                        child: Text(
                                          'EGP',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.event,
                                        size: 25.0,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 3.0),
                                        child: Text(
                                          DateFormat('yyyy-MM-dd')
                                              .format(widget.daySelected)
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.schedule,
                                        size: 25.0,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 3.0),
                                        child: Text(
                                          widget.hourSelected.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: progressTimeline,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 3.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Call Type',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'Details',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    'Symptoms',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Payment',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SlidingBookingPage(
                            patient: patient,
                            avAppList: widget.avAppList,
                            selectedHoursList: widget.selectedHoursList,
                            progressIndicator: progressTimeline,
                            pageNumber: pageNumber,
                            callMethods: databaseProvider.doctor.callMethods,
                            doctorId: databaseProvider.doctor.userId,
                            doctorName: databaseProvider.doctor.name,
                            doctorAvatar: databaseProvider.doctor.userAvatar,
                            doctorSpeciality:
                                databaseProvider.doctor.speciality,
                            fees: databaseProvider.doctor.fees,
                            appointments:
                                databaseProvider.doctor.appointment.length,
                            daySelected: DateFormat('yyyy-MM-dd')
                                .format(widget.daySelected)
                                .toString(),
                            hourSelected: widget.hourSelected.toString(),
                            callbackAppointed: (val) {
                              setState(() {
                                isAppointed = val;
                              });
                            },
                            callback: () {
                              progressTimeline.gotoNextStage();
                              setState(() {
                                pageNumber++;
                              });
                              print(pageNumber);
                            }),
                        flex: pageNumber == 0 ? 4 : 5,
                      ),
                      if (pageNumber > 0)
                        (pageNumber < 4)
                            ? Expanded(
                                flex: 1,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 5.0),
                                        child: Container(
                                          width: 200,
                                          height: 55,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: ElevatedButton(
                                              child: Text(
                                                "Back",
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontFamily: 'Proxima',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              onPressed: pageNumber > 0
                                                  ? () {
                                                      progressTimeline
                                                          .gotoPreviousStage();
                                                      setState(() {
                                                        pageNumber--;
                                                      });
                                                    }
                                                  : null,
                                              style: ElevatedButton.styleFrom(
                                                elevation: 3.0,
                                                primary: Colors.grey[100],
                                                onPrimary:
                                                    ColorsCollection.mainColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 20.0, left: 5.0),
                                        child: Container(
                                          width: 200,
                                          height: 55,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: ElevatedButton(
                                              child: Text(
                                                "Next",
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontFamily: 'Proxima',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              onPressed: pageNumber < 3
                                                  ? () {
                                                      progressTimeline
                                                          .gotoNextStage();
                                                      setState(() {
                                                        pageNumber++;
                                                      });
                                                    }
                                                  : null,
                                              style: ElevatedButton.styleFrom(
                                                elevation: 3.0,
                                                primary:
                                                    ColorsCollection.mainColor,
                                                onPrimary: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      child: Text(
                                        "Homepage",
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontFamily: 'Proxima',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () async {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        String id = prefs.getString('userid');
                                        AppProvider provider =
                                            Provider.of<AppProvider>(context,
                                                listen: false);
                                        provider.getPatientById(id);

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Nav(
                                                    selectedIndex: 2,
                                                    userId: id,
                                                  )),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        // elevation: 3.0,
                                        primary: ColorsCollection.mainColor,
                                        onPrimary: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                    ],
                  ),
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
