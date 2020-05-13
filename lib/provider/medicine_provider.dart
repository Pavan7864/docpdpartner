import 'dart:convert';

import 'package:docpdpartner/model/medicine_model.dart';
import 'package:docpdpartner/utils/ApiClient.dart';
import 'package:docpdpartner/utils/AppUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MedicineProvider extends ChangeNotifier{
   BuildContext mContext;
   List<MedicineModel> arrMedicine=[];
   List<MedicineModel> arrSelectedMedicine=[];
   bool isLoad=false;
   int type=1;
   String medicineType='Generic';
   GlobalKey<ScaffoldState> gState;

   MedicineProvider(BuildContext context,List<MedicineModel> list,GlobalKey<ScaffoldState> state){
     mContext=context;
     gState=state;
     if(list.length>0&&list[0].name=='Add')
         list.removeAt(0);
     arrSelectedMedicine=list;
   }

   void setMedicineType(String v,int value) {
     medicineType=v;
     type=value;
     notifyListeners();
   }

    search(String keywork) async {
     if(isLoad) return;
      isLoad=true;
      notifyListeners();
      try{
        var map={
          "Search": keywork,
          "Type": type.toString()
        };
        String response=await ApiClient.post(ApiClient.paSearchGenericMedicine, mContext,body: map,state: gState);
        if(!AppUtils.isEmpty(response)){
            var js=json.decode(response);
            arrMedicine=(js['MedicineList'] as List).map((i)=>MedicineModel.fromJSON(i)).toList();
        }

      }catch(_){
        print(_);
      }
      for(MedicineModel m in arrMedicine){
        for(int i=0;i<arrSelectedMedicine.length;i++ ){
          if(arrSelectedMedicine[i].name==m.name){
            m.isSelected =true;
          }
        }

      }
      isLoad=false;
      notifyListeners();
    }


   selected(MedicineModel value){
     int index=arrMedicine.indexOf(value);
     arrMedicine[index].isSelected=!arrMedicine[index].isSelected;
     notifyListeners();
     localSelect(value,arrMedicine[index].isSelected);
   }

   localSelect(MedicineModel value,bool isremove){
     bool isAvailable=false;
     int index=-1;
       for(int i=0;i<arrSelectedMedicine.length;i++ ){
         if(arrSelectedMedicine[i].name==value.name){
           index =i;
           isAvailable=true;
         }
       }

     if(isAvailable && !isremove){
       arrSelectedMedicine.removeAt(index);
     }else if(!isAvailable){
       arrSelectedMedicine.add(value);
     }

     notifyListeners();
   }

   removeSelected(MedicineModel m){
     for(int i=0;i<arrSelectedMedicine.length;i++ ){
       if(arrSelectedMedicine[i].id==m.id){
         arrSelectedMedicine.removeAt(i);
         break;
       }
     }
     for(int i=0;i<arrMedicine.length;i++ ){
       if(arrMedicine[i].id==m.id){
         arrMedicine[i].isSelected=false;
         break;
       }
     }
     notifyListeners();
   }

}