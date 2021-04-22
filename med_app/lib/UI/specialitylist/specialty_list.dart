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
    {"speciality": 'Dermatology', "image": "assets/specialty/Dermatology.png"},
    {"speciality": 'Dentistry', "image": "assets/specialty/dentistry.png"},
    {"speciality": 'Psychiatry', "image": "assets/specialty/psychiatry.png"},
    {"speciality": 'Pediatrics', "image": "assets/specialty/Pediatrics-kids.png"},
    {"speciality": 'Neurology', "image": "assets/specialty/neuorosergury.png"},
    {"speciality": 'Orthopedics', "image": "assets/specialty/orthopedics.png"},
    {
      "speciality": 'Gynaecology and Infertility',
      "image": "assets/specialty/gynaecology--and-infertility.png"
    },
    {"speciality": 'otolaryngologist', "image": "assets/specialty/Otolaryngology.png"},
    {"speciality": 'Cardiology and Vascular', "image": "assets/specialty/cardiology.png"},
    {
      "speciality": 'Andrology and Male Infertility',
      "image": "assets/specialty/male-infertility.png"
    },
    {"speciality": 'Cardiology and Thoracic', "image": "assets/specialty/cardiology.png"},
    {"speciality": 'Chest and Respiratory', "image": "assets/specialty/respiratory.png"},
    {
      "speciality": 'Diabetes and Endocrinology',
      "image": "assets/specialty/diabetes.png"
    },
    {"speciality": 'Diagnostic Radiology', "image": "assets/specialty/radiology.png"},
    {"speciality": 'Dietitian and Nutrition', "image": "assets/specialty/nutrition.png"},
    {"speciality": 'Getiatrics', "image": "assets/specialty/getiatrics.png"},
    {
      "speciality": 'Gastroenterology and Endoscopy',
      "image": "assets/specialty/gastro.png"
    },
    {"speciality": 'General Practice', "image": "assets/specialty/general-practice.png"},
  ];
  List<Speciality> specialtiesList = [];
  List<Speciality> filterdList = [];
  List<String> specialties = [];
  // ignore: unused_field
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
      specialtiesList.add(Speciality.fromJson(item));
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
              (specialtiesList.length > 0 && _controller.text.isEmpty)
                  ? Container(
                      padding: EdgeInsets.only(top: 75.0),
                      child: SingleChildScrollView(
                          child: GridView.builder(
                        itemCount: specialtiesList.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 3 / 2.15,
                            crossAxisCount: 2,
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 4.0),
                        itemBuilder: (BuildContext context, int index) {
                          var speciality = specialtiesList[index];
                          return SpecialityCard(speciality);
                        },
                      )))
                  : Container(
                      padding: EdgeInsets.only(top: 75.0),
                      child: SingleChildScrollView(
                          child: GridView.builder(
                        itemCount: filterdList.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 3 / 2.15,
                            crossAxisCount: 2,
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 4.0),
                        itemBuilder: (BuildContext context, int index) {
                          var speciality = filterdList[index];
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
    filterdList.clear();
    if (searchText != null) {
      for (int i = 0; i < specialties.length; i++) {
        String data = specialties[i];
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          List<Speciality> Filter = [];
          specialtiesList.forEach((element) {
            if (element.speciality == data) Filter.add(element);
          });
          setState(() {
            filterdList.addAll(Filter);
          });
        }
      }
    }
  }
}
