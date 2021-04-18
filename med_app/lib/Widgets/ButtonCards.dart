
import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/UI/specialitylist/specialty_list.dart';
class ButtonCard extends StatefulWidget {
  final title;
  final subtitle;
  final goDoctor;

  ButtonCard({this.title,this.subtitle, this.goDoctor});

  @override
  _ButtonCardState createState() => _ButtonCardState();
}

class _ButtonCardState extends State<ButtonCard> {


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return GestureDetector(
          onTap: () {
          if(widget.goDoctor){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  SpecialtyList(),));
          }else{
            print("AAppointment");
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
                    right: BorderSide(width: 3.0,style: BorderStyle.solid, color:Color(0xfff2f2f2).withOpacity(0.5)),


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
                        subtitle:Text(
                          widget.subtitle,
                          style: TextStyle(

                              color: Color(0xfff2f2f2),
                              fontFamily: 'Proxima',
                              fontSize: 14),
                        ),
                      ),

                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0,0.0),
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