import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import '../../../../Styles/colors.dart';
import '../../notifications/notifications.dart';
import '../../database/reminder_repository.dart';
import '../../models/pill.dart';
import '../../screens/home/medicines_list.dart';
import '../../screens/home/calendar.dart';
import '../../models/calendar_day_model.dart';
import '../add_new_medicine/add_new_medicine.dart';

class ReminderHome extends StatefulWidget {
  @override
  _ReminderHomeState createState() => _ReminderHomeState();
}

class _ReminderHomeState extends State<ReminderHome> {
  //-------------------| Flutter notifications |-------------------
  final Notifications _notifications = Notifications();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  //===============================================================

  //--------------------| List of Pills from database |----------------------
  List<Pill> allListOfPills = List<Pill>();
  final ReminderRepository _repository = ReminderRepository();
  List<Pill> dailyPills = List<Pill>();
  //=========================================================================

  //-----------------| Calendar days |------------------
  final CalendarDayModel _days = CalendarDayModel();
  List<CalendarDayModel> _daysList;
  //====================================================

  //handle last choose day index in calendar
  int _lastChooseDay = 0;
  int _howManyWeeks = 1;

  @override
  void initState() {
    super.initState();
    initNotifies();
    setData();
    _daysList = _days.getCurrentDays();
  }

  Future<void> deleteAllRecords(medicine) async {
    var filteredList = allListOfPills
        .where((element) => element.diffId == medicine.diffId)
        .toList();
    for (int i = 0; (i < filteredList.length); i++) {
      await ReminderRepository().deleteData('Pills', filteredList[i].id);
      await Notifications().removeNotify(
          filteredList[i].notifyId, flutterLocalNotificationsPlugin);
      setData();
    }
  }

  //init notifications
  Future initNotifies() async => flutterLocalNotificationsPlugin =
      await _notifications.initNotifies(context);

  //--------------------GET ALL DATA FROM DATABASE---------------------
  Future setData() async {
    allListOfPills.clear();
    (await _repository.getAllData("Pills")).forEach((pillMap) {
      allListOfPills.add(Pill().pillMapToObject(pillMap));
    });
    chooseDay(_daysList[_lastChooseDay]);
  }
  //===================================================================

  @override
  Widget build(BuildContext context) {
    final double deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    final Widget addButton = FloatingActionButton(
      elevation: 2.0,
      onPressed: () async {
        //refresh the pills from database
        await Navigator.push(context,
            MaterialPageRoute(builder: (context) => AddNewMedicine())).then(
          (howManyWeeks) {
            setState(() {
              _howManyWeeks = howManyWeeks;
            });
            setData();
          },
        );
      },
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 24.0,
      ),
      backgroundColor: ColorsCollection.mainColor,
    );

    return Scaffold(
      floatingActionButton: addButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                top: 0.0, left: 25.0, right: 25.0, bottom: 20.0),
            child: Column(
              children: [
                SizedBox(
                  height: deviceHeight * 0.04,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Container(
                    alignment: Alignment.topCenter,
                    height: deviceHeight * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Drug Reminder",
                          style: TextStyle(
                              fontSize: 26.0, fontWeight: FontWeight.bold),
                        ),
                        // ShakeAnimatedWidget(
                        //   enabled: true,
                        //   duration: Duration(milliseconds: 2000),
                        //   curve: Curves.linear,
                        //   shakeAngle: Rotation.deg(z: 30),
                        //   child: Icon(
                        //     Icons.notifications_none,
                        //     size: 42.0,
                        //   ),
                        // )
                        Icon(
                          Icons.calendar_today,
                          size: 30.0,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: deviceHeight * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Calendar(chooseDay, _daysList),
                ),
                SizedBox(height: deviceHeight * 0.03),
                dailyPills.isEmpty
                    ? SizedBox(
                        width: double.infinity,
                        height: 100,
                        child:
                            // WavyAnimatedTextKit(
                            //   textStyle: TextStyle(
                            //       fontSize: 32.0,
                            //       fontWeight: FontWeight.bold,
                            //       color: Colors.black),
                            //   text: ["Loading..."],
                            //   isRepeatingAnimation: true,
                            //   speed: Duration(milliseconds: 150),
                            // ),
                            Center(child: Text('No reminders found!')))
                    : MedicinesList(dailyPills, setData,
                        flutterLocalNotificationsPlugin, deleteAllRecords)
              ],
            ),
          ),
        ),
      ),
    );
  }

  //-------------------------| Click on the calendar day |-------------------------

  void chooseDay(CalendarDayModel clickedDay) {
    setState(() {
      _lastChooseDay = _daysList.indexOf(clickedDay);
      _daysList.forEach((day) => day.isChecked = false);
      CalendarDayModel chooseDay = _daysList[_daysList.indexOf(clickedDay)];
      var cd = chooseDay.dayNumber;
      var cm = chooseDay.month;
      var cy = chooseDay.year;
      var newChooseDay = DateFormat('dd-MM-yyyy').parse('$cd-$cm-$cy');
      chooseDay.isChecked = true;
      dailyPills.clear();
      allListOfPills.forEach((pill) {
        DateTime pillDate =
            DateTime.fromMicrosecondsSinceEpoch(pill.time * 1000);
        if (chooseDay.dayNumber == pillDate.day &&
            chooseDay.month == pillDate.month &&
            chooseDay.year == pillDate.year) {
          dailyPills.add(pill);
        }
      });
      dailyPills.sort((pill1, pill2) => pill1.time.compareTo(pill2.time));
    });
  }

  //===============================================================================

}
