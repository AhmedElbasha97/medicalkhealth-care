import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/Widgets/doctor_card.dart';
import 'package:med_app/models/doctor.dart';
import 'package:med_app/models/patient.dart';
import 'package:med_app/provider/app_provider.dart';
import 'package:provider/provider.dart';

class SpecialityPage extends StatefulWidget {
  SpecialityPage({Key key, this.speciality}) : super(key: key);

  final String speciality;
  @override
  _SpecialityPageState createState() => _SpecialityPageState();
}

class _SpecialityPageState extends State<SpecialityPage> {
  List<Doctor> filterddoctors = [];
  List<Doctor> doctorslist = [];
  Patient patient;
  bool _isSearching;
  final TextEditingController _controller = new TextEditingController();
  void values(data) {
    doctorslist = data;
  }

  @override
  void initState() {
    _isSearching = false;
    AppProvider provider = Provider.of<AppProvider>(context, listen: false);

    provider.getPatientById(provider.userId);
    setState(() {
      patient = provider.patient;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsCollection.mainColor,
          title: Text(widget.speciality),
        ),
        body: ChangeNotifierProvider<AppProvider>(
          create: (context) => AppProvider(speciality: widget.speciality),
          child: Consumer<AppProvider>(
            builder: (context, databaseProvider, _) {
              if (doctorslist == null) {
                values(databaseProvider.doctors);
              }

              return Stack(children: [
                if (databaseProvider.doctors != null)
                  (_controller.text.isEmpty)
                      ? Padding(
                          padding: const EdgeInsets.only(top: 70.0),
                          child: ListView.builder(
                              itemCount: databaseProvider.doctors.length,
                              itemBuilder: (ctx, index) {
                                final doctor = databaseProvider.doctors[index];
                                return DoctorCard(
                                    doctor: doctor, patient: patient);
                              }),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 70.0),
                          child: ListView.builder(
                              itemCount: filterddoctors.length,
                              itemBuilder: (ctx, index) {
                                final doctor = filterddoctors[index];
                                return DoctorCard(doctor: doctor);
                              }),
                        )
                else if (databaseProvider.doctors == null)
                  Center(
                      child: Text(
                    "Sorry There are no Doctors Right Now",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  )),
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
                              InputDecoration(labelText: "Search By Name")),
                    ),
                  ),
                ),
              ]);
            },
          ),
        ));
  }

  void searchOperation(String searchText) {
    filterddoctors.clear();
    if (searchText != null) {
      for (int i = 0; i < doctorslist.length; i++) {
        String data = doctorslist[i].name;
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          List<Doctor> filter = [];
          doctorslist.forEach((element) {
            if (element.name == data) filter.add(element);
          });
          setState(() {
            filterddoctors.addAll(filter);
          });
        }
      }
      print(filterddoctors.length);
    }
  }
}
