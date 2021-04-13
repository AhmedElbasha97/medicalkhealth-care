import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/UI/doctors/doctor_booking_next_screen/doctor_booking_next_screen.dart';
import 'package:med_app/UI/doctors/doctor_booking_screen/hour_picker_widget.dart';
import 'package:med_app/Widgets/doctor_reviews_widget.dart';
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
                border:
                    Border.all(width: 5.0, color: ColorsCollection.mainColor),
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
                                    color: ColorsCollection.mainColor,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Icon(
                                      FontAwesomeIcons.video,
                                      color: ColorsCollection.mainColor,
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
                                    color: ColorsCollection.mainColor,
                                    fontSize: 20,
                                    fontFamily: 'Proxima',
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: [
                                    SmoothStarRating(
                                        allowHalfRating: false,
                                        onRated: (v) {},
                                        starCount: 5,
                                        rating: 4.0,
                                        size: 20.0,
                                        isReadOnly: true,
                                        color: ColorsCollection.mainColor,
                                        borderColor: ColorsCollection.mainColor,
                                        spacing: 0.0),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        '264',
                                        style: TextStyle(
                                            color: ColorsCollection.mainColor,
                                            fontSize: 18,
                                            fontFamily: 'Proxima',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, bottom: 5.0),
                            child: Text(
                              'He has served in many international expert committee such as the American International Committee for the Diagnosis of Diabetes (2008), the IDF guidelines revision committee and several WHO expert committees including the expert committee for diagnosis and classification of diabetes, and the committee on the diagnosis of diabetes in pregnancy',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Proxima',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              children: [
                                Text('Experience: ',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: 'Proxima',
                                        fontWeight: FontWeight.bold)),
                                Text('10 Years in Neurology',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: 'Proxima',
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text('Languages: ',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: 'Proxima',
                                      fontWeight: FontWeight.bold)),
                              Container(
                                decoration: BoxDecoration(
                                  color: ColorsCollection.mainColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 5.0),
                                  child: Text(
                                    'Arabic, English',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17.0,
                                        fontFamily: 'Proxima',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              'Reviews:',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'Proxima',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          ReviewsSlider(reviews: [
                            {
                              "review":
                                  "very good asasdf asdf asdf asdf asdf asdf asdf asd fasd fasdf asd fasd fasd f",
                              "date": "20 April 2021",
                              "rating": 3
                            },
                            {
                              "review": "very bad",
                              "date": "21 March 2021",
                              "rating": 4
                            },
                            {
                              "review": "very sad",
                              "date": "22 June 2020",
                              "rating": 5
                            }
                          ]),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 5.0, bottom: 5.0),
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
                            selectionColor: ColorsCollection.mainColor,
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
                          Padding(
                            padding: const EdgeInsets.only(bottom: 40.0),
                            child: Container(
                              width: double.infinity,
                              height: 55,
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
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DoctorBookingNextScreen()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: ColorsCollection.mainColor,
                                    onPrimary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32.0),
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
      ),
    );
  }
}
