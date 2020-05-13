import 'dart:convert';

import 'package:docpdpartner/model/availibality_model.dart';
import 'package:docpdpartner/model/doctor_model.dart';
import 'package:docpdpartner/model/time_model.dart';
import 'package:docpdpartner/option_model.dart';
import 'package:docpdpartner/utils/ApiClient.dart';
import 'package:docpdpartner/utils/AppUtils.dart';
import 'package:docpdpartner/utils/MyAppPrefrences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAvailibality extends ChangeNotifier{

  List<OptionModel> list=[];
  List<AvailibalityModel> avalibleArray=[];
  OptionModel selectedType;
  TimeOfDay _currentTime = new TimeOfDay.now();

 BuildContext mContext;
  GlobalKey<ScaffoldState> _scaffoldKey;

  String startTime;
  String endTime;

  bool loadData=true;

  int myAvailability=-1; //7,6,5,1

  MyAvailibality(BuildContext context,GlobalKey<ScaffoldState> state){
    mContext=context;
    _scaffoldKey=state;
    list =AppUtils.getOption();
    avalibleArray =AppUtils.getDayName();
    getAvailability();
  }

  void selectMyAvailability(OptionModel value){
    selectedType=value;
    int pos=value.position;
    if(pos==0){
      myAvailability=7;
      for(AvailibalityModel day in avalibleArray){
        day.isSelected=true;
        day.startTime=startTime;
        day.endTime=endTime;
      }
    }else if(pos==1){
      myAvailability=6;
      for(AvailibalityModel day in avalibleArray){
        day.isSelected=true;
        day.startTime=startTime;
        day.endTime=endTime;
      }
      avalibleArray[6].isSelected=false;
      avalibleArray[6].startTime='';
      avalibleArray[6].endTime='';
    }else if(pos==2){
      myAvailability=5;
      for(AvailibalityModel day in avalibleArray){
        day.isSelected=true;
      }
      avalibleArray[5].isSelected=false;
      avalibleArray[6].isSelected=false;
      avalibleArray[5].startTime='';
      avalibleArray[5].endTime='';
      avalibleArray[6].startTime='';
      avalibleArray[6].endTime='';
    }else{
      myAvailability=1;
      for(AvailibalityModel day in avalibleArray){
        day.isSelected=false;
        day.startTime=startTime;
        day.endTime=endTime;
      }
    }

    notifyListeners();
  }


    Future<void> getAvailability() async {

       try{
          String response=await ApiClient.post(ApiClient.paGetDoctorAvailability, mContext,state: _scaffoldKey);
          if(!AppUtils.isEmpty(response)){
              var js=json.decode(response);
              var data=(js['DaytimeDetails'] as List).map((i)=>TimeModel.fromJSON(i)).toList();
              if(data.length>0){
                myAvailability++;
                if(data[0].sundayTiming!=null && data[0].sundayTiming!='Not Available'){
                  var s=data[0].sundayTiming.split("-");
                  avalibleArray[0].startTime=s[0];
                  avalibleArray[0].endTime=s[1];
                  avalibleArray[0].isSelected=true;
                  myAvailability++;
                }
                if(data[0].mondayTiming!=null && data[0].mondayTiming!='Not Available'){
                  var s=data[0].mondayTiming.split("-");
                  avalibleArray[1].startTime=s[0];
                  avalibleArray[1].endTime=s[1];
                  avalibleArray[1].isSelected=true;
                  myAvailability++;
                }
                if(data[0].tuesdayTiming!=null && data[0].tuesdayTiming!='Not Available'){
                  var s=data[0].tuesdayTiming.split("-");
                  avalibleArray[2].startTime=s[0];
                  avalibleArray[2].endTime=s[1];
                  avalibleArray[2].isSelected=true;
                  myAvailability++;
                }

                if(data[0].wednesdayTiming!=null && data[0].wednesdayTiming!='Not Available'){
                  var s=data[0].wednesdayTiming.split("-");
                  avalibleArray[3].startTime=s[0];
                  avalibleArray[3].endTime=s[1];
                  avalibleArray[3].isSelected=true;
                  myAvailability++;
                }

                if(data[0].thursdayTiming!=null && data[0].thursdayTiming!='Not Available'){
                  var s=data[0].thursdayTiming.split("-");
                  avalibleArray[4].startTime=s[0];
                  avalibleArray[4].endTime=s[1];
                  avalibleArray[4].isSelected=true;
                  myAvailability++;
                }

                if(data[0].fridayTiming!=null && data[0].fridayTiming!='Not Available'){
                  var s=data[0].fridayTiming.split("-");
                  avalibleArray[5].startTime=s[0];
                  avalibleArray[5].endTime=s[1];
                  avalibleArray[5].isSelected=true;
                  myAvailability++;
                }

                if(data[0].saturdayTiming!=null && data[0].saturdayTiming!='Not Available'){
                  var s=data[0].saturdayTiming.split("-");
                  avalibleArray[6].startTime=s[0];
                  avalibleArray[6].endTime=s[1];
                  avalibleArray[6].isSelected=true;
                  myAvailability++;
                }
                setMyAvail();
              }
          }
       }catch(_){
         print(_);
       }
       loadData=false;
       notifyListeners();
    }

   void setMyAvail(){
      print(myAvailability);
      if(myAvailability==7){
        selectedType=list[0];
      }else if(myAvailability==6){

        selectedType=list[1];

      }else if(myAvailability==5){
        selectedType=list[2];

      }else{

        selectedType=list[3];

      }
      notifyListeners();
    }



   Future<void> setAvailability(Function callback) async {
     if(startTime==null) {
       _scaffoldKey.currentState.showSnackBar(SnackBar(
         content: Text('Start Time is required',style: TextStyle(color: Colors.red),),
       ));
       callback();
       return;
     }else  if(endTime==null) {
       _scaffoldKey.currentState.showSnackBar(SnackBar(
         content: Text('End Time is required',style: TextStyle(color: Colors.red),),
       ));
       callback();
       return;
     }
     notifyListeners();
     DoctorModel user=await MyAppPrefrences.getLogin();
      var map={
        "hosCustomId": user.hospitalId,
        "mondayTime_from": avalibleArray[0].startTime??'',
        "tuesdayTime_from": avalibleArray[1].startTime??'',
        "wednesdayTime_from": avalibleArray[2].startTime??'',
        "thursdayTime_from": avalibleArray[3].startTime??'',
        "fridayTime_from": avalibleArray[4].startTime??'',
        "saturdayTime_from":avalibleArray[5].startTime??'',
        "sundayTime_from": avalibleArray[6].startTime??'',
        "mondayTime_to": avalibleArray[0].endTime??'',
        "tuesdayTime_to":avalibleArray[1].endTime??'',
        "wednesdayTime_to": avalibleArray[2].endTime??'',
        "thursdayTime_to": avalibleArray[3].endTime??'',
        "fridayTime_to": avalibleArray[4].endTime??'',
        "saturdayTime_to": avalibleArray[5].endTime??'',
        "sundayTime_to": avalibleArray[6].endTime??''
      };
      try{
        String response=await ApiClient.post(ApiClient.paSetDoctorAvailability, mContext,body:map,state: _scaffoldKey);
        if(!AppUtils.isEmpty(response)){
          var js=json.decode(response);
          if(js['Status']==1 || js['Status']=='1') {
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text('Availabilty Updated Successfully...',style: TextStyle(color: Colors.green),),
            ));

          }
        }

      }catch(_){

      }
     callback();
     notifyListeners();
   }

  Future<Null> selectTime(BuildContext context,int index,bool isStart) async {

    if(startTime!=null && endTime!=null) {
      if(AppUtils.isEmpty(avalibleArray[index].startTime) && !isStart){
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Select open time first',style: TextStyle(color: Colors.red),),
        ));
        return;
      }else {
        TimeOfDay selectedTime = await showTimePicker(
          context: context,
          initialTime: _currentTime,
        );

        MaterialLocalizations localizations = MaterialLocalizations.of(context);
        if (selectedTime != null) {
          String formattedTime = localizations.formatTimeOfDay(selectedTime,
              alwaysUse24HourFormat: true);
          if (formattedTime != null) {
            if (isStart) {
              avalibleArray[index].startTime = formattedTime;
            } else {
              var s=avalibleArray[index].startTime.split(':');
              var e=formattedTime.split(':');
              if(int.parse(s[0])<int.parse(e[0])) {
                avalibleArray[index].endTime = formattedTime;
              }else{
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text('End time greater then start time',style: TextStyle(color: Colors.red),),
                ));
              }
            }
          }
        }
        notifyListeners();
      }
    }else{
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Select Start and End Time first..',style: TextStyle(color: Colors.red),),
      ));
    }
  }


  Future<Null> selectOpenTime(BuildContext context,bool isStart) async {
    if(myAvailability==-1){
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Select My Availability',style: TextStyle(color: Colors.red),),
      ));
      return;
    } if(AppUtils.isEmpty(startTime) && !isStart){
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Select open time',style: TextStyle(color: Colors.red),),
      ));
      return;
    }
      TimeOfDay selectedTime = await showTimePicker(
      context: context,
      initialTime: _currentTime,
    );

    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    if (selectedTime != null) {
      String formattedTime = localizations.formatTimeOfDay(selectedTime,
          alwaysUse24HourFormat: true);
      if (formattedTime != null) {
        if(isStart) {
          startTime = formattedTime;
          for(AvailibalityModel day in avalibleArray){
            day.startTime=formattedTime;
          }
        }else {
          var s=startTime.split(':');
          var e=formattedTime.split(':');
          if(int.parse(s[0])<int.parse(e[0])) {
            endTime = formattedTime;
          }else{
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text('End time greater then start time',style: TextStyle(color: Colors.red),),
            ));
          }
          for(AvailibalityModel day in avalibleArray){
            day.endTime=formattedTime;
          }
          refreshState();
        }
      }
    }

    notifyListeners();
  }

  refreshState(){
    if(myAvailability==7){
      for(AvailibalityModel day in avalibleArray){
        day.isSelected=true;
        day.startTime=startTime;
        day.endTime=endTime;
      }
    }else if(myAvailability==6){
      for(AvailibalityModel day in avalibleArray){
        day.isSelected=true;
        day.startTime=startTime;
        day.endTime=endTime;
      }
      avalibleArray[6].isSelected=false;
      avalibleArray[6].startTime='';
      avalibleArray[6].endTime='';
    }else if(myAvailability==5){
      for(AvailibalityModel day in avalibleArray){
        day.isSelected=true;
      }
      avalibleArray[5].isSelected=false;
      avalibleArray[6].isSelected=false;
      avalibleArray[5].startTime='';
      avalibleArray[5].endTime='';
      avalibleArray[6].startTime='';
      avalibleArray[6].endTime='';
    }else{
      for(AvailibalityModel day in avalibleArray){
        day.isSelected=false;
        day.startTime=startTime;
        day.endTime=endTime;
      }
    }
  }

}