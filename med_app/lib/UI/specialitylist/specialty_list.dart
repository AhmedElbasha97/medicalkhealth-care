import 'package:flutter/material.dart';
import 'package:med_app/Widgets/speciality_card.dart';
import 'package:med_app/models/speciality.dart';

class SpecialtyList extends StatefulWidget {
  @override
  _SpecialtyListState createState() => _SpecialtyListState();
}

class _SpecialtyListState extends State<SpecialtyList> {
  List items = [
    {"speciality": 'Dermatology', "image": "assets/Dermatology.png"},
    {"speciality": 'Dentistry', "image": "assets/Dermatology.png"},
    {"speciality": 'Psychiatry', "image": "assets/Dermatology.png"},
    {"speciality": 'Pediatrics', "image": "assets/Dermatology.png"},
    {"speciality": 'Neurology', "image": "assets/Dermatology.png"},
    {"speciality": 'Orthopedics', "image": "assets/Dermatology.png"},
    {
      "speciality": 'Gynaecology and Infertility',
      "image": "assets/Dermatology.png"
    },
    {"speciality": 'otolaryngologist', "image": "assets/Dermatology.png"},
    {
      "speciality": 'Cardiology and Vascular',
      "image": "assets/Dermatology.png"
    },
    {"speciality": 'Allergy and Immunology', "image": "assets/Dermatology.png"},
    {
      "speciality": 'Andrology and Male Infertility',
      "image": "assets/Dermatology.png"
    },
    {"speciality": 'Audiology', "image": "assets/Dermatology.png"},
    {
      "speciality": 'Cardiology and Thoracic',
      "image": "assets/Dermatology.png"
    },
    {"speciality": 'Chest and Respiratory', "image": "assets/Dermatology.png"},
    {
      "speciality": 'Diabetes and Endocrinology',
      "image": "assets/Dermatology.png"
    },
    {"speciality": 'Diagnostic Radiology', "image": "assets/Dermatology.png"},
    {
      "speciality": 'Dietitian and Nutrition',
      "image": "assets/Dermatology.png"
    },
    {"speciality": 'Family Medicine', "image": "assets/Dermatology.png"},
    {"speciality": 'Oncology', "image": "assets/Dermatology.png"},
    {
      "speciality": 'Gastroenterology and Endoscopy',
      "image": "assets/Dermatology.png"
    },
    {"speciality": 'General Practice', "image": "assets/Dermatology.png"},
  ];
  List<Speciality> Specialties_list = [];
  @override
  Widget build(BuildContext context) {
    for (var item in items) {
      Specialties_list.add(Speciality.fromJson(item));
    }
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_sharp),
            color: Colors.grey,
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Speciality',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(children: [
              (Specialties_list.length > 0)
                  ? Container(
                      padding: EdgeInsets.only(top: 75.0),
                      child: SingleChildScrollView(
                          child: GridView.builder(
                        itemCount: Specialties_list.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 3 / 2.2,
                            crossAxisCount: 2,
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 4.0),
                        itemBuilder: (BuildContext context, int index) {
                          var speciality = Specialties_list[index];
                          return SpecialityCard(speciality);
                        },
                      )))
                  : CircularProgressIndicator(),
              Positioned(
                top: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8),
                    child: TextFormField(
                        decoration:
                            InputDecoration(labelText: "Search By Speciality")),
                  ),
                ),
              ),
            ])));

    // Scaffold(
    //   body:(specialities.length>0)?ListView.builder(
    //                 shrinkWrap: true,
    //                 itemCount: specialities.length,
    //                 itemBuilder: (BuildContext context, int index) {
    //                   return Card(
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: <Widget>[
    //                         Text("speciality: " + specialities[index]["speciality"]),

    //                       ],
    //                     ),
    //                   );
    //                 }): CircularProgressIndicator());
  }
}
