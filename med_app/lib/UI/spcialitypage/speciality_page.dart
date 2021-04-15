import 'package:flutter/material.dart';
import 'package:med_app/Widgets/doctor_card.dart';
import 'package:med_app/provider/doctor_provider.dart';
import 'package:provider/provider.dart';
class SpecialityPage extends StatefulWidget {
  SpecialityPage({Key key, this.speciality}) : super(key: key);

  final String speciality;
  @override
  _SpecialityPageState createState() => _SpecialityPageState();
}

class _SpecialityPageState extends State<SpecialityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.speciality),
        ),
        body: ChangeNotifierProvider<DoctorProvider>(
          create: (context) => DoctorProvider(speciality: widget.speciality),
          child: Consumer<DoctorProvider>(
            builder: (context, databaseProvider, _) {
              return (databaseProvider.doctors != null)
                  ? ListView.builder(
                      itemCount: databaseProvider.doctors.length,
                      itemBuilder: (ctx, index) {
                        final doctor = databaseProvider.doctors[index];
                        return DoctorCard(doctor: doctor);
                      })
                  : Center(
                      child: Text(
                      "Sorry There are no Doctors Right Now",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ));
            },
          ),
        ));
  }
}
