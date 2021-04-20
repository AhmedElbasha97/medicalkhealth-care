import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/Widgets/doctor_reviews_widget.dart';
import 'package:med_app/provider/app_provider.dart';
import 'package:provider/provider.dart';

class DocotorReviewsScreen extends StatefulWidget {
  final String id;
  final String patientId;
  DocotorReviewsScreen({Key key, this.id, this.patientId}) : super(key: key);

  @override
  _DocotorReviewsScreenState createState() => _DocotorReviewsScreenState();
}

class _DocotorReviewsScreenState extends State<DocotorReviewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          color: ColorsCollection.splashTitleColor,
          onPressed: () => {
            Navigator.of(context).pop(),
          },
        ),
        title: Text(
          'Your Reviews',
          style: TextStyle(
              color: ColorsCollection.splashTitleColor,
              fontWeight: FontWeight.normal,
              fontSize: 22),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
      ),
      body: Consumer<AppProvider>(
        builder: (context, databaseProvider, _) {
          return (databaseProvider.doctor.reviews != null)
              ? ReviewsSlider(
                  reviews: databaseProvider.doctor.reviews, isProfileView: true)
              : Center(
                  child: Center(
                  child: Image(
                    image: AssetImage('assets/medicalnoteBG.png'),
                  ),
                ));
        },
      ),
    );
  }
}
