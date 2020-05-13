import 'dart:convert';

import 'package:docpdpartner/model/appointment_model.dart';
import 'package:docpdpartner/model/doctor_model.dart';
import 'package:docpdpartner/utils/ApiClient.dart';
import 'package:docpdpartner/utils/AppUtils.dart';
import 'package:docpdpartner/utils/MyAppPrefrences.dart';
import 'package:flutter/cupertino.dart';

class AppointmentProvider extends ChangeNotifier{

  List<AppointmentModel> arrAppointment=[];
  BuildContext mContext;
  bool isLoaded=true;

  AppointmentProvider(BuildContext context){
   this.mContext=context;
    getAppointMent();
  }

  getAppointMent() async {

   try{
     String response=await ApiClient.post(ApiClient.CSCAppointmentList, mContext);

     if(!AppUtils.isEmpty(response)){
       var js=json.decode(response);
       arrAppointment=(js['CSCAppointmentList'] as List).map((i)=>AppointmentModel.fromJSON(i)).toList();
     }
   }catch(_){
     print(_);
   }
    isLoaded=false;
    notifyListeners();

  }

  void removeAt(int index) {
    arrAppointment.removeAt(index);
    notifyListeners();
    refershDoctor();
  }

  refershDoctor() async {
    DoctorModel doctor=await MyAppPrefrences.getLogin();
    if( doctor.T2DcallAssignmentToday!=null &&  doctor.T2DcallAssignmentToday!='0'){
      doctor.T2DcallAssignmentToday=(int.parse( doctor.T2DcallAssignmentToday)-1).toString();
    }
    MyAppPrefrences.saveLogin(doctor);
  }

}