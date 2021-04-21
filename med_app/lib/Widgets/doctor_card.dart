import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/UI/doctors/doctor_booking_screen/doctor_booking_screen.dart';
import 'package:med_app/models/doctor.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:med_app/models/patient.dart';

class DoctorCard extends StatelessWidget {
  getImgeUrl(imagepath) async {
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref(imagepath)
        .getDownloadURL();
    print(downloadURL);
    return downloadURL;
  }

  DoctorCard({this.doctor, this.patient});
  final Doctor doctor;
  final Patient patient;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Container(
        height: 153,
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: FutureBuilder(
                          future: getImgeUrl(doctor.userAvatar),
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
                            return Center(child: CircularProgressIndicator());
                          }),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Dr.${doctor.name}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18)),
                                SizedBox(
                                  width: 10,
                                ),
                                Row(
                                  children: [
                                    if (doctor.callMethods.voice)
                                      Icon(
                                        Icons.phone_in_talk,
                                        color: ColorsCollection.mainColor,
                                        size: 23.0,
                                      ),
                                    if (doctor.callMethods.video)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Icon(FontAwesomeIcons.video,
                                            color: ColorsCollection.mainColor,
                                            size: 20),
                                      ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                              "${doctor.speciality} | ${doctor.experience} Years",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 18)),
                          SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.solidStar,
                                color: Colors.orange[200],
                                size: 15,
                              ),
                              SizedBox(
                                width: 7,
                                height: 15,
                              ),
                              Text(
                                "${doctor.rating}",
                                style: TextStyle(fontSize: 17),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Icon(
                                Icons.comment,
                                color: ColorsCollection.mainColor,
                                size: 17,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                "${doctor.reviews.length} Reviews",
                                style: TextStyle(fontSize: 17),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        // ignore: deprecated_member_use
                        child: FlatButton(
                            color: Colors.transparent,
                            splashColor: Colors.black26,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => DoctorBookingScreen(
                                      userId: doctor.userId,
                                      patient: patient)));
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(
                                    color: ColorsCollection.mainColor)),
                            minWidth: MediaQuery.of(context).size.width / 2.25,
                            child: Text(
                              'Book Appointments',
                              style: TextStyle(
                                  color: ColorsCollection.mainColor,
                                  fontSize: 15),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
