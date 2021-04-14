import 'package:flutter/material.dart';
import 'package:med_app/UI/doctors/doctor_booking_screen/doctor_booking_screen.dart';
import 'package:med_app/models/doctor.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class DoctorCard extends StatelessWidget {
  getImgeUrl(imagepath) async {
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref(imagepath)
        .getDownloadURL();
    print(downloadURL);
    return downloadURL;
  }

  DoctorCard({this.doctor});
  final Doctor doctor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
      child: Card(
        elevation: 3.0,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 10, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder(
                      future: getImgeUrl(doctor.userAvatar),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            width: MediaQuery.of(context).size.width / 5,
                            height: MediaQuery.of(context).size.width / 5,
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
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Dr.${doctor.name}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18)),
                        Text("${doctor.speciality}",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 18)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FlatButton(
                      color: Colors.transparent,
                      splashColor: Colors.black26,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                DoctorBookingScreen(userId: doctor.userId)));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.lightBlue)),
                      minWidth: MediaQuery.of(context).size.width / 2.25,
                      child: Text(
                        'Book Appointment',
                        style: TextStyle(color: Colors.lightBlue, fontSize: 15),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
