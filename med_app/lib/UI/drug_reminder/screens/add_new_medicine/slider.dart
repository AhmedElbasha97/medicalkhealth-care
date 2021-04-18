import 'package:flutter/material.dart';
import '../../../../Styles/colors.dart';
import '../../helpers/platform_slider.dart';

class UserSlider extends StatelessWidget {
  final Function handler;
  final int howManyWeeks;
  UserSlider(this.handler, this.howManyWeeks);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: PlatformSlider(
          divisions: 4,
          min: 1,
          max: 5,
          value: howManyWeeks,
          color: ColorsCollection.mainColor,
          handler: this.handler,
        )),
      ],
    );
  }
}
