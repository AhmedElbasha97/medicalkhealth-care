import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../models/pill.dart';
import '../../screens/home/medicine_card.dart';

class MedicinesList extends StatelessWidget {
  final List<Pill> listOfMedicines;
  final Function setData;
  final Function deleteData;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  MedicinesList(this.listOfMedicines, this.setData,
      this.flutterLocalNotificationsPlugin, this.deleteData);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => MedicineCard(listOfMedicines[index],
          setData, flutterLocalNotificationsPlugin, deleteData),
      itemCount: listOfMedicines.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}
