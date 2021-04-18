import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';
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
  List<Speciality> Filterd_list = [];
  List<String> specialties = [];
  bool _isSearching;
  final TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _isSearching = false;
    values();
  }

  void values() {
    for (var item in items) {
      Specialties_list.add(Speciality.fromJson(item));
      specialties.add(item["speciality"].toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          title: Text(
            'Speciality',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: ColorsCollection.mainColor,
          elevation: 0.0,
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(children: [
              (Specialties_list.length > 0 && _controller.text.isEmpty)
                  ? Container(
                      padding: EdgeInsets.only(top: 75.0),
                      child: SingleChildScrollView(
                          child: GridView.builder(
                        itemCount: Specialties_list.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 3 / 2.15,
                            crossAxisCount: 2,
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 4.0),
                        itemBuilder: (BuildContext context, int index) {
                          var speciality = Specialties_list[index];
                          return SpecialityCard(speciality);
                        },
                      )))
                  : Container(
                      padding: EdgeInsets.only(top: 75.0),
                      child: SingleChildScrollView(
                          child: GridView.builder(
                        itemCount: Filterd_list.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 3 / 2.15,
                            crossAxisCount: 2,
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 4.0),
                        itemBuilder: (BuildContext context, int index) {
                          var speciality = Filterd_list[index];
                          return SpecialityCard(speciality);
                        },
                      ))),
              Positioned(
                top: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8),
                    child: TextFormField(
                       controller: _controller,
                        onChanged: searchOperation,
                        decoration:
                            InputDecoration(labelText: "Search By Speciality")),
                  ),
                ),
              ),
            ])));
  }
  void searchOperation(String searchText) {
    Filterd_list.clear();
    if (searchText != null) {
      for (int i = 0; i < specialties.length; i++) {
        String data = specialties[i];
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
           List<Speciality> Filter=[];
           Specialties_list.forEach((element) {
             if(element.speciality==data)
             Filter.add(element);
            });
          setState(() {
            Filterd_list.addAll(Filter);
          });
          
        }
      }
    }
}}
