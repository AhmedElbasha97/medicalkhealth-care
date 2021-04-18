import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:med_app/UI/drug_reminder/database/reminder_repository.dart';

class MedicineDetails extends StatefulWidget {
  final medicine;
  final setData;
  final flutterPlugin;
  final deleteData;

  MedicineDetails(
      {this.medicine, this.setData, this.flutterPlugin, this.deleteData});

  @override
  _MedicineDetailsState createState() => _MedicineDetailsState();
}

class _MedicineDetailsState extends State<MedicineDetails> {
  // _editMedicine(BuildContext context, medicineId) async {
  //   var itemBeforeEdit =
  //       await ReminderRepository().getMedicine("Pills", medicineId);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black,
        title: Text(
          'Medicine Details',
          style: TextStyle(color: Colors.white),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF00A1A7),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        child: Image.asset(
                          'assets/images/medicineName.png',
                        ),
                      ),
                    ],
                  ),
                  title: Text('Medicine Name'),
                  subtitle: Text(widget.medicine.name),
                ),
                ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        child: Image.asset(
                          widget.medicine.image,
                        ),
                      ),
                    ],
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text('Medicine Form'),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(widget.medicine.medicineForm),
                  ),
                ),
                ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 3.0),
                        child: Container(
                          height: 35,
                          child: Image.asset(
                            'assets/images/medicineDosage.png',
                          ),
                        ),
                      ),
                    ],
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text('Medicine Dosage'),
                  ),
                  subtitle: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Row(
                        children: [
                          Text(widget.medicine.amount),
                          Text(" ${widget.medicine.type}"),
                        ],
                      )),
                ),
                ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 42,
                        child: Image.asset(
                          'assets/images/medicineDuration.jpg',
                        ),
                      ),
                    ],
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(left: 3.0),
                    child: Text('Duration'),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(left: 3.0),
                    child: Row(
                      children: [
                        Text(widget.medicine.howManyWeeks.toString()),
                        Text(' weeks')
                      ],
                    ),
                  ),
                ),
                ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 42,
                        child: Image.asset(
                          'assets/images/medicineHour.png',
                        ),
                      ),
                    ],
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(left: 3.0),
                    child: Text('Hour'),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(left: 3.0),
                    child: Text(
                      DateFormat("HH:mm").format(
                        DateTime.fromMillisecondsSinceEpoch(
                            widget.medicine.time),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Container(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  child: Text(
                    "Delete Medicine From All Days",
                    style: TextStyle(fontSize: 16.0),
                  ),
                  onPressed: () {
                    widget.deleteData(widget.medicine);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 3.0,
                    primary: Colors.red[400],
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      side: BorderSide(color: Colors.red[400], width: 1.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
