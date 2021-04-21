import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/UI/appointments/patient_appointment_list/appointment_list.dart';
import 'package:med_app/UI/specialitylist/specialty_list.dart';
import 'package:med_app/provider/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ButtonCard extends StatefulWidget {
  final title;
  final subtitle;
  final goDoctor;

  ButtonCard({this.title, this.subtitle, this.goDoctor});

  @override
  _ButtonCardState createState() => _ButtonCardState();
}

class _ButtonCardState extends State<ButtonCard> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return GestureDetector(
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String id = prefs.getString('userid');
            AppProvider provider =
                Provider.of<AppProvider>(context, listen: false);
            provider.getUserType(id);
            if (widget.goDoctor) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SpecialtyList(
                  navigateFromOtherScreen: true,
                ),
              ));
            } else {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AppointmentList(),
              ));
            }
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: new LinearGradient(
                colors: [
                  const Color(0xFF00A1A7),
                  const Color(0xff00c5cc),
                ],
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: ColorsCollection.mainColor.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            height: 100,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                          width: 3.0,
                          style: BorderStyle.solid,
                          color: Color(0xfff2f2f2).withOpacity(0.5)),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: ListTile(
                    title: Text(
                      widget.title,
                      style: TextStyle(
                          color: Color(0xfff2f2f2),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Proxima',
                          fontSize: 18),
                    ),
                    subtitle: Text(
                      widget.subtitle,
                      style: TextStyle(
                          color: Color(0xfff2f2f2),
                          fontFamily: 'Proxima',
                          fontSize: 14),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
                  child: Text(
                    "For \nMore \ndetails",
                    style: TextStyle(
                        color: Color(0xfff2f2f2),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Proxima',
                        fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
