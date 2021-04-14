import 'package:flutter/material.dart';
import 'package:med_app/Widgets/doctor_card.dart';
import 'package:med_app/providedrs/database_provider.dart';
import 'package:provider/provider.dart';

class DoctorScreen extends StatefulWidget {
  DoctorScreen({this.id});
  final id;
  @override
  _DoctorScreenState createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.id),
        ),
        body: ChangeNotifierProvider<DatabaseProvider>(
          create: (context) => DatabaseProvider(id: widget.id),
          child: Consumer<DatabaseProvider>(
            builder: (context, databaseProvider, _) {
              return (databaseProvider.doctor != null)
                  ?Text("${databaseProvider.doctor.username}")
                  : Center(
                      child: Text(
                      "Sorry There are no Doctor Right Now",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ));
            },
          ),
        ));
  }
}
