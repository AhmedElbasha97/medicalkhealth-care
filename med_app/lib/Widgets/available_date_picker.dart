import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:med_app/Styles/colors.dart';

class AvailableDatePicker extends StatefulWidget {
  final callback;

  AvailableDatePicker({this.callback});
  @override
  _AvailableDatePickerState createState() => _AvailableDatePickerState();
}

class _AvailableDatePickerState extends State<AvailableDatePicker> {
  var _firstDate = DateTime.now();
  var _lastDate = (DateTime.now()).add(Duration(days: 7));

  List<DateTime> calculateDaysInterval(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          final List<DateTime> picked = await DateRangePicker.showDatePicker(
              context: context,
              initialFirstDate: _firstDate,
              initialLastDate: _lastDate,
              firstDate: new DateTime.now().subtract(Duration(days: 1)),
              lastDate: new DateTime(DateTime.now().year + 2));
          if (picked != null && picked.length == 2) {
            var _selectedDates = calculateDaysInterval(picked[0], picked[1]);
            widget.callback(_selectedDates);
            setState(() {
              _firstDate = picked[0];
              _lastDate = picked[1];
            });
          }
        },
        child: Text('Add Available Days',
            style:
                TextStyle(color: ColorsCollection.mainColor, fontSize: 15.0)),
        style: ElevatedButton.styleFrom(
          elevation: 3.0,
          primary: Colors.grey[100],
          onPrimary: ColorsCollection.mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ));
  }
}
