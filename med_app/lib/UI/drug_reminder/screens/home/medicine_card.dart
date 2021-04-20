import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:med_app/UI/drug_reminder/database/reminder_repository.dart';

import '../../../../Styles/colors.dart';

import '../../models/pill.dart';
import '../../notifications/notifications.dart';
import '../medicine_details/medicine_details.dart';

class MedicineCard extends StatelessWidget {
  final Pill medicine;
  final Function setData;
  final Function deleteData;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  MedicineCard(this.medicine, this.setData,
      this.flutterLocalNotificationsPlugin, this.deleteData);

  @override
  Widget build(BuildContext context) {
    //check if the medicine time is lower than actual
    final bool isEnd = DateTime.now().millisecondsSinceEpoch > medicine.time;

    return Card(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      color: Colors.white,
      child: Stack(
        children: [
          ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MedicineDetails(
                      medicine: medicine,
                      flutterPlugin: flutterLocalNotificationsPlugin,
                      setData: setData,
                      deleteData: deleteData),
                ),
              );
            },
            contentPadding:
                EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
            title: Text(
              medicine.name,
              style: Theme.of(context).textTheme.headline1.copyWith(
                  color: Colors.black,
                  fontSize: 20.0,
                  decoration: isEnd ? TextDecoration.lineThrough : null),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              "${medicine.amount} ${medicine.type}",
              style: Theme.of(context).textTheme.headline5.copyWith(
                  color: Colors.grey[600],
                  fontSize: 15.0,
                  decoration: isEnd ? TextDecoration.lineThrough : null),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  DateFormat("HH:mm").format(
                      DateTime.fromMillisecondsSinceEpoch(medicine.time)),
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      decoration: isEnd ? TextDecoration.lineThrough : null),
                )
              ],
            ),
            leading: Container(
              width: 60.0,
              height: 60.0,
              child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      isEnd ? Colors.white : Colors.transparent,
                      BlendMode.saturation),
                  child: Image.asset(medicine.image)),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: InkWell(
              onTap: () {
                _showDeleteDialog(
                    context, medicine.name, medicine.id, medicine.notifyId);
              },
              child: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          )
        ],
      ),
    );
  }

  //--------------------------| SHOW THE DELETE DIALOG ON THE SCREEN |-----------------------

  void _showDeleteDialog(
      BuildContext context, String medicineName, int medicineId, int notifyId) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Delete ?"),
              content: Text("Are you sure to delete $medicineName medicine?"),
              contentTextStyle:
                  TextStyle(fontSize: 17.0, color: Colors.grey[800]),
              actions: [
                // ignore: deprecated_member_use
                FlatButton(
                  splashColor: ColorsCollection.mainColor.withOpacity(0.3),
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: ColorsCollection.mainColor),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                // ignore: deprecated_member_use
                FlatButton(
                  splashColor: ColorsCollection.mainColor.withOpacity(0.3),
                  child: Text("Delete",
                      style: TextStyle(color: ColorsCollection.mainColor)),
                  onPressed: () async {
                    await ReminderRepository().deleteData('Pills', medicineId);
                    await Notifications().removeNotify(
                        notifyId, flutterLocalNotificationsPlugin);
                    setData();
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }
  //============================================================================================

}
