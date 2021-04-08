import 'package:flutter/material.dart';

class TextFieldComp extends StatelessWidget {
  final String label;
  final String hint;
  TextFieldComp({this.label, this.hint});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Container(
          width: constraints.maxWidth - 50,
          child: TextFormField(
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Color(0xFF09BBCB)),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(40.0),
                    )),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(40.0),
                  ),
                  borderSide: BorderSide(width: 2, color: Colors.grey),
                ),
                labelText: label,
                labelStyle: TextStyle(color: Color(0xFF09BBCB), fontSize: 20),
                hintText: hint,
                floatingLabelBehavior: FloatingLabelBehavior.always),
          ),
        );
      },
    );
  }
}
