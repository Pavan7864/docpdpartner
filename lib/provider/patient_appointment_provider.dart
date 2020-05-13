import 'dart:convert';

import 'package:docpdpartner/model/cancel_model.dart';
import 'package:docpdpartner/model/diagnosis_model.dart';
import 'package:docpdpartner/model/investigation_model.dart';
import 'package:docpdpartner/model/medicine_model.dart';
import 'package:docpdpartner/model/symptomp_model.dart';
import 'package:docpdpartner/page/dialog/success_pop.dart';
import 'package:docpdpartner/page/popup/cancel_appointment_popup.dart';
import 'package:docpdpartner/utils/ApiClient.dart';
import 'package:docpdpartner/utils/AppUtils.dart';
import 'package:docpdpartner/utils/MyAppPrefrences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PatientAppointmentProvider extends ChangeNotifier{
  BuildContext mContext;
  List<DiagnosisModel> arrAllDiagnosis=[];
  List<DiagnosisModel> arrSelectedDianosis=[];
  List<CancelModel> cancelList=[];

  int daySelected=-1;
  bool isLoad=false;
  List<SymptompModel> arrAllSymptomp=[];
  List<SymptompModel> arrSelectedSymptomp=[];

  List<MedicineModel> arrSelectedMedicine=[];

  String bpSystolic;
  String bpDiastolic;
  String notes="";
  String history="";

  String ppReading;
  String sugarFasting;

  String kilo;
  String gram;

  String feed;
  String inch;

  List<InvestigationModel>  arrInvestigation=[];

  PatientAppointmentProvider(BuildContext context){
    this.mContext=context;
    SymptompModel mm=new SymptompModel(id:'',name:'Add');
    arrSelectedSymptomp.add(mm);
    DiagnosisModel d=new DiagnosisModel(id:'',diagnosesName:'Add');
    arrSelectedDianosis.add(d);
    MedicineModel medi=new MedicineModel(id:'',name:'Add');
    arrSelectedMedicine.add(medi);

      InvestigationModel invest = new InvestigationModel( itemName: 'Add');
      arrInvestigation.add(invest);
     getCancelData();
  }



    getCancelData() async {
      try{
        String response=await ApiClient.post(ApiClient.paGetCancelList, mContext);
        if(!AppUtils.isEmpty(response)){
            var js=json.decode(response);
          cancelList=(js['GetServiceCancelList'] as List).map((i)=>CancelModel.fromJSON(i)).toList();
        }

      }catch(_){
        print(_);
      }

    }

    startCall(String patientId,String serviceId,GlobalKey<ScaffoldState> gState) async {
      var map={
        "PatientCustomID": patientId,
        "PatientServiceID": serviceId,
        };
      try{
        String response=await ApiClient.post(ApiClient.VideoCallInitate, mContext,body: map,state: gState);
        if(!AppUtils.isEmpty(response)){

        }

      }catch(_){
        print(_);
      }
    }



  void setHeight(String feed, String inch) {
      this.feed=feed;
      this.inch=inch;
      notifyListeners();
  }

  void setWight(String kilo, String gram) {
      this.kilo=kilo;
      this.gram=gram;
      notifyListeners();
  }


  void setBp(String bpSystolic, String bpDiastolic) {
      this.bpSystolic=bpSystolic;
      this.bpDiastolic=bpDiastolic;
      notifyListeners();
  }


  void setSugar(String ppReading, String sugarFasting) {
    this.ppReading=ppReading;
    this.sugarFasting=sugarFasting;
    notifyListeners();
  }

  void setDiagnosis(List<DiagnosisModel> m) {

    arrAllDiagnosis=m;
    if(m.length==0) {
      DiagnosisModel mm = new DiagnosisModel(id: '', diagnosesName: 'Add');
      arrSelectedDianosis.add(mm);
    }
     for(DiagnosisModel model in arrAllDiagnosis){
        if(model.isSelected){
          arrSelectedDianosis.add(model);
        }
     }

     notifyListeners();
  }

  void setInvestigation(List<InvestigationModel> m) {

    arrInvestigation=m;
    if(m.length==0) {
      InvestigationModel mm = new InvestigationModel( itemName: 'Add');
      arrInvestigation.add(mm);
    }


     notifyListeners();
  }


  void setSymptomp(List<SymptompModel> m) {

    arrAllSymptomp=m;
    if(m.length==0) {
      SymptompModel mm = new SymptompModel(id: '', name: 'Add');
      arrSelectedSymptomp.add(mm);
    }
     for(SymptompModel model in arrAllSymptomp){
        if(model.isSelected){
          arrSelectedSymptomp.add(model);
        }
     }

     notifyListeners();
  }

  void setMedician(List<MedicineModel> m) {

    if(m.length==0) {
      MedicineModel medi = new MedicineModel(id: '', name: 'Add');
      arrSelectedMedicine.add(medi);
    }
    arrSelectedMedicine=m;

     notifyListeners();
  }

  void dayPick(int i) {
    daySelected=i;
    notifyListeners();
  }

  void setNotes(String value){
    notes=value;
  }

  void setHistory(String value){
    history=value;
  }


  Future<void> generatPdf(String reason,String serviceID,String customId,String patientId,GlobalKey<ScaffoldState> gState) async {
    isLoad=true;
    notifyListeners();
    
    String height="${feed??'0'}.${inch??'0'}";
    String weight="${kilo??'0'}.${gram??'0'}";
    String suger="${ppReading??'0'}.${sugarFasting??'0'}";
    String bp="${bpSystolic??'0'}.${bpDiastolic??'0'}";

    var evital=[ { "Height": height, "Weight": weight, "BloodGroup": "AB+","bloodPresure":bp,"sugar":suger} ];


    List investigationjsonList = List();
    if(arrInvestigation[0].itemName!='Add')
       arrInvestigation.map((item)=> investigationjsonList.add(item.toMap())).toList();
//    var investigat = json.encode(investigationjsonList);

    List diagonesjsonList = List();
    if(arrSelectedDianosis[0].diagnosesName!='Add')
       arrSelectedDianosis.map((item)=> diagonesjsonList.add(item.toMap())).toList();
//    var diagones = json.encode(diagonesjsonList);

    List SymptompjsonList = List();
    if(arrSelectedSymptomp[0].name!='Add')
      arrSelectedSymptomp.map((item)=> SymptompjsonList.add(item.toMap())).toList();
   // var symptomp = json.encode(SymptompjsonList);

    List medicinejsonList = List();
    if(arrSelectedMedicine[0].name!='Add')
      arrSelectedMedicine.map((item)=> medicinejsonList.add(item.toMap())).toList();
    //var mediciane = json.encode(medicinejsonList);


    var map={
      'ServiceID':serviceID,
      'PatientCustomID':customId,
      'patientId':patientId??'',
      'Reason':reason,
      'pdfurl':'',
      'NextVisit':daySelected,
      'Notes':notes??'',
      'MedicalSummary':history??'',
      'evital':evital,
      'ePatientSymtoms':SymptompjsonList,
      'eMedicine':medicinejsonList,
      'eDaignosis':diagonesjsonList,
      'eInvestigation':investigationjsonList,
      'eReferal':[],
    };
    print(diagonesjsonList);
    print(investigationjsonList);

    try {
      String response = await ApiClient.post(ApiClient.CSCPrescriptionGenerate, mContext, body: map,state: gState);
      if(!AppUtils.isEmpty(response)){
          var js=json.decode(response);
          if(js['Status']==1 || js['Status']=='1'){
            showDialog(
              barrierDismissible: false,
              context: mContext,
              builder: (BuildContext context) => SuccessPopUp(
                "Prescription Generated\n and Sent"
              ),
            );

          }
      }
    }catch(_){
      print(_);
    }
    isLoad=false;
    notifyListeners();
  }

}