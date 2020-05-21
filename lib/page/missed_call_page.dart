import 'package:docpdpartner/adapter/call_history.dart';
import 'package:docpdpartner/model/appointment_model.dart';
import 'package:docpdpartner/page/dialog/inner_web_page.dart';
import 'package:docpdpartner/provider/history_provider.dart';
import 'package:docpdpartner/utils/AppUtils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MissedCallScreen extends StatefulWidget{

    @override
    _MissedCallScreen createState()=>_MissedCallScreen();
}
class _MissedCallScreen extends State<MissedCallScreen>{


  ScrollController controller;
  HistoryProvider _app;
  @override
  void initState() {
    super.initState();
    controller = new ScrollController()..addListener(_scrollListener);
  }
  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  _scrollListener() {
    if (controller.position.maxScrollExtent == controller.offset&& _app!=null) {
       _app.getMissedAppointment();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context,HistoryProvider model,child){

        return ListView.builder(
          controller: controller,
          itemCount: model.arrMissed.length,
          itemBuilder: (context,index){
          return InkWell(
              onTap: () async {
                if(!AppUtils.isEmpty(model.arrMissed[index].pdfurl))
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>InnerWebPage(model.arrMissed[index].pdfurl)));
                else if(!AppUtils.isEmpty(model.arrMissed[index].patientId)){
                  var ma=model.arrMissed[index];
                  AppointmentModel appointmentModel=AppointmentModel(
                    userName:ma.userName,
                    userPic:ma.userPic,
                    id:ma.id,
                    customId:ma.CustomId,
                    requestType:ma.serviceType,
                    appoinmentReason:ma.reason,
                    appoinmentDate:ma.bookingDate,
                    bookingTime:ma.bookingTime,
                    pending:'0',
                    prescriptionID:ma.id,
                    meetingID:ma.MeetingID,
                    kilo:'',
                    gram:'',
                    patientId:ma.patientId,
                  );
                  var map=appointmentModel.toMap();
                  var isRemove=await Navigator.pushNamed(context, '/PatientOtherDetails', arguments: map);
                  if(isRemove!=null){
                    model.removeAt(index);
                  }
                }


              },
              child: CallHistoryAdapter( model.arrMissed[index],1)
          );
        },
      );
    }
    );
  }
}