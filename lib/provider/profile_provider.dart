import 'dart:convert';

import 'package:docpdpartner/model/doctor_model.dart';
import 'package:docpdpartner/utils/ApiClient.dart';
import 'package:docpdpartner/utils/AppUtils.dart';
import 'package:docpdpartner/utils/MyAppPrefrences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier{

  DoctorModel doctor=DoctorModel();

  BuildContext mContext;
  DateTime dobDate = DateTime.now();
  DateTime completedMBBSDate ;
  DateTime practiceDate;

  List<String> arrSpeakLang=[];
  List<String> arrSelectLang=[];


  ProfileProvider(BuildContext context){
    mContext=context;
    getLatestData();
  }

  getLatestData() async {
    doctor=await MyAppPrefrences.getLogin();

    notifyListeners();

  }


  setDob(DateTime date){
    dobDate=date;
    notifyListeners();
  }

  setMbbsDate(DateTime date){
    completedMBBSDate=date;
    notifyListeners();
  }
  setPracticeDate(DateTime date){
    practiceDate=date;
    notifyListeners();
  }

  setGender(String gender){
    doctor.gender=gender;
    notifyListeners();
  }




  setName(String v){
     var arr=v.split("_");
     var firstName=v.replaceAll(arr[arr.length-1], '');
    doctor.FirstName=firstName;
    if(arr.length>0)
      doctor.LastName=arr[arr.length-1];
    else
      doctor.LastName='';
  }
  setMobile(v){
    doctor.MobileNo=v;
    notifyListeners();
  }

    Future<void> updateProfile(GlobalKey<ScaffoldState> gState) async {
      if (AppUtils.isEmpty(doctor.FirstName)) {
        gState.currentState.showSnackBar(SnackBar(
          content: Text("Name is required"),
        ));
      } else if (arrSpeakLang.length == 0) {
        gState.currentState.showSnackBar(SnackBar(
          content: Text("Speak Language is required"),
        ));
      } else if (arrSelectLang.length == 0) {
        gState.currentState.showSnackBar(SnackBar(
          content: Text("Write Language is required"),
        ));
      } else if (AppUtils.isEmpty(doctor.gender)) {
        gState.currentState.showSnackBar(SnackBar(
          content: Text("Gender is required"),
        ));
      } else if (dobDate == null) {
        gState.currentState.showSnackBar(SnackBar(
          content: Text("Dob is required"),
        ));
      } else {
        String speek = '';
        for (String lang in arrSpeakLang) {
          speek = speek + lang + ',';
        }

        String language = '';
        for (String lang in arrSelectLang) {
          language = language + lang + ',';
        }

        var map = {
          "FirstName": doctor.FirstName ?? '',
          "LastName": doctor.LastName ?? '',
          "LanguageSpeak": speek,
          "Language": language,
          "Gender": doctor.gender,
          "DOB": AppUtils.dobDisplay.format(dobDate),
          "StartPracticingDate": practiceDate == null ? '' : AppUtils.dobDisplay
              .format(practiceDate),
          "MBBSCompletionDate": completedMBBSDate == null ? '' : AppUtils
              .dobDisplay.format(completedMBBSDate)
        };

        try {
          String response = await ApiClient.post(
              ApiClient.paDoctorProfileUpdate, mContext, body: map,
              state: gState);
          if (!AppUtils.isEmpty(response)) {
            var js = json.decode(response);
            if (js['Status'] == 1 || js['Status'] == '1') {

            }
          }
        } catch (_) {
          print(_);
        }
      }
    }


}