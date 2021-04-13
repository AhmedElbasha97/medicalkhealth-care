import 'package:flutter/material.dart';
import 'package:med_app/Widgets/doctor_card.dart';
import 'package:med_app/providedrs/database_provider.dart';
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
      body: ChangeNotifierProvider<DatabaseProvider>(
        create: (context)=>DatabaseProvider(speciality: widget.speciality),
        child: Consumer<DatabaseProvider>(
        builder: (context,DatabaseProvider ,_) {

            return ( DatabaseProvider.Doctors!= null)? ListView.builder(
                itemCount: DatabaseProvider.Doctors.length,
                itemBuilder: (ctx, index) {
                  final Doctor = DatabaseProvider.Doctors[index];
                  return DoctorCard(doctor:Doctor);
                }): Center(child: Text("Sorry There are no Doctors Right Now",style: TextStyle(fontWeight: FontWeight.w600,fontSize:18 ),));

        },
      ),
    ));
  }
}