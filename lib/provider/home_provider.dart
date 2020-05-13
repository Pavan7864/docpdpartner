import 'dart:convert';

import 'package:docpdpartner/model/doctor_model.dart';
import 'package:docpdpartner/utils/ApiClient.dart';
import 'package:docpdpartner/utils/AppUtils.dart';
import 'package:docpdpartner/utils/MyAppPrefrences.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class HomeProvider extends ChangeNotifier{
  DoctorModel doctor=DoctorModel();

  BuildContext mContext;
  DateTime dobDate = DateTime.now();
  DateTime completedMBBSDate ;
  DateTime practiceDate;


  HomeProvider(BuildContext context){
    mContext=context;
    getLatestData();
  }
  
  getLatestData() async {
    doctor=await MyAppPrefrences.getLogin();
    notifyListeners();
    getUserData();
  }

  Future<void> refresh() async {
    doctor=await MyAppPrefrences.getLogin();
    notifyListeners();
    getUserData();
  }

  getUserData()async{
    try{
      String response=await ApiClient.post(ApiClient.paDashboard, mContext);
      if(!AppUtils.isEmpty(response)){
        var js=json.decode(response);
        List<DoctorModel> data = (js['Dashboard'] as List).map((i) => DoctorModel.fromOTPJSON(i)).toList();
        if(data.length>0){
          doctor.T2DcallAssignmentToday=data[0].T2DcallAssignmentToday;
          doctor.MissedCallsMonthally=data[0].MissedCallsMonthally;
          doctor.T2DcallAssignmentMonthally=data[0].T2DcallAssignmentMonthally;
          doctor.TotalCallsMonthally=data[0].TotalCallsMonthally;
          doctor.FirstName=data[0].FirstName;
          doctor.LastName=data[0].LastName;
          doctor.MobileNo=data[0].MobileNo;
          doctor.Pic=data[0].Pic;
          doctor.DocCreateddate=data[0].DocCreateddate;
          doctor.HighesQualification=data[0].HighesQualification;
          doctor.TotalExperence=data[0].TotalExperence;
          doctor.Specialization=data[0].Specialization;
          doctor.gender=data[0].gender;
          doctor.Description=data[0].Description;
          doctor.AddressLine1=data[0].AddressLine1;
          doctor.AddressLine2=data[0].AddressLine2;
          doctor.AddressLine2=data[0].AddressLine2;
          doctor.MBBSCompletionDate=data[0].MBBSCompletionDate;
          doctor.hospitalId=data[0].hospitalId;
          MyAppPrefrences.saveLogin(doctor);
        }
      }
    }catch(_){
      print(_);
    }
    notifyListeners();
  }


}