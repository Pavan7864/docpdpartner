import 'dart:convert';

import 'package:docpdpartner/model/diagnosis_model.dart';
import 'package:docpdpartner/model/symptomp_model.dart';
import 'package:docpdpartner/utils/ApiClient.dart';
import 'package:docpdpartner/utils/AppUtils.dart';
import 'package:flutter/cupertino.dart';

class SymptompProvider extends ChangeNotifier{
  BuildContext mContext;
  bool isLoad=true;
  List<SymptompModel> arrList=[];
  List<SymptompModel> selectedSymtomps=[];

  SymptompProvider(BuildContext context, List<SymptompModel> list){
    mContext=context;
    selectedSymtomps=list;
    getDiagnosis();

  }

  getDiagnosis() async {
    
     String response=await ApiClient.get(ApiClient.paGetCommonSymptom,mContext);
     try{
       if(!AppUtils.isEmpty(response)){
         var js=json.decode(response);
         arrList=(js['CommonSymptomsDetails'] as List).map((i)=>SymptompModel.fromJSON(i)).toList();
       }

     }catch(_){
       print(_);
     }
     for(SymptompModel m in arrList){
       for(int i=0;i<selectedSymtomps.length;i++ ){
         if(selectedSymtomps[i].name==m.name){
           m.isSelected =true;
         }
       }

     }
     isLoad=false;
     notifyListeners();
  }

  selected(SymptompModel value){
    int index=arrList.indexOf(value);
    arrList[index].isSelected=!arrList[index].isSelected;
    notifyListeners();
    addSelected(value, arrList[index].isSelected);
  }

   addSelected(SymptompModel model,bool isRemove){
     bool isExsits=false;
     int index=-1;
     for(int i=0;i<selectedSymtomps.length;i++ ){
        if(selectedSymtomps[i].name==model.name){
           index=i;
          isExsits =true;
        }
     }
     if(isExsits && !isRemove){
        selectedSymtomps.removeAt(index);
     }else if(!isExsits){
       selectedSymtomps.add(model);
     }
     notifyListeners();
   }

  Future<void> search(String keywork) async {
    if(isLoad) return;
    isLoad=true;
    notifyListeners();
    var url=ApiClient.paSearchSymptoms+keywork;
    String response=await ApiClient.get(url, mContext);
    try{
      if(!AppUtils.isEmpty(response)){
        var js=json.decode(response);
        arrList=(js['SymptomsList'] as List).map((i)=>SymptompModel.fromJSON(i)).toList();
      }

    }catch(_){
      print(_);
    }
    for(SymptompModel m in arrList){
      for(int i=0;i<selectedSymtomps.length;i++ ){
        if(selectedSymtomps[i].name==m.name){
          m.isSelected =true;
        }
      }

    }
    isLoad=false;
    notifyListeners();
  }




}