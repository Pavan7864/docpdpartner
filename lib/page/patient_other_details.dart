import 'package:docpdpartner/call/jitisi.dart';
import 'package:docpdpartner/custom_ui/imageView/CircleImageView.dart';
import 'package:docpdpartner/custom_ui/imageView/ImageViewSize.dart';
import 'package:docpdpartner/custom_ui/imageView/NetWorkImage.dart';
import 'package:docpdpartner/custom_ui/imageView/TextView.dart';
import 'package:docpdpartner/custom_ui/imageView/dotted_border.dart';
import 'package:docpdpartner/model/appointment_model.dart';
import 'package:docpdpartner/model/diagnosis_model.dart';
import 'package:docpdpartner/model/investigation_model.dart';
import 'package:docpdpartner/model/medicine_model.dart';
import 'package:docpdpartner/model/symptomp_model.dart';
import 'package:docpdpartner/option_model.dart';
import 'package:docpdpartner/page/diagnosis_page.dart';
import 'package:docpdpartner/page/dialog/ZoomImage.dart';
import 'package:docpdpartner/page/investigation_container.dart';
import 'package:docpdpartner/page/medicine_page.dart';
import 'package:docpdpartner/page/popup/bp_dialog.dart';
import 'package:docpdpartner/page/popup/cancel_appointment_popup.dart';
import 'package:docpdpartner/page/popup/height_dialog.dart';
import 'package:docpdpartner/page/popup/sugar_dialog.dart';
import 'package:docpdpartner/page/popup/wight_dialog.dart';
import 'package:docpdpartner/page/symptomp_page.dart';
import 'package:docpdpartner/provider/patient_appointment_provider.dart';
import 'package:docpdpartner/utils/AppUtils.dart';
import 'package:docpdpartner/utils/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientOtherDetails extends StatefulWidget{

  @override
  _PatientOtherDetails createState()=>_PatientOtherDetails();
}
class _PatientOtherDetails extends State<PatientOtherDetails> {
  final globalKey = GlobalKey<ScaffoldState>();
  AppointmentModel appointmentModel;
  Jitisi _callKit = Jitisi();

  PatientAppointmentProvider _app;
   List<String> imageArr=[];

  @override
  void initState() {
    super.initState();
    _callKit.configure();
  }



     @override
  Widget build(BuildContext context) {
       final  Map<String, Object> data = ModalRoute.of(context).settings.arguments;
       appointmentModel=AppointmentModel.fromJSON(data);
       _app=PatientAppointmentProvider(context);
       if(!AppUtils.isEmpty(appointmentModel.MedicalHistory)){
         imageArr=appointmentModel.MedicalHistory.split(",");
       }

       return WillPopScope(
         // ignore: missing_return
         onWillPop: (){
           if(!_app.isLoad)
              Navigator.pop(context);
         },
         child: Scaffold(
           key: globalKey,
         backgroundColor: Theme.of(context).backgroundColor,
         body: SafeArea(
             child: ChangeNotifierProvider<PatientAppointmentProvider>(
               create:(context)=>_app,
            child: Consumer(builder: (context,PatientAppointmentProvider model,child){

              return Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: <Widget>[
                            IconButton(icon: Icon(Icons.arrow_back,size: 25,), onPressed: (){
                              if(!model.isLoad)
                                Navigator.of(context).pop();
                            }),
                            Expanded(
                              child: TextView(
                                'Patient Details',align: TextAlign.center,weight: FontWeight.w500,colors: Theme.of(context).primaryColor,size: 18,),

                            ),

                            ImageViewSize('assets/icon/audiocall.png',20,20),
                            InkWell(
                                onTap: (){
                                  if(!AppUtils.isEmpty(appointmentModel.meetingID)) {
                                    model.startCall(appointmentModel.customId,appointmentModel.id,globalKey);
                                    _callKit.startMeeting(appointmentModel.meetingID);
                                  }
                                },
                                child: ImageViewSize('assets/icon/videocall.jpg',22,22,mergin: const EdgeInsets.only(left: 25,right: 10),)
                            ),


                          ],
                        ),
                      ),
                      Expanded(child: ListView(
                        padding: const EdgeInsets.only(left: 0,right: 0,bottom: 0),
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(top: 7,bottom: 3,left: 10,right: 10),
                            child: Card(
                              elevation: 5,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: InkWell(
                                  onTap: (){
                                    var map=appointmentModel.toMap();
                                    Navigator.pushNamed(context, '/PatientDetails',arguments: map);
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      CircleImageView(appointmentModel.userPic,60),
                                      Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.only(left: 10,top: 7,bottom: 7),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              TextView(appointmentModel.userName,colors: Theme.of(context).primaryColor,size: 16,weight: FontWeight.w500,),
                                              Container(
                                                margin: const EdgeInsets.only(top: 5,bottom: 2),
                                                child: Row(
                                                  children: <Widget>[

                                                    TextView(AppUtils.covertDate(appointmentModel.appoinmentDate,AppUtils.appointmentDate, AppUtils.appointment)
                                                      ,align: TextAlign.start,colors: Theme.of(context).hintColor,size: 13,weight: FontWeight.w400,
                                                      mergin: const EdgeInsets.only(left: 0),
                                                    )
                                                  ],
                                                ),
                                              ),


                                            ],
                                          ),
                                        ),
                                      ),

                                      Icon(Icons.arrow_forward_ios,size: 22,color: Theme.of(context).hintColor.withOpacity(0.5),)

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          TextView('Vitals',size: 17,weight: FontWeight.w500,colors: Theme.of(context).primaryColor,
                            mergin: const EdgeInsets.only(left: 15,bottom: 8,top: 30),),
                          Container(
                            margin: const EdgeInsets.only(left: 15,right: 15,bottom: 30),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                border: Border.all(color: Theme.of(context).hintColor.withOpacity(0.3),width: 1),
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    child: ImageViewSize('assets/icon/Vitals.png',25,25)
                                ),
                                Container(height: 45,width: 1,color: Theme.of(context).hintColor ,margin: const EdgeInsets.only(left: 10,top: 5,right: 10),),
                                Expanded(child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Expanded(child: Container(
                                          child: InkWell(
                                            onTap:() async {
                                              appointmentModel.bpSystolic=model.bpSystolic;
                                              appointmentModel.bpDiastolic=model.bpDiastolic;
                                              AppointmentModel m=await Navigator.push(context, MaterialPageRoute(builder: (context) =>BPLevelDialog(appointmentModel)));
//                                        AppointmentModel m=await Navigator.pushNamed<AppointmentModel>(context,'/BPLevelDialog', arguments: data);
                                              if(m!=null){
                                                appointmentModel=m;
                                                model.setBp(appointmentModel.bpSystolic,appointmentModel.bpDiastolic);
                                              }

                                            },
                                            child: Card(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                                              elevation: 5,
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  ImageViewSize('assets/icon/bp_icon.png',25,25,mergin: const EdgeInsets.only(left: 5)),
                                                  Expanded(child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      TextView('BP Level',size: 12,weight: FontWeight.w500, colors: Theme.of(context).primaryColor,
                                                        mergin: const EdgeInsets.only(top: 10,bottom: 3,left: 7),),
                                                      TextView(AppUtils.add(model.bpSystolic,model.bpDiastolic,'-','Enter Reading'),size: 10, weight: FontWeight.w400,colors: Theme.of(context).hintColor,
                                                        mergin: const EdgeInsets.only(top: 0,bottom: 10,left: 7),),
                                                    ],
                                                  ))

                                                ],
                                              ),
                                            ),
                                          ),
                                        )),

                                        Expanded(child: Container(
                                          margin: const EdgeInsets.only(left: 7,right: 0),
                                          child: Card(
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                                            elevation: 5,
                                            child: InkWell(
                                              onTap:() async {
                                                appointmentModel.ppReading=model.ppReading;
                                                appointmentModel.sugarFasting=model.sugarFasting;
                                                AppointmentModel m=await Navigator.push(context, MaterialPageRoute(builder: (context) =>SugarDialog(appointmentModel)));
//
//                                          AppointmentModel m=await Navigator.pushNamed(context,'/SugarDialog', arguments: data);
                                                if(m!=null){
                                                  appointmentModel=m;
                                                  model.setSugar(appointmentModel.ppReading,appointmentModel.sugarFasting);
                                                }

                                              },
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  ImageViewSize('assets/icon/dibtick_iocn.png',25,25,mergin: const EdgeInsets.only(left: 5),),
                                                  Expanded(child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      TextView('Sugar Level',size: 12,weight: FontWeight.w500, colors: Theme.of(context).primaryColor,
                                                        mergin: const EdgeInsets.only(top: 10,bottom: 3,left: 7),),
                                                      TextView(AppUtils.add(model.ppReading,model.sugarFasting,'-','Enter Reading'),size: 10, weight: FontWeight.w400,colors: Theme.of(context).hintColor,
                                                        mergin: const EdgeInsets.only(top: 0,bottom: 10,left: 7),),
                                                    ],
                                                  ))

                                                ],
                                              ),
                                            ),
                                          ),
                                        )),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Expanded(child: Container(
                                          margin: const EdgeInsets.only(left: 0,right: 0,top: 5),
                                          child: InkWell(
                                            onTap:() async {
                                              appointmentModel.kilo=model.kilo;
                                              appointmentModel.gram=model.gram;
                                              AppointmentModel m=await Navigator.push(context, MaterialPageRoute(builder: (context) =>WightDialog(appointmentModel)));
//
//                                        AppointmentModel m=await Navigator.pushNamed(context,'/WightDialog', arguments: data);;
                                              if(m!=null){
                                                appointmentModel=m;
                                                model.setWight(appointmentModel.kilo,appointmentModel.gram);
                                              }
                                            },
                                            child: Card(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                                              elevation: 5,
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  ImageViewSize('assets/icon/wight_icon.png',25,25,mergin: const EdgeInsets.only(left: 5)),
                                                  Expanded(child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      TextView('Weight',size: 12,weight: FontWeight.w500, colors: Theme.of(context).primaryColor,
                                                        mergin: const EdgeInsets.only(top: 10,bottom: 3,left: 7),),
                                                      TextView(AppUtils.add(model.kilo,model.gram,'-','Enter Reading'),size: 10, weight: FontWeight.w400,colors: Theme.of(context).hintColor,
                                                        mergin: const EdgeInsets.only(top: 0,bottom: 10,left: 7),),
                                                    ],
                                                  ))

                                                ],
                                              ),
                                            ),
                                          ),
                                        )),

                                        Expanded(child: Container(
                                          margin: const EdgeInsets.only(left: 7,right: 0,top: 5),
                                          child: InkWell(
                                            onTap:() async {
                                              appointmentModel.feed=model.feed;
                                              appointmentModel.inch=model.inch;
                                              AppointmentModel m=await Navigator.push(context, MaterialPageRoute(builder: (context) =>HeightDialog(appointmentModel)));
//
//                                        AppointmentModel m=await Navigator.pushNamed(context,'/HeightDialog', arguments: data);
                                              if(m!=null){
                                                appointmentModel=m;
                                                model.setHeight(appointmentModel.feed,appointmentModel.inch);
                                              }
                                            },
                                            child: Card(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                                              elevation: 5,
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  ImageViewSize('assets/icon/hight_icon.png',25,25,mergin: const EdgeInsets.only(left: 5),),
                                                  Expanded(child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      TextView('Height',size: 12,weight: FontWeight.w500, colors: Theme.of(context).primaryColor,
                                                        mergin: const EdgeInsets.only(top: 10,bottom: 3,left: 7),),
                                                      TextView(AppUtils.add(model.feed,model.inch,'-','Enter Reading'),size: 10, weight: FontWeight.w400,colors: Theme.of(context).hintColor,
                                                        mergin: const EdgeInsets.only(top: 0,bottom: 10,left: 7),),
                                                    ],
                                                  ))

                                                ],
                                              ),
                                            ),
                                          ),
                                        )),
                                      ],
                                    ),
                                  ],
                                ))
                              ],
                            ),

                          ),


                          imageArr.length==0?Container():Container(
                            height: 100,
                          margin: const EdgeInsets.only(right: 15,bottom: 10,left: 15),
                            child: Row(
                              children: <Widget>[
                                Expanded(child: imageArr.length>0?InkWell(
                                     onTap:(){
                                       Navigator.push(context, MaterialPageRoute(builder: (context) =>ZoomImage(imageArr[0])));

                                     },
                                    child: AppImageImage(imageArr[0],'assets/icon/placeholder.png')):Container()),
                                Expanded(child: imageArr.length>1?InkWell(
                                    onTap:(){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>ZoomImage(imageArr[1])));

                                    },child: AppImageImage(imageArr[1],'assets/icon/placeholder.png')):Container()),
                                Expanded(child: imageArr.length>2?InkWell(
                                    onTap:(){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>ZoomImage(imageArr[2])));

                                    },child: AppImageImage(imageArr[2],'assets/icon/placeholder.png')):Container()),
                              ],
                            ),
                          ),

                          TextView('Medical History',size: 16,weight: FontWeight.w500, colors: Theme.of(context).hintColor,
                            mergin: const EdgeInsets.only(top: 10,bottom: 7,left: 15),),

                          Container(
                            margin: const EdgeInsets.only(right: 15,bottom: 20,left: 15),

                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              controller: TextEditingController(text: model.history??''),
                              maxLines: 3,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: const EdgeInsets.only(left: 10,right: 10,top: 7,bottom: 7)
                              ),
                              onChanged: (v){
                                model.setHistory(v);
                              },
                              style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 15,fontWeight: FontWeight.w400),
                            ),
                          ),


                          TextView('Symptoms',size: 17,weight: FontWeight.w500,colors: Theme.of(context).hintColor,
                            mergin: const EdgeInsets.only(left: 15,bottom: 8,top: 0),),
                          Container(
                            margin: const EdgeInsets.only(left: 15,right: 15,bottom: 30),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                border: Border.all(color: Theme.of(context).hintColor.withOpacity(0.3),width: 1),
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: InkWell(
                              onTap: () async {
                                List<SymptompModel> m=await Navigator.push(context, MaterialPageRoute(builder: (context) =>SymptompSearch(model.arrAllSymptomp)));
                                if(m!=null){
                                  model.arrSelectedSymptomp.clear();
                                  model.setSymptomp(m);
                                }
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ImageViewSize('assets/icon/symptoms.png',35,35),
                                  Container(height: 45,width: 1,color: Theme.of(context).hintColor ,margin: const EdgeInsets.only(left: 10,right: 10),),
                                  Expanded(child: Wrap(
                                    children: model.arrSelectedSymptomp.map((SymptompModel value){
                                      if(value.name=='Add'){
                                        return Container(
                                          height: 40,
                                          width: 50,
                                          margin: const EdgeInsets.only(left: 0),
                                          decoration: BoxDecoration(
                                            color: background,
                                          ),
                                          child: Stack(
                                            children: <Widget>[
                                              Container(
                                                height: 40,
                                                width: 50,
                                                child:  Icon(Icons.add,size: 30,),
                                              ),
                                              Container(
                                                  height: 40,
                                                  width: 50,
                                                  child: DashedRect(color: Theme.of(context).hintColor, strokeWidth: 2.0, gap: 3.0,)),

                                            ],
                                          ),

                                        );
                                      }else{
                                        return Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(3)),
                                            border: Border.all(color: background,width: 1.0),
                                          ),
                                          child: TextView(value.name,size: 10, weight: FontWeight.w500,),
                                        );
                                      }
                                    }).toList(),
                                  ))
                                ],
                              ),
                            ),

                          ),

                          TextView('Medicine',size: 17,weight: FontWeight.w500,colors: Theme.of(context).hintColor,
                            mergin: const EdgeInsets.only(left: 15,bottom: 8,top: 0),),
                          Container(
                            margin: const EdgeInsets.only(left: 15,right: 15,bottom: 30),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                border: Border.all(color: Theme.of(context).hintColor.withOpacity(0.3),width: 1),
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: InkWell(
                              onTap: () async {
                                List<MedicineModel> m=await Navigator.push(context, MaterialPageRoute(builder: (context) =>MedicineSearch(model.arrSelectedMedicine)));
                                if(m!=null){
                                  model.setMedician(m);
                                }

                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ImageViewSize('assets/icon/medicine.png',35,35),
                                  Container(height: 45,width: 1,color: Theme.of(context).hintColor ,margin: const EdgeInsets.only(left: 10,right: 10),),

                                  Expanded(child: Wrap(
                                    children: model.arrSelectedMedicine.map((MedicineModel value){
                                      if(value.name=='Add'){
                                        return Container(
                                          height: 40,
                                          width: 50,
                                          margin: const EdgeInsets.only(left: 0),
                                          decoration: BoxDecoration(
                                            color: background,
                                          ),
                                          child: Stack(
                                            children: <Widget>[
                                              Container(
                                                height: 40,
                                                width: 50,
                                                child:  Icon(Icons.add,size: 30,),
                                              ),
                                              Container(
                                                  height: 40,
                                                  width: 50,
                                                  child: DashedRect(color: Theme.of(context).hintColor, strokeWidth: 2.0, gap: 3.0,)),

                                            ],
                                          ),

                                        );
                                      }else{
                                        return Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(3)),
                                            border: Border.all(color: background,width: 1.0),
                                          ),
                                          child: TextView(value.name,size: 10, weight: FontWeight.w500,),
                                        );
                                      }
                                    }).toList(),
                                  ))

                                ],
                              ),
                            ),

                          ),

                          TextView('Diagnosis',size: 17,weight: FontWeight.w500,colors: Theme.of(context).hintColor,
                            mergin: const EdgeInsets.only(left: 15,bottom: 8,top: 0),),
                          Container(
                            margin: const EdgeInsets.only(left: 15,right: 15,bottom: 30),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                border: Border.all(color: Theme.of(context).hintColor.withOpacity(0.3),width: 1),
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: InkWell(
                              onTap: () async {
                                List<DiagnosisModel> m=await Navigator.push(context, MaterialPageRoute(builder: (context) =>DiagnosisSearch(model.arrAllDiagnosis)));
                                if(m!=null){
                                  model.arrSelectedDianosis.clear();
                                  model.setDiagnosis(m);
                                }
//
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ImageViewSize('assets/icon/diagnoses.png',35,35),
                                  Container(height: 45,width: 1,color: Theme.of(context).hintColor ,margin: const EdgeInsets.only(left: 10,right: 10),),

                                  Expanded(child: Wrap(
                                    children: model.arrSelectedDianosis.map((DiagnosisModel value){
                                      if(value.diagnosesName=='Add'){
                                        return Container(
                                          height: 40,
                                          width: 50,
                                          margin: const EdgeInsets.only(left: 0),
                                          decoration: BoxDecoration(
                                            color: background,
                                          ),
                                          child: Stack(
                                            children: <Widget>[
                                              Container(
                                                height: 40,
                                                width: 50,
                                                child:  Icon(Icons.add,size: 30,),
                                              ),
                                              Container(
                                                  height: 40,
                                                  width: 50,
                                                  child: DashedRect(color: Theme.of(context).hintColor, strokeWidth: 2.0, gap: 3.0,)),

                                            ],
                                          ),

                                        );
                                      }else{
                                        return Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(3)),
                                            border: Border.all(color: background,width: 1.0),
                                          ),
                                          child: TextView(value.diagnosesName,size: 10, weight: FontWeight.w500,),
                                        );
                                      }
                                    }).toList(),
                                  ))
                                ],
                              ),
                            ),

                          ),


                          TextView('Investigation',size: 17,weight: FontWeight.w500,colors: Theme.of(context).hintColor,
                            mergin: const EdgeInsets.only(left: 15,bottom: 8,top: 0),),
                          Container(
                            margin: const EdgeInsets.only(left: 15,right: 15,bottom: 30),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                border: Border.all(color: Theme.of(context).hintColor.withOpacity(0.3),width: 1),
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: InkWell(
                              onTap:() async {
                                List<InvestigationModel> m=await Navigator.push(context, MaterialPageRoute(builder: (context) =>InvestigationScreen(model.arrInvestigation)));
                                if(m!=null){
                                  model.setInvestigation(m);
                                }
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                  ImageViewSize('assets/icon/investigation.png',35,35),
                                  Container(height: 45,width: 1,color: Theme.of(context).hintColor ,margin: const EdgeInsets.only(left: 10,right: 10),),
                                  Expanded(child: Wrap(
                                    children: model.arrInvestigation.map((InvestigationModel value){
                                      if(value.itemName=='Add'){
                                        return Container(
                                          height: 40,
                                          width: 50,
                                          margin: const EdgeInsets.only(left: 0),
                                          decoration: BoxDecoration(
                                            color: background,
                                          ),
                                          child: Stack(
                                            children: <Widget>[
                                              Container(
                                                height: 40,
                                                width: 50,
                                                child:  Icon(Icons.add,size: 30,),
                                              ),
                                              Container(
                                                  height: 40,
                                                  width: 50,
                                                  child: DashedRect(color: Theme.of(context).hintColor, strokeWidth: 2.0, gap: 3.0,)),

                                            ],
                                          ),

                                        );
                                      }else{
                                        return Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(3)),
                                            border: Border.all(color: background,width: 1.0),
                                          ),
                                          child: TextView(value.itemName,size: 10, weight: FontWeight.w500,),
                                        );
                                      }
                                    }).toList(),
                                  ))
                                ],
                              ),
                            ),

                          ),

                          /*  TextView('Refers',size: 17,weight: FontWeight.w500,colors: Theme.of(context).hintColor,
                        mergin: const EdgeInsets.only(left: 15,bottom: 8,top: 30),),
                      Container(
                        margin: const EdgeInsets.only(left: 15,right: 15,bottom: 30),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            border: Border.all(color: Theme.of(context).hintColor,width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: InkWell(
                          onTap:(){

                          },
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.attach_file,size: 30,color: Theme.of(context).hintColor,),
                              Container(height: 45,width: 1,color: Theme.of(context).hintColor ,margin: const EdgeInsets.only(left: 10,right: 20),),
                              Container(
                                height: 40,
                                width: 50,
                                margin: const EdgeInsets.only(left: 15),
                                decoration: BoxDecoration(
                                  color: background,
                                ),
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      height: 40,
                                      width: 50,
                                      child:  Icon(Icons.add,size: 30,),
                                    ),
                                    Container(
                                        height: 40,
                                        width: 50,
                                        child: DashedRect(color: Theme.of(context).hintColor, strokeWidth: 2.0, gap: 3.0,)),

                                  ],
                                ),

                              )
                            ],
                          ),
                        ),

                      ),*/


                          TextView('Next visit Date',size: 14,weight: FontWeight.w500, colors: Theme.of(context).hintColor,
                            mergin: const EdgeInsets.only(top: 5,bottom: 5,left: 15),),


                          Container(
                            margin: const EdgeInsets.only(top: 5,bottom: 5,left: 0),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(left:10),
                                  child: InkWell(
                                    onTap: (){
                                      model.dayPick(1);
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                      elevation: 2,
                                      child:Container(
                                        decoration: BoxDecoration(
                                            color: model.daySelected==1?Colors.white:background,
                                            border:model.daySelected==1?Border.all(color:Colors.grey,width: 1):null,
                                            borderRadius: BorderRadius.all(Radius.circular(10))
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            TextView('After',size: 11,colors: Theme.of(context).hintColor.withOpacity(0.7),weight: FontWeight.w500,
                                              mergin: const EdgeInsets.only(top:5,bottom: 5,left: 10,right: 10),),
                                            TextView('02',size: 15,weight: FontWeight.w700,),
                                            TextView('Days',size: 11,colors: Theme.of(context).hintColor.withOpacity(0.7),weight: FontWeight.w500,
                                              mergin: const EdgeInsets.all(5),),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child:  InkWell(
                                    onTap: (){
                                      model.dayPick(2);
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                      elevation: 2,
                                      child:Container(
                                        decoration: BoxDecoration(
                                            color: model.daySelected==2?Colors.white:background,
                                            border:model.daySelected==2?Border.all(color:Colors.grey,width: 1):null,
                                            borderRadius: BorderRadius.all(Radius.circular(10))
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            TextView('After',size: 11,colors: Theme.of(context).hintColor.withOpacity(0.7),weight: FontWeight.w500,
                                              mergin: const EdgeInsets.only(top:5,bottom: 5,left: 10,right: 10),),
                                            TextView('03',size: 15,weight: FontWeight.w700,),
                                            TextView('Days',size: 12,colors: Theme.of(context).hintColor.withOpacity(0.7),weight: FontWeight.w500,
                                              mergin: const EdgeInsets.all(5),),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: InkWell(
                                    onTap: (){
                                      model.dayPick(3);
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                      elevation: 2,
                                      child:Container(
                                        decoration: BoxDecoration(
                                            color: model.daySelected==3?Colors.white:background,
                                            border:model.daySelected==3?Border.all(color:Colors.grey,width: 1):null,
                                            borderRadius: BorderRadius.all(Radius.circular(10))
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            TextView('After',size: 11,colors: Theme.of(context).hintColor.withOpacity(0.7),weight: FontWeight.w500,
                                              mergin: const EdgeInsets.only(top:5,bottom: 5,left: 10,right: 10),),
                                            TextView('05',size: 15,weight: FontWeight.w700,),
                                            TextView('Days',size: 12,colors: Theme.of(context).hintColor.withOpacity(0.7),weight: FontWeight.w500,
                                              mergin: const EdgeInsets.all(5),),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child:  InkWell(
                                    onTap: (){
                                      model.dayPick(4);
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                      elevation: 2,
                                      child:Container(
                                        decoration: BoxDecoration(
                                            color: model.daySelected==4?Colors.white:background,
                                            border:model.daySelected==4?Border.all(color:Colors.grey,width: 1):null,
                                            borderRadius: BorderRadius.all(Radius.circular(10))
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            TextView('After',size: 11,colors: Theme.of(context).hintColor.withOpacity(0.7),weight: FontWeight.w500,
                                              mergin: const EdgeInsets.only(top:5,bottom: 5,left: 10,right: 10),),
                                            TextView('07',size: 15,weight: FontWeight.w700,),
                                            TextView('Days',size: 12,colors: Theme.of(context).hintColor.withOpacity(0.7),weight: FontWeight.w500,
                                              mergin: const EdgeInsets.all(5),),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child:  InkWell(
                                    onTap: (){
                                      model.dayPick(5);
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                      elevation: 2,
                                      child:Container(
                                        decoration: BoxDecoration(
                                            color: model.daySelected==5?Colors.white:background,
                                            border:model.daySelected==5?Border.all(color:Colors.grey,width: 1):null,
                                            borderRadius: BorderRadius.all(Radius.circular(10))
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            TextView('After',size: 11,colors: Theme.of(context).hintColor.withOpacity(0.7),weight: FontWeight.w500,
                                              mergin: const EdgeInsets.only(top:5,bottom: 5,left: 10,right: 10),),
                                            TextView('02',size: 15,weight: FontWeight.w700,),
                                            TextView('Weeks',size: 12,colors: Theme.of(context).hintColor.withOpacity(0.7),weight: FontWeight.w500,
                                              mergin: const EdgeInsets.all(5),),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: InkWell(
                                    onTap: (){
                                      model.dayPick(6);
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                      elevation: 2,
                                      child:Container(
                                        decoration: BoxDecoration(
                                            color: model.daySelected==6?Colors.white:background,
                                            border:model.daySelected==6?Border.all(color:Colors.grey,width: 1):null,
                                            borderRadius: BorderRadius.all(Radius.circular(10))
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            TextView('After',size: 11,colors: Theme.of(context).hintColor.withOpacity(0.7),weight: FontWeight.w500,
                                              mergin: const EdgeInsets.only(top:5,bottom: 5,left: 10,right: 10),),
                                            TextView('01',size: 15,weight: FontWeight.w700,),
                                            TextView('Month',size: 11,colors: Theme.of(context).hintColor.withOpacity(0.7),weight: FontWeight.w500,
                                              mergin: const EdgeInsets.all(5),),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),




                          TextView('Notes',size: 14,weight: FontWeight.w500, colors: Theme.of(context).hintColor,
                            mergin: const EdgeInsets.only(top: 20,bottom: 5,left: 15),),

                          Container(
                            margin: const EdgeInsets.only(right: 15,bottom: 20,left: 15),

                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              controller: TextEditingController(text: model.notes??''),
                              maxLines: 3,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: const EdgeInsets.only(left: 10,right: 10,top: 7,bottom: 7)
                              ),
                              onChanged: (v){
                                model.setNotes(v);
                              },
                              style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 15,fontWeight: FontWeight.w400),
                            ),
                          ),



                          Container(
                            child: model.isLoad?Center(
                              child: Container(
                                padding: const EdgeInsets.only(top: 25,bottom: 25),
                                child: CircularProgressIndicator(),
                              ),
                            ):MaterialButton(
                              onPressed:(){
                                validation(context,model);
                              },
                              color: Theme.of(context).dividerColor,
                              child: TextView('SUBMIT',weight: FontWeight.w500,colors:Colors.white,size:20,padding: const EdgeInsets.only(top: 10,bottom: 10),),
                            ),
                          )

                        ],
                      )),




                    ],
                  ),

                  Positioned(
                    bottom: 50,
                    right: 10,
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius:  BorderRadius.all(Radius.circular(25))),
                      elevation: 5,
                      child: InkWell(
                        onTap: () async {
                           var value=await Navigator.push(context, MaterialPageRoute(builder: (context) =>CancelAppointmentPop(appointmentModel.id,model.cancelList)));
                           if(value!=null){
                             Navigator.pop(context,1);
                           }
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            color: Colors.white
                          ),
                          child: Center(
                            child: ImageViewSize('assets/icon/erroricon.png',38,38),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
         }),
         )),
    ),
       );
  }

    validation(context,PatientAppointmentProvider model) {
      if (model.arrSelectedSymptomp.length == 1 && model.arrSelectedSymptomp[0].name == 'Add') {
        globalKey.currentState.showSnackBar(SnackBar(
          content: Text("Symptomps is required"),
        ));
      } else {
        Widget cancelButton = FlatButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.pop(context);
          },
        );
        Widget continueButton = FlatButton(
          child: Text("Continue"),
          onPressed: () {
            model.generatPdf(
                appointmentModel.appoinmentReason, appointmentModel.id,
                appointmentModel.customId,appointmentModel.patientId, globalKey);
            Navigator.pop(context);
          },
        );

        // set up the AlertDialog
        AlertDialog alert = AlertDialog(
          title: Text("Prescription Generate"),
          content: Text("are you sure you want to submit Prescription?"),
          actions: [
            cancelButton,
            continueButton,
          ],
        );

        // show the dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      }
    }
    /*validation(context,PatientAppointmentProvider model){
       if(model.bpSystolic==null){
         Scaffold.of(context).showSnackBar(SnackBar(
           content: Text("BP Level is required"),
         ));
       }else  if(model.ppReading==null){
         Scaffold.of(context).showSnackBar(SnackBar(
           content: Text("Sugar Level is required"),
         ));
       }else  if(model.kilo==null){
         Scaffold.of(context).showSnackBar(SnackBar(
           content: Text("Wight is required"),
         ));
       }else  if(model.feed==null){
         Scaffold.of(context).showSnackBar(SnackBar(
           content: Text("Height is required"),
         ));
       }else if(model.arrAllSymptomp.length==1 && model.arrAllSymptomp[0].name=='Add'){
         Scaffold.of(context).showSnackBar(SnackBar(
           content: Text("Symptomps is required"),
         ));
       }else if(model.arrSelectedMedicine.length==1 && model.arrSelectedMedicine[0].name=='Add'){
         Scaffold.of(context).showSnackBar(SnackBar(
           content: Text("Medicine is required"),
         ));
       }else if(model.arrSelectedDianosis.length==1 && model.arrSelectedDianosis[0].diagnosesName=='Add'){
         Scaffold.of(context).showSnackBar(SnackBar(
           content: Text("Diagnoses is required"),
         ));
       }else if(model.arrInvestigation.length==1 && model.arrInvestigation[0].itemName=='Add'){
         Scaffold.of(context).showSnackBar(SnackBar(
           content: Text("Investigation is required"),
         ));
       }else if(model.daySelected==-1){
         Scaffold.of(context).showSnackBar(SnackBar(
           content: Text("Next visit is required"),
         ));
       }else{
         // set up the buttons
         Widget cancelButton = FlatButton(
           child: Text("Cancel"),
           onPressed:  () {
             Navigator.pop(context);
           },
         );
         Widget continueButton = FlatButton(
           child: Text("Continue"),
           onPressed:  () {
             model.generatPdf(appointmentModel.appoinmentReason,appointmentModel.id,appointmentModel.customId,globalKey);
           },
         );

         // set up the AlertDialog
         AlertDialog alert = AlertDialog(
           title: Text("Prescription Generate"),
           content: Text("are you sure you want to submit Prescription?"),
           actions: [
             cancelButton,
             continueButton,
           ],
         );

         // show the dialog
         showDialog(
           context: context,
           builder: (BuildContext context) {
             return alert;
           },
         );

       }
    }*/
}