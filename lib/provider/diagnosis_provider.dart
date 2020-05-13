import 'dart:convert';

import 'package:docpdpartner/model/diagnosis_model.dart';
import 'package:docpdpartner/utils/ApiClient.dart';
import 'package:docpdpartner/utils/AppUtils.dart';
import 'package:flutter/cupertino.dart';

class DignosisProvider extends ChangeNotifier{
  BuildContext mcontext;
  bool isLoad=true;
  List<DiagnosisModel> arrList=[];
  List<DiagnosisModel> selectedArray=[];

  DignosisProvider(BuildContext context,List<DiagnosisModel> list){
    mcontext=context;
    selectedArray=list;
    getDiagnosis();

  }

  getDiagnosis() async {
    
     String response=await ApiClient.get(ApiClient.paGetCommonDiagnoses,mcontext);
     try{
       if(!AppUtils.isEmpty(response)){
         var js=json.decode(response);
         arrList=(js['CommonDiagnosesDetails'] as List).map((i)=>DiagnosisModel.fromJSON(i)).toList();
       }

     }catch(_){
       print(_);
     }
     for(DiagnosisModel m in arrList){
       for(int i=0;i<selectedArray.length;i++ ){
         if(selectedArray[i].diagnosesName==m.diagnosesName){
           m.isSelected =true;
         }
       }

     }
     isLoad=false;
     notifyListeners();
  }

  selected(DiagnosisModel value){
    int index=arrList.indexOf(value);
    arrList[index].isSelected=!arrList[index].isSelected;
    notifyListeners();
    addSelected(value,arrList[index].isSelected);
  }


  addSelected(DiagnosisModel model,bool isRemove){
    bool isExsits=false;
    int index=-1;
    for(int i=0;i<selectedArray.length;i++ ){
      if(selectedArray[i].diagnosesName==model.diagnosesName){
        index=i;
        isExsits =true;
      }
    }
    if(isExsits && !isRemove){
      selectedArray.removeAt(index);
    }else if(!isExsits){
      selectedArray.add(model);
    }
    notifyListeners();
  }

  Future<void> search(String keywork) async {
    if(isLoad) return;
    isLoad=true;
    notifyListeners();
    var url=ApiClient.paSearchDiagnoses+keywork;
    String response=await ApiClient.get(url, mcontext);
    try{
      if(!AppUtils.isEmpty(response)){
        var js=json.decode(response);
        arrList=(js['DiagnosesList'] as List).map((i)=>DiagnosisModel.fromJSON(i)).toList();
      }

    }catch(_){
      print(_);
    }
    for(DiagnosisModel m in arrList){
      for(int i=0;i<selectedArray.length;i++ ){
        if(selectedArray[i].diagnosesName==m.diagnosesName){
          m.isSelected =true;
        }
      }

    }
    isLoad=false;
    notifyListeners();
  }




}