import 'dart:convert';

import 'package:docpdpartner/model/history_model.dart';
import 'package:docpdpartner/utils/ApiClient.dart';
import 'package:docpdpartner/utils/AppUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoryProvider extends ChangeNotifier{

  List<HistoryModel> arrMissed=[];
  List<HistoryModel> arrAttempted=[];
  BuildContext mContext;
  GlobalKey<ScaffoldState> state;

  int missedPage=0;
  int attemptedPage=0;

  bool isMissedLoad=false;
  bool missedMoreLoad=true;
  bool attemptMoreLoad=true;
  bool isAttemptedLoad=false;



  HistoryProvider(BuildContext context,GlobalKey<ScaffoldState> _scaffoldKey){
    state=_scaffoldKey;
    mContext=context;
    getMissedAppointment();
    getAttemptAppointment();
  }


    getMissedAppointment() async {

     if(!missedMoreLoad) return;
     if(isMissedLoad) return;

      isMissedLoad=true;
      notifyListeners();
        missedPage++;
        var map={
          "Type": "Missed",
          "pageNo": missedPage.toString()
        };
        
        try{
          String response = await ApiClient.post(ApiClient.paGetDoctorHistory, mContext,body: map,state: state);
          if(!AppUtils.isEmpty(response)){
             var js=json.decode(response);
              List<HistoryModel> data=(js['GetDoctorListDetails'] as List).map((i)=>HistoryModel.fromJSON(i)).toList();
              if(data.length>0){
                   if(data.length<10){
                     missedMoreLoad=false;
                   }
                  arrMissed.addAll(data);
              }else{
                 missedMoreLoad=false;
              }
          }
        }catch(_){
          
        }
      isMissedLoad=false;
      notifyListeners();
    }


  getAttemptAppointment() async {

    if(!attemptMoreLoad) return;
    if(isAttemptedLoad) return;

    isAttemptedLoad=true;
    notifyListeners();
    attemptedPage++;
    var map={
      "Type": "Attempt",
      "pageNo": attemptedPage.toString()
    };

    try{
      String response = await ApiClient.post(ApiClient.paGetDoctorHistory, mContext,body: map,state: state);
      if(!AppUtils.isEmpty(response)){
        var js=json.decode(response);
        List<HistoryModel> data=(js['GetDoctorListDetails'] as List).map((i)=>HistoryModel.fromJSON(i)).toList();
        if(data.length>0){
          if(data.length<10){
            attemptMoreLoad=false;
          }
          arrAttempted.addAll(data);
        }else{
          attemptMoreLoad=false;
        }
      }
    }catch(_){

    }
    isAttemptedLoad=false;
    notifyListeners();
  }


}