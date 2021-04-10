import 'package:flutter/material.dart';

class DropDownComp extends StatefulWidget {
  final val1;
  final val2;

  DropDownComp({this.val1, this.val2});
  @override
  _DropDownCompState createState() => _DropDownCompState();
}

class _DropDownCompState extends State<DropDownComp> {
  var _value = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(40)),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
          const Radius.circular(40.0),
        ))),
        items: [
          DropdownMenuItem(
            value: 1,
            child: Text(widget.val1),
          ),
          DropdownMenuItem(
            value: 2,
            child: Text(widget.val2),
          )
        ],
        onChanged: (value) {
          setState(() {
            _value = value;
          });
        },
        value: _value,
      ),
    );
  }
}
