import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/UI/doctors/doctor_booking_next_screen/doctor_booking_next_screen.dart';
import 'package:med_app/UI/doctors/doctor_booking_screen/hour_picker_widget.dart';
import 'package:med_app/Widgets/doctor_reviews_widget.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:med_app/providedrs/database_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class DoctorBookingScreen extends StatefulWidget {
  final userId;
  DoctorBookingScreen({this.userId});
  @override
  _DoctorBookingScreenState createState() => _DoctorBookingScreenState();
}

class _DoctorBookingScreenState extends State<DoctorBookingScreen> {
  DatePickerController _controller = DatePickerController();
  DateTime selectedDay = DateTime.now();
  String bookingHourSelected;
  String doctorImage;

  List avAppList;
  List filteredAvDayList;
  List formattedAvDayList;
  List selectedHoursList;

  getImgeUrl(imagepath) async {
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref(imagepath)
        .getDownloadURL();
    return downloadURL;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.black,
          title: Text(''),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_sharp),
            color: Colors.white,
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        extendBodyBehindAppBar: true,
        body: ChangeNotifierProvider<DatabaseProvider>(
          create: (context) => DatabaseProvider(id: widget.userId),
          child: Consumer<DatabaseProvider>(
            builder: (context, databaseProvider, _) {
              if (databaseProvider.doctor != null) {
                avAppList = databaseProvider.doctor.availableAppointment;
                filteredAvDayList = avAppList.map((element) {
                  var avDay =
                      DateFormat('dd-MM-yyyy').parse(element.availableDay);
                  if (avDay.day >= DateTime.now().day &&
                      avDay.month >= DateTime.now().month) {
                    if (selectedHoursList == null) {
                      selectedHoursList = element.availableHours;
                    }
                    return avDay;
                  }
                }).toList();
                filteredAvDayList.removeWhere((element) => element == null);
                formattedAvDayList =
                    filteredAvDayList.map((e) => e.day).toList();
              }
              return (databaseProvider.doctor != null)
                  ? Stack(
                      // clipBehavior: Clip.none,
                      children: [
                        Positioned(
                            child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ],
                        )),
                        Positioned(
                          child: FutureBuilder(
                              future: getImgeUrl(
                                  databaseProvider.doctor.userAvatar),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  doctorImage = snapshot.data;
                                  return Container(
                                    height: 300,
                                    width: double.infinity,
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot.data,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                }
                                return Center(
                                    child: CircularProgressIndicator());
                              }),
                        ),
                        Positioned(
                          top: 250,
                          child: Container(
                            height: MediaQuery.of(context).size.height - 220,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  width: 5.0,
                                  color: ColorsCollection.mainColor),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40.0),
                                  topRight: Radius.circular(
                                      40.0) //                 <--- border radius here
                                  ),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20.0, right: 20.0, left: 20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              databaseProvider.doctor.name,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 30,
                                                  fontFamily: 'Proxima',
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Row(
                                              children: [
                                                if (databaseProvider
                                                    .doctor.callMethods.chat)
                                                  Icon(
                                                    FontAwesomeIcons
                                                        .solidCommentDots,
                                                    color: ColorsCollection
                                                        .mainColor,
                                                  ),
                                                if (databaseProvider
                                                    .doctor.callMethods.voice)
                                                  Icon(
                                                    Icons.phone_in_talk,
                                                    color: ColorsCollection
                                                        .mainColor,
                                                    size: 26.0,
                                                  ),
                                                if (databaseProvider
                                                    .doctor.callMethods.video)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10.0),
                                                    child: Icon(
                                                      FontAwesomeIcons.video,
                                                      color: ColorsCollection
                                                          .mainColor,
                                                    ),
                                                  )
                                              ],
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              databaseProvider
                                                  .doctor.speciality,
                                              style: TextStyle(
                                                  color: ColorsCollection
                                                      .mainColor,
                                                  fontSize: 20,
                                                  fontFamily: 'Proxima',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Row(
                                                children: [
                                                  SmoothStarRating(
                                                      allowHalfRating: false,
                                                      onRated: (v) {},
                                                      starCount: 5,
                                                      rating: 4.0,
                                                      size: 20.0,
                                                      isReadOnly: true,
                                                      color: ColorsCollection
                                                          .mainColor,
                                                      borderColor:
                                                          ColorsCollection
                                                              .mainColor,
                                                      spacing: 0.0),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(
                                                      databaseProvider
                                                          .doctor.reviews.length
                                                          .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              ColorsCollection
                                                                  .mainColor,
                                                          fontSize: 18,
                                                          fontFamily: 'Proxima',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0, bottom: 5.0),
                                          child: Text(
                                            databaseProvider.doctor.bio,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontFamily: 'Proxima',
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          child: Row(
                                            children: [
                                              Text('Experience: ',
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontFamily: 'Proxima',
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(
                                                  databaseProvider
                                                      .doctor.experience,
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontFamily: 'Proxima',
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(' Years in ',
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontFamily: 'Proxima',
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(
                                                  databaseProvider
                                                      .doctor.speciality,
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontFamily: 'Proxima',
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text('Languages: ',
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontFamily: 'Proxima',
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: Container(
                                                height: 30,
                                                width: 120,
                                                child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: databaseProvider
                                                        .doctor
                                                        .languages
                                                        .length,
                                                    itemBuilder: (ctx, index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 5.0),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                ColorsCollection
                                                                    .mainColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5.0)),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8.0,
                                                                    vertical:
                                                                        5.0),
                                                            child: Text(
                                                              databaseProvider
                                                                      .doctor
                                                                      .languages[
                                                                  index],
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      17.0,
                                                                  fontFamily:
                                                                      'Proxima',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Text(
                                            'Reviews:',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontFamily: 'Proxima',
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        ReviewsSlider(
                                            reviews: databaseProvider
                                                .doctor.reviews),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5.0, bottom: 5.0),
                                          child: Text(
                                            'Book Date:',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontFamily: 'Proxima',
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        DatePicker(
                                          DateTime.now(),
                                          controller: _controller,
                                          initialSelectedDate: DateTime.now(),
                                          selectionColor:
                                              ColorsCollection.mainColor,
                                          selectedTextColor: Colors.white,
                                          daysCount: formattedAvDayList[
                                                  formattedAvDayList.length -
                                                      1] -
                                              formattedAvDayList[0] +
                                              1,
                                          activeDates: avAppList
                                              .map(
                                                (e) => DateTime.now().add(
                                                  Duration(
                                                      days: (DateFormat(
                                                                  'dd-MM-yyyy')
                                                              .parse(e
                                                                  .availableDay)
                                                              .day) -
                                                          DateTime.now().day),
                                                ),
                                              )
                                              .toList(),
                                          onDateChange: (date) {
                                            setState(() {
                                              selectedDay = date;
                                            });
                                            selectedHoursList = avAppList
                                                .firstWhere((element) =>
                                                    DateFormat('dd-MM-yyyy')
                                                        .parse(element
                                                            .availableDay)
                                                        .day ==
                                                    selectedDay.day)
                                                .availableHours;
                                          },
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0, bottom: 5.0),
                                          child: Text(
                                            'Select Time:',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontFamily: 'Proxima',
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        HourPicker(
                                          height: 50.0,
                                          width: 100.0,
                                          availableHours: selectedHoursList,
                                          callback: (val) {
                                            setState(() {
                                              bookingHourSelected = val;
                                            });
                                          },
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 40.0),
                                          child: Container(
                                            width: double.infinity,
                                            height: 55,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              child: ElevatedButton(
                                                child: Text(
                                                  "Book Now",
                                                  style: TextStyle(
                                                      fontSize: 20.0,
                                                      fontFamily: 'Proxima',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => DoctorBookingNextScreen(
                                                            userId:
                                                                widget.userId,
                                                            daySelected:
                                                                selectedDay,
                                                            hourSelected:
                                                                bookingHourSelected,
                                                            image:
                                                                doctorImage)),
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: ColorsCollection
                                                      .mainColor,
                                                  onPrimary: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            32.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        ));
  }
}
