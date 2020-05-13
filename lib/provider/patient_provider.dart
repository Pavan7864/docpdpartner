import 'dart:convert';

import 'package:docpdpartner/model/appointment_model.dart';
import 'package:docpdpartner/model/book_model.dart';
import 'package:docpdpartner/model/vital_model.dart';
import 'package:docpdpartner/utils/ApiClient.dart';
import 'package:docpdpartner/utils/AppUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PatientProvider extends ChangeNotifier{

  List<BookingModel> arrBooking=[];
  List<VitalModel> vitalData=[];

  bool isLoaded=true;
  AppointmentModel appointmentModel;
  BuildContext mContext;
  GlobalKey<ScaffoldState> gState;

  PatientProvider(AppointmentModel id,BuildContext context,GlobalKey<ScaffoldState> state){
    appointmentModel=id;
    mContext=context;
    gState=state;
    getPatientDetails();
  }



   getPatientDetails() async {
     var map={
       'UserCustomID':appointmentModel.customId
     };
     try{
       String response=await ApiClient.post(ApiClient.CSCPatientDetails, mContext,body: map,state: gState);
       if(!AppUtils.isEmpty(response)){
         var js=json.decode(response);
         arrBooking=(js['AppointmentList'] as List).map((i)=>BookingModel.fromJSON(i)).toList();
         vitalData=(js['VitalDetails'] as List).map((i)=>VitalModel.fromJSON(i)).toList();

       }

     }catch(_){
      print(_);
     }

     isLoaded=false;
     notifyListeners();

   }

}