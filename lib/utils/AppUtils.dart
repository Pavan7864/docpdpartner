import 'dart:async';
import 'dart:convert';
import 'package:device_id/device_id.dart';
import 'package:docpdpartner/model/availibality_model.dart';
import 'package:docpdpartner/model/days_medicine.dart';
import 'package:docpdpartner/model/language_model.dart';
import 'package:docpdpartner/option_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:io' show Platform;

import 'package:intl/intl.dart';

class AppUtils{

  static final f = new DateFormat('yyyy-MM-dd hh:mm');
  static final dobDisplay = new DateFormat('dd/MM/yyyy');

  static final appointmentDate = new DateFormat('yyyy-MM-ddTHH:mm:ss');
  static final appointment = new DateFormat('dd MMMM yyyy \'at\' HH:mm');
  static final monthNameForamte = new DateFormat('MMM dd, yyyy \'at\'');

  static bool isEmpty(String value){
    if(value==null){
      return true;
    }if(value=='null'){
      return true;
    }else if(value.length==0){
      return true;
    }else{
      return false;
    }
  }

  static String fullMonthName(String date){

    if(isEmpty(date)){
      return "";
    }else{
      return "Active form "+date.split(" ")[0];
    }
  }


  static String add(String value1,String value2, String sprater,String hint){
    if(value1==null && value2==null){
      return hint;
    }else if(isEmpty(value1) && value2!=null){
      return value2;
    }else if(isEmpty(value2) && value1!=null){
      return value1;
    }else{
      return "$value1$sprater$value2";
    }
  }
  static String adddob(String value1,String value2, String sprater,String hint){
    if(value1==null && value2==null){
      return hint;
    }else if(isEmpty(value1) && value2!=null){
      return value2;
    }else if(isEmpty(value2) && value1!=null ){
      try {
        final birthday = appointmentDate.parse(value2);
        final date2 = DateTime.now();
        final difference = ((date2
            .difference(birthday)
            .inDays) / 365).toInt();
        return difference.toString() + ' years';
      }catch(_){
        return "";
      }
    }else{
      try{
      final birthday = appointmentDate.parse(value2);
      final date2 = DateTime.now();
      final difference = ((date2.difference(birthday).inDays)/365).toInt();
      return "$value1$sprater$difference years";
      }catch(_){
        return value1;
      }
    }
  }
  static String addT(String value1,String value2,String value3, String sprater){
    var v1=value1??'-';
    var v2=value2??'-';
    var v3=value3??'-';

    return v1+sprater+v2+sprater+v3;

  }

  static String covertDate(String serverDate,DateFormat serverFormat,DateFormat convertFormat){
    String newDate=serverDate.split('.')[0];
    try{
       var d1=serverFormat.parse(newDate);
       newDate=convertFormat.format(d1);

    }catch(_){
         print(_);
    }

    return newDate;
  }

  static String setDate(DateTime date){
     if(date==null){
       return "";
     }else{
       return dobDisplay.format(date);
     }
  }

  static bool isBigZero(String value){
     if(value.length==0){
       return false;
     }else if(int.parse(value)>=0){
       return true;
     }else{
       return false;
     }
  }

  static List<MedicineDay> getDaysList(){
    List<MedicineDay> list=[];
//'', '', '', ''
    MedicineDay m=new MedicineDay('Day','01',0,nodays: '1');
    MedicineDay m2=new MedicineDay('Days','02',1,nodays: '2');
    MedicineDay m3=new MedicineDay('Days','03',2,nodays: '3');
    MedicineDay m4=new MedicineDay('Days','04',3,nodays: '4');
    MedicineDay m5=new MedicineDay('Days','05',4,nodays: '5');
    MedicineDay m6=new MedicineDay('Week','01',5,nodays: '7');
    MedicineDay m7=new MedicineDay('Weeks','02',6,nodays: '14');
    MedicineDay m8=new MedicineDay('Weeks','03',7,nodays: '21');
    MedicineDay m9=new MedicineDay('Month','01',8,nodays: '30');
    MedicineDay m10=new MedicineDay('Months','02',9,nodays: '60');
    list.add(m);
    list.add(m2);
    list.add(m3);
    list.add(m4);
    list.add(m5);
    list.add(m6);
    list.add(m7);
    list.add(m8);
    list.add(m9);
    list.add(m10);
    return list;

  }




  static List<MedicineDay> getFrequency(){
    List<MedicineDay> list=[];
//'', '', '', ''
    MedicineDay m=new MedicineDay('Once a Day','OD',0);
    MedicineDay m2=new MedicineDay('Two Times of Day','BD',1);
    MedicineDay m3=new MedicineDay('Thirce a Day','TID',2);
    MedicineDay m4=new MedicineDay('Four Times a Day','QDS',3);
    MedicineDay m5=new MedicineDay('On Need','SOS',4);
    list.add(m);
    list.add(m2);
    list.add(m3);
    list.add(m4);
    list.add(m5);
    return list;

  }

  static List<OptionModel> getOption(){
    List<OptionModel> list=[];
//'', '', '', ''
    OptionModel m=new OptionModel(name: 'Daily (All 7 Days)',displayName: 'All 7 Days',position: 0);
    OptionModel m1=new OptionModel(name: 'Except Sunday (All 6 Days)',displayName: 'All 6 Days',position: 1);
    OptionModel m2=new OptionModel(name: 'Except Weekend (All 5 Days)',displayName: 'All 5 Days',position: 2);
    OptionModel m3=new OptionModel(name: 'Weekly (1 Days)',displayName: '1 Days',position: 3);
    list.add(m);
    list.add(m1);
    list.add(m2);
    list.add(m3);
    return list;

  }

  static List<AvailibalityModel> getDayName(){
    List<AvailibalityModel> list=[];
//'', '', '', ''
    AvailibalityModel m=new AvailibalityModel(name: 'Monday',startTime: '',endTime: '');
    AvailibalityModel m1=new AvailibalityModel(name: 'Tuesday',startTime: '',endTime: '');
    AvailibalityModel m2=new AvailibalityModel(name: 'Wednesday',startTime: '',endTime: '');
    AvailibalityModel m3=new AvailibalityModel(name: 'Thursday',startTime: '',endTime: '');
    AvailibalityModel m4=new AvailibalityModel(name: 'Friday',startTime: '',endTime: '');
    AvailibalityModel m5=new AvailibalityModel(name: 'Saturday',startTime: '',endTime: '');
    AvailibalityModel m6=new AvailibalityModel(name: 'Sunday',startTime: '',endTime: '');
    list.add(m);
    list.add(m1);
    list.add(m2);
    list.add(m3);
    list.add(m4);
    list.add(m5);
    list.add(m6);
    return list;

  }

  static List<LanguageModel> getLanguage(){
    List<LanguageModel> list=[];
    var m=LanguageModel();
    m.name='Hindi';
    m.position=0;
    list.add(m);
    var m1=LanguageModel();
    m1.name='English';
    m1.position=1;
    list.add(m1);
    var m2=LanguageModel();
    m2.name='Bengali';
    m2.position=2;
    list.add(m2);

    var m3=LanguageModel();
    m3.name='Marathi';
    m3.position=3;
    list.add(m3);

    var m4=LanguageModel();
    m4.name='Telugu';
    m4.position=4;
    list.add(m4);

    var m5=LanguageModel();
    m5.name='Punjabi';
    m5.position=5;
    list.add(m5);
    return list;

  }

}