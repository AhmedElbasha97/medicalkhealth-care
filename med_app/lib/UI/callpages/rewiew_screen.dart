import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/UI/Blogs/Blogs_Main_Screen.dart';
import 'package:med_app/UI/callpages/index.dart';
import 'package:med_app/Widgets/NavBar.dart';
import 'package:med_app/models/doctor.dart';
import 'package:med_app/models/patient.dart';
import 'package:med_app/provider/app_provider.dart';
import 'package:med_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ReviewScreen extends StatefulWidget {
  Doctor doctor;
  ReviewScreen({Key key, this.doctor}) : super(key: key);

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  static FirebaseDatabase database = new FirebaseDatabase();

  final counterRef = database.reference().child('counter');
  DatabaseReference userRef = database.reference();
  String review = '';
  var rating = 0.0;

  void updateUserMedicalRecord() async {
    var user = userRef.child(
        'users/${widget.doctor.userId}/reviews/${(widget.doctor.reviews.length) == 0 ? 0 : widget.doctor.reviews.length}');
    if (review != null && review.length > 0) {
      await user.set({
        'review': review,
        'rating': rating.toString(),
        'date': DateFormat('yyyy-MM-dd').format(DateTime.now()).toString()
      }).then((_) async {
        print('Transaction  committed.');
        var userId = await context.read<AuthService>().getCurrentUser();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Nav(userid: userId.uid)));
      });
    } else {
      var userId = await context.read<AuthService>().getCurrentUser();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Nav(userid: userId.uid)));
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.doctor);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              'Your Review',
              style: TextStyle(
                  color: ColorsCollection.splashTitleColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 22),
            ),
          ),
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 15, left: 20, right: 20, top: 25),
              child: TextFormField(
                maxLength: 120,
                maxLines: 2,
                decoration: InputDecoration(
                    fillColor: ColorsCollection.mainColor,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: ColorsCollection.mainColor, width: 5.0),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                    ),
                    labelStyle: TextStyle(
                        fontSize: 23,
                        fontFamily: 'Proxima',
                        fontWeight: FontWeight.bold),
                    labelText: 'Your Review'),
                onChanged: (text) async {
                  setState(() {
                    review = text;
                  });
                },
              ),
            ),
            SmoothStarRating(
              rating: rating,
              size: 25,
              borderColor: Colors.yellow,
              starCount: 5,
              color: Colors.yellow,
              spacing: 2.0,
              onRated: (value) {
                setState(() {
                  rating = value;
                });
              },
            ),
            Text('${rating} Stars'),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              // ignore: deprecated_member_use
              child: FlatButton(
                color: ColorsCollection.mainColor,
                minWidth: MediaQuery.of(context).size.width * .45,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: ColorsCollection.mainColor,
                        width: 1,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: Text(
                    "Review",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                onPressed: () {
                  updateUserMedicalRecord();
                },
              ),
            )
          ],
        ));
  }
}
