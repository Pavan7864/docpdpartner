import 'dart:convert';

import 'package:docpdpartner/model/investigation_model.dart';
import 'package:docpdpartner/utils/ApiClient.dart';
import 'package:docpdpartner/utils/AppUtils.dart';
import 'package:flutter/cupertino.dart';

class InvestigationProvider extends ChangeNotifier{

    List<InvestigationModel>  arrInvestigation=[];
    List<InvestigationModel>  selectedInvestigation=[];


    BuildContext mContext;
    
    bool isLoadRdiology=true;
    
    InvestigationProvider(BuildContext context,List<InvestigationModel>  list){
       this.mContext=context;
       if(list!=null){
         if(list.length>0&&list[0].itemName=='Add')
           list.removeAt(0);
         selectedInvestigation=list;
       }

       getInvestigation();
    }

     getInvestigation() async {

       var map={
         "Type":"null"
       };

        try{
          String response=await ApiClient.post(ApiClient.paSearchInvestigationCommon, mContext,body: map);
          if(!AppUtils.isEmpty(response)){
              var js=json.decode(response);
              arrInvestigation=(js['LabTestDetail'] as List).map((i)=>InvestigationModel.fromJSON(i)).toList();
          }
        }catch(_){
          print(_);
        }
       isLoadRdiology=false;
        notifyListeners();
        
     }

    searchInvestigation(String value) async {
      isLoadRdiology=true;
      notifyListeners();
      var map={
        "searchItem":value,
        "Type":"null"
      };

      String response=await ApiClient.post(ApiClient.paSearchInvestigation, mContext,body: map);
      try{
        if(!AppUtils.isEmpty(response)){
          var js=json.decode(response);
          arrInvestigation=(js['searchInvestigation'] as List).map((i)=>InvestigationModel.fromJSON(i)).toList();
        }
      }catch(_){
           print(_);
      }
      isLoadRdiology=false;
      notifyListeners();

    }


      selectInvestigation(InvestigationModel model){
        int index=arrInvestigation.indexOf(model);
        arrInvestigation[index].isSelected=! arrInvestigation[index].isSelected;

        notifyListeners();
        addData(model, arrInvestigation[index].isSelected);

      }

      addData(InvestigationModel model,bool isRemove){

        bool isExsits=false;
        int index=-1;
        for(int i=0;i<selectedInvestigation.length;i++ ){
          if(selectedInvestigation[i].itemName==model.itemName){
            index=i;
            isExsits =true;
          }
        }
        if(isExsits && !isRemove){
          selectedInvestigation.removeAt(index);
        }else if(!isExsits){
          selectedInvestigation.add(model);
        }
        notifyListeners();
      }




}