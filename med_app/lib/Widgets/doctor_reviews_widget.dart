import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/models/doctor.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:show_dialog/show_dialog.dart' as dialog;

class ReviewsSlider extends StatelessWidget {
  final List<Review> reviews;
  final bool isProfileView;
  ReviewsSlider({this.reviews, this.isProfileView});
  @override
  Widget build(BuildContext context) {
    print(reviews);
    return Container(
      height: (isProfileView) ? double.infinity : 100,
      child: ListView.builder(
        itemCount: reviews.length,
        scrollDirection: (isProfileView) ? Axis.vertical : Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              dialog.aboutDialog(context, reviews[index].date.toString(),
                  reviews[index].review);
            },
            child: Container(
              width: 200,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  elevation: 3.0,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, top: 8.0, bottom: 6.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SmoothStarRating(
                            allowHalfRating: false,
                            onRated: (v) {},
                            starCount: 5,
                            rating: double.parse(reviews[index].rating),
                            size: 15.0,
                            isReadOnly: true,
                            color: ColorsCollection.mainColor,
                            borderColor: ColorsCollection.mainColor,
                            spacing: 0.0),
                        Text(
                          reviews[index].review,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          reviews[index].date.toString(),
                          style: TextStyle(fontSize: 10),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
