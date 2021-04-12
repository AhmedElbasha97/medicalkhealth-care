import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med_app/UI/doctors/doctor_booking_screen/hour_picker.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class DoctorBookingScreen extends StatefulWidget {
  @override
  _DoctorBookingScreenState createState() => _DoctorBookingScreenState();
}

class _DoctorBookingScreenState extends State<DoctorBookingScreen> {
  DateTime selectedDay = DateTime.now();
  DatePickerController _controller = DatePickerController();
  String bookingHourSelected;

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
      body: Stack(
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
            child: Image(
              image: AssetImage("assets/doctor.jpg"),
            ),
          ),
          Positioned(
            top: 250,
            child: Container(
              height: MediaQuery.of(context).size.height - 220,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 5.0, color: Color(0xFF0299B3)),
                borderRadius: BorderRadius.all(Radius.circular(
                        40.0) //                 <--- border radius here
                    ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, right: 20.0, left: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Dr. Ernest Lopez',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontFamily: 'Proxima',
                                  fontWeight: FontWeight.w700),
                            ),
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.solidCommentDots,
                                  color: Color(0xFF0299B3),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Icon(
                                    FontAwesomeIcons.video,
                                    color: Color(0xFF0299B3),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Neurology',
                              style: TextStyle(
                                  color: Color(0xFF0299B3),
                                  fontSize: 20,
                                  fontFamily: 'Proxima',
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                SmoothStarRating(
                                    allowHalfRating: false,
                                    onRated: (v) {},
                                    starCount: 5,
                                    rating: 4.0,
                                    size: 20.0,
                                    isReadOnly: true,
                                    color: Color(0xFF0299B3),
                                    borderColor: Color(0xFF0299B3),
                                    spacing: 0.0),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    '264',
                                    style: TextStyle(
                                        color: Color(0xFF0299B3),
                                        fontSize: 18,
                                        fontFamily: 'Proxima',
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            'He has served in many international expert committee such as the American International Committee for the Diagnosis of Diabetes (2008), the IDF guidelines revision committee and several WHO expert committees including the expert committee for diagnosis and classification of diabetes, and the committee on the diagnosis of diabetes in pregnancy',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'Proxima',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            'Experience: 10 Years in Neurology',
                            style: TextStyle(
                                fontSize: 17.0,
                                fontFamily: 'Proxima',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          'Languages: Arabic, English',
                          style: TextStyle(
                              fontSize: 17.0,
                              fontFamily: 'Proxima',
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 15.0, bottom: 5.0),
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
                          selectionColor: Color(0xFF00A7C3),
                          selectedTextColor: Colors.white,
                          daysCount: 15,
                          // inactiveDates: [
                          //   DateTime.now().add(Duration(days: 3)),
                          //   DateTime.now().add(Duration(days: 4)),
                          //   DateTime.now().add(Duration(days: 7))
                          // ],
                          onDateChange: (date) {
                            setState(() {
                              selectedDay = date;
                            });
                          },
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 10.0, bottom: 5.0),
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
                          availableHours: [
                            '10:00 AM',
                            '11:00 AM',
                            '12:00 PM',
                            '1:00 PM',
                            '2:00 PM',
                            '3:00 PM'
                          ],
                          callback: (val) {
                            setState(() {
                              bookingHourSelected = val;
                              print(val);
                            });
                          },
                        ),
                        Container(
                          width: double.infinity,
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: ElevatedButton(
                              child: Text(
                                "Book Now",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: 'Proxima',
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () => print("it's pressed"),
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFF00A7C3),
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
