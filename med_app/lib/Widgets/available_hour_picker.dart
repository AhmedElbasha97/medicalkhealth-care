import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AvailableHourPicker extends StatefulWidget {
  final callback;
  final initialValue;
  AvailableHourPicker({this.callback, this.initialValue});
  @override
  _AvailableHourPickerState createState() => _AvailableHourPickerState();
}

class _AvailableHourPickerState extends State<AvailableHourPicker> {
  static List<AvailableHour> _AvailableHours = [
    AvailableHour(id: 1, hourUser: "6:00 AM"),
    AvailableHour(id: 2, hourUser: "6:30 AM"),
    AvailableHour(id: 3, hourUser: "7:00 AM"),
    AvailableHour(id: 4, hourUser: "7:30 AM"),
    AvailableHour(id: 5, hourUser: "8:00 AM"),
    AvailableHour(id: 6, hourUser: "8:30 AM"),
    AvailableHour(id: 7, hourUser: "9:00 AM"),
    AvailableHour(id: 8, hourUser: "9:30 AM"),
    AvailableHour(id: 9, hourUser: "10:00 AM"),
    AvailableHour(id: 10, hourUser: "10:30 AM"),
    AvailableHour(id: 11, hourUser: "11:00 AM"),
    AvailableHour(id: 12, hourUser: "11:30 AM"),
    AvailableHour(id: 7, hourUser: "12:00 PM"),
    AvailableHour(id: 8, hourUser: "12:30 PM"),
    AvailableHour(id: 9, hourUser: "1:00 PM"),
    AvailableHour(id: 10, hourUser: "1:30 PM"),
    AvailableHour(id: 11, hourUser: "2:00 PM"),
    AvailableHour(id: 12, hourUser: "2:30 PM"),
    AvailableHour(id: 1, hourUser: "3:00 PM"),
    AvailableHour(id: 2, hourUser: "3:30 PM"),
    AvailableHour(id: 3, hourUser: "4:00 PM"),
    AvailableHour(id: 4, hourUser: "4:30 PM"),
    AvailableHour(id: 5, hourUser: "5:00 PM"),
    AvailableHour(id: 6, hourUser: "5:30 PM"),
    AvailableHour(id: 7, hourUser: "6:00 PM"),
    AvailableHour(id: 8, hourUser: "6:30 PM"),
    AvailableHour(id: 9, hourUser: "7:00 PM"),
    AvailableHour(id: 10, hourUser: "7:30 PM"),
    AvailableHour(id: 11, hourUser: "8:00 PM"),
    AvailableHour(id: 12, hourUser: "8:30 PM"),
    AvailableHour(id: 7, hourUser: "9:00 PM"),
    AvailableHour(id: 8, hourUser: "9:30 PM"),
    AvailableHour(id: 9, hourUser: "10:00 PM"),
    AvailableHour(id: 10, hourUser: "10:30 PM"),
    AvailableHour(id: 11, hourUser: "11:00 PM"),
    AvailableHour(id: 12, hourUser: "11:30 PM"),
  ];
  final _items = _AvailableHours.map((availableHour) =>
          MultiSelectItem<AvailableHour>(availableHour, availableHour.hourUser))
      .toList();
  @override
  Widget build(BuildContext context) {
    return MultiSelectChipField(
      items: _items,
      initialValue: widget.initialValue,
      title: Text("Add Available Hours"),
      headerColor: ColorsCollection.mainColor.withOpacity(0.5),
      decoration: BoxDecoration(
        border: Border.all(color: ColorsCollection.mainColor, width: 1.8),
      ),
      selectedChipColor: ColorsCollection.mainColor.withOpacity(0.5),
      selectedTextStyle: TextStyle(color: Colors.black),
      onTap: (values) {
        var _selectedHours = values.map((e) => e.hourUser).toList();
        widget.callback(_selectedHours);
      },
    );
  }
}

class AvailableHour {
  final id;
  final hourUser;
  AvailableHour({this.id, this.hourUser});
}
