import 'package:flutter/material.dart';
import 'package:med_app/UI/doctors/doctor_booking_screen/hour_picker_item_widget.dart';


class HourPicker extends StatefulWidget {
  final height;
  final width;
  final callback;
  final List availableHours;
  HourPicker({this.height, this.availableHours, this.width, this.callback});

  @override
  _HourPickerState createState() => _HourPickerState();
}

class _HourPickerState extends State<HourPicker> {
  ScrollController _controller = ScrollController();
  var tc = true;
  var selectedIndex;

  Map<String, dynamic> tcList;

  void changeColor(index) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: ListView.builder(
        itemCount: widget.availableHours.length,
        scrollDirection: Axis.horizontal,
        controller: _controller,
        itemBuilder: (context, index) {
          return (index != selectedIndex)
              ? HourItem(
                  width: widget.width,
                  height: widget.height,
                  availableHour: widget.availableHours[index],
                  tc: true,
                  callback: (val) {
                    widget.callback(val);
                    setState(() {
                      selectedIndex = widget.availableHours
                          .indexWhere((element) => element == val);
                    });
                  },
                )
              : HourItem(
                  width: widget.width,
                  height: widget.height,
                  availableHour: widget.availableHours[index],
                  tc: false,
                  callback: (val) {
                    widget.callback(val);
                    setState(
                      () {
                        selectedIndex = widget.availableHours
                            .indexWhere((element) => element == val);
                      },
                    );
                  },
                );
        },
      ),
    );
  }
}
