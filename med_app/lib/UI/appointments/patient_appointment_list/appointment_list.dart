import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/UI/appointments/patient_appointment_list/appointment_card_widget.dart';
import 'package:med_app/provider/app_provider.dart';
import 'package:provider/provider.dart';

class AppointmentList extends StatefulWidget {
  final navigateFromOtherScreen;

  const AppointmentList({Key key, this.navigateFromOtherScreen = false})
      : super(key: key);
  @override
  _AppointmentListState createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {
  String id;

  @override
  void initState() {
    AppProvider provider = Provider.of<AppProvider>(context, listen: false);
    setState(() {
      id = provider.userId;
    });
    print('seko seko $id');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => widget.navigateFromOtherScreen,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: widget.navigateFromOtherScreen,
          shadowColor: Colors.black,
          title: Text('Appointments'),
          backgroundColor: ColorsCollection.mainColor,
          elevation: 0.0,
        ),
        body: Consumer<AppProvider>(
          builder: (context, appProvider, _) {
            return ((appProvider.type == "patient" &&
                        appProvider.patient != null) ||
                    (appProvider.type == "doctor" &&
                        appProvider.doctor != null))
                ? Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: ListView.builder(
                      itemCount: appProvider.type == 'patient'
                          ? appProvider.patient.appointment.length
                          : appProvider.doctor.appointment.length,
                      itemBuilder: (ctx, index) {
                        return AppointmentCard(
                            userId: id,
                            appointment: appProvider.type == 'patient'
                                ? appProvider.patient.appointment[index]
                                : appProvider.doctor.appointment[index],
                            appointments: appProvider.type == 'patient'
                                ? appProvider.patient.appointment
                                : appProvider.doctor.appointment,
                            index: index,
                            userType: appProvider.type);
                      },
                    ),
                  )
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
