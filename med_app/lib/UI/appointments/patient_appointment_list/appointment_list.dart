import 'package:flutter/material.dart';
import 'package:med_app/Styles/colors.dart';
import 'package:med_app/UI/appointments/patient_appointment_list/appointment_card_widget.dart';
import 'package:med_app/provider/app_provider.dart';
import 'package:provider/provider.dart';

class AppointmentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black,
        title: Text('Appointments'),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
              icon: Icon(Icons.event_note),
              color: Colors.white,
              onPressed: () => null),
        ),
        backgroundColor: ColorsCollection.mainColor,
        elevation: 0.0,
      ),
      body: Consumer<AppProvider>(
        builder: (context, appProvider, _) {
          return (appProvider.patient != null || appProvider.doctor != null)
              ? Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: ListView.builder(
                    itemCount: appProvider.type == 'patient'
                        ? appProvider.patient.appointment.length
                        : appProvider.doctor.appointment.length,
                    itemBuilder: (ctx, index) {
                      return AppointmentCard(
                          appointment: appProvider.type == 'patient'
                              ? appProvider.patient.appointment[index]
                              : appProvider.doctor.appointment[index],
                          appointments: appProvider.type == 'patient'
                              ? appProvider.patient.appointment
                              : appProvider.doctor.appointment,
                          index: index,
                          userId: appProvider.type == 'patient'
                              ? appProvider.patient.userId
                              : appProvider.doctor.userId,
                          userType: appProvider.type);
                    },
                  ),
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
