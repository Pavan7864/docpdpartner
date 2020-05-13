import 'package:docpdpartner/adapter/prescription.dart';
import 'package:docpdpartner/custom_ui/imageView/CircleImageView.dart';
import 'package:docpdpartner/custom_ui/imageView/ImageViewSize.dart';
import 'package:docpdpartner/custom_ui/imageView/TextView.dart';
import 'package:docpdpartner/model/appointment_model.dart';
import 'package:docpdpartner/page/dialog/inner_web_page.dart';
import 'package:docpdpartner/provider/patient_provider.dart';
import 'package:docpdpartner/utils/AppUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class PatientDetails extends StatefulWidget{


   @override
   _PatientDetails createState()=>_PatientDetails();
}

class _PatientDetails extends State<PatientDetails>{
  final globalKey = GlobalKey<ScaffoldState>();
  PatientProvider app;

    @override
  Widget build(BuildContext context) {
      final  Map<String, Object> data = ModalRoute.of(context).settings.arguments;
     var appointmentModel=AppointmentModel.fromJSON(data);
      app=PatientProvider(appointmentModel,context,globalKey);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      key: globalKey,
      body:SafeArea(
          top: true,
          child: ChangeNotifierProvider<PatientProvider>(
             create: (context)=>app,
            child: Consumer(builder: (context,PatientProvider model,child){
              return Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: <Widget>[
                        IconButton(icon: Icon(Icons.arrow_back,size: 25,), onPressed: ()=>Navigator.of(context).pop()),
                        Expanded(
                          child: TextView(
                            'Patient Details',align: TextAlign.center,colors: Theme.of(context).primaryColor,size: 20,
                          ),

                        ),


                      ],
                    ),
                  ),
                  Expanded(
                    child:model.isLoaded?Center(
                       child: CircularProgressIndicator(),
                    ): ListView(
                      shrinkWrap: true,
                      children: <Widget>[

                        Container(
                          color: Color(0xfff1f1f1),
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(top: 30,bottom: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              InkWell(
                                  onTap:(){
                                    Navigator.pushNamed(context, '/ProfileMenu');
                                  },
                                  child: CircleImageView(model.appointmentModel.userPic,80)
                              ),
                              TextView(model.appointmentModel.userName,size: 16,align: TextAlign.center,weight: FontWeight.w500,
                                colors: Theme.of(context).primaryColor, mergin: const EdgeInsets.only(top: 3,bottom: 1),),
                              TextView(model.arrBooking.length==0?'':AppUtils.adddob(model.arrBooking[0].gender, model.arrBooking[0].dob, '/', ''),size: 12,align: TextAlign.center,
                                weight: FontWeight.w400,colors: Theme.of(context).hintColor, mergin: const EdgeInsets.only(top: 1,bottom: 1),),
                              TextView('${model.arrBooking.length} Construction',size: 12,align: TextAlign.center,weight: FontWeight.w400,colors: Theme.of(context).hintColor,)
                            ],
                          ),
                        ),


                        TextView('Medical Summary',size: 16,weight: FontWeight.w500, colors: Theme.of(context).primaryColor,
                          mergin: const EdgeInsets.only(top: 20,bottom: 3,left: 15),),
                        TextView(model.arrBooking.length==0?'':model.arrBooking[0].madicalSummary??'',size: 16, weight: FontWeight.w400,colors: Theme.of(context).hintColor,
                          mergin: const EdgeInsets.only(top: 1,bottom: 1,left: 15,right: 15),),

                        TextView('Vitals',size: 14,weight: FontWeight.w400, colors: Theme.of(context).hintColor,
                          mergin: const EdgeInsets.only(top: 20,bottom: 3,left: 15),),

                        Row(
                          children: <Widget>[
                            Expanded(child: Container(
                              margin: const EdgeInsets.only(left: 15,right: 5),
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                                elevation: 5,
                                child: Column(
                                  children: <Widget>[
                                    ImageViewSize('assets/icon/wight_icon.png',50,50,mergin: const EdgeInsets.only(top: 10,bottom: 5),),
                                    TextView(model.vitalData.length==0?'':'${model.vitalData[0].weight??''} KG',size: 16,weight: FontWeight.w500, colors: Theme.of(context).primaryColor,
                                      mergin: const EdgeInsets.only(top: 10,bottom: 5),),
                                    TextView('Wight',size: 12, weight: FontWeight.w400,colors: Theme.of(context).hintColor,
                                      mergin: const EdgeInsets.only(top: 1,bottom: 15),),
                                  ],
                                ),
                              ),
                            )),
                            Expanded(child: Container(
                              margin: const EdgeInsets.only(left: 5,right: 5),
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                                elevation: 5,
                                child: Column(
                                  children: <Widget>[
                                    ImageViewSize('assets/icon/hight_icon.png',50,50,mergin: const EdgeInsets.only(top: 10,bottom: 5),),
                                    TextView(model.vitalData.length==0?'':'${model.vitalData[0].height??''} ',size: 16,weight: FontWeight.w500, colors: Theme.of(context).primaryColor,
                                      mergin: const EdgeInsets.only(top: 10,bottom: 5),),
                                    TextView('Hight',size: 12, weight: FontWeight.w400,colors: Theme.of(context).hintColor,
                                      mergin: const EdgeInsets.only(top: 1,bottom: 15),),
                                  ],
                                ),
                              ),
                            )),
                            Expanded(child: Container(
                              margin: const EdgeInsets.only(left: 5,right: 15),
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                                elevation: 5,
                                child: Column(
                                  children: <Widget>[
                                    ImageViewSize('assets/icon/bloodgroup.png',50,50,mergin: const EdgeInsets.only(top: 10,bottom: 5),),
                                    TextView('',size: 16,weight: FontWeight.w500, colors: Theme.of(context).primaryColor,
                                      mergin: const EdgeInsets.only(top: 10,bottom: 5),),
                                    TextView('Blood Group',size: 12, weight: FontWeight.w400,colors: Theme.of(context).hintColor,
                                      mergin: const EdgeInsets.only(top: 1,bottom: 15),),
                                  ],
                                ),
                              ),
                            )),
                          ],
                        ),

                        TextView('Key Profile',size: 14,weight: FontWeight.w400, colors: Theme.of(context).hintColor,
                          mergin: const EdgeInsets.only(top: 30,bottom: 3,left: 15),),

                        Row(
                          children: <Widget>[
                            Expanded(child: Container(
                              margin: const EdgeInsets.only(left: 15,right: 7),
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                                elevation: 5,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    ImageViewSize('assets/icon/bp_icon.png',50,50,mergin: const EdgeInsets.only(left: 10)),
                                    Expanded(child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        TextView(model.vitalData.length==0?'':AppUtils.add(model.vitalData[0].systolic, model.vitalData[0].diagonstic, '/', '') ,size: 12,weight: FontWeight.w500, colors: Theme.of(context).primaryColor,
                                          mergin: const EdgeInsets.only(top: 20,bottom: 5,left: 7),),
                                        TextView('BP Level',size: 10, weight: FontWeight.w400,colors: Theme.of(context).hintColor,
                                          mergin: const EdgeInsets.only(top: 1,bottom: 20,left: 7),),
                                      ],
                                    ))

                                  ],
                                ),
                              ),
                            )),

                            Expanded(child: Container(
                              margin: const EdgeInsets.only(left: 7,right: 15),
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                                elevation: 5,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    ImageViewSize('assets/icon/thyroid_iocn.png',50,50,mergin: const EdgeInsets.only(left: 10),),
                                    Expanded(child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        TextView(model.vitalData.length==0?'':model.vitalData[0].vThyriodRisk??'' ,size: 12,weight: FontWeight.w500, colors: Theme.of(context).primaryColor,
                                          mergin: const EdgeInsets.only(top: 20,bottom: 5,left: 7),),
                                        TextView('Thyroid Level',size: 10, weight: FontWeight.w400,colors: Theme.of(context).hintColor,
                                          mergin: const EdgeInsets.only(top: 1,bottom: 20,left: 7),),
                                      ],
                                    ))

                                  ],
                                ),
                              ),
                            )),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(child: Container(
                              margin: const EdgeInsets.only(left: 15,right: 7,top: 14),
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                                elevation: 5,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    ImageViewSize('assets/icon/dibtick_iocn.png',50,50,mergin: const EdgeInsets.only(left: 10)),
                                    Expanded(child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        TextView(model.vitalData.length==0?'':AppUtils.add(model.vitalData[0].ppRating, model.vitalData[0].fastingRating, '/', '') ,size: 12,weight: FontWeight.w500, colors: Theme.of(context).primaryColor,
                                          mergin: const EdgeInsets.only(top: 20,bottom: 5,left: 7),),
                                        TextView('Sugar Level',size: 10, weight: FontWeight.w400,colors: Theme.of(context).hintColor,
                                          mergin: const EdgeInsets.only(top: 1,bottom: 20,left: 7),),
                                      ],
                                    ))

                                  ],
                                ),
                              ),
                            )),

                            Expanded(child: Container(
                              margin: const EdgeInsets.only(left: 7,right: 15,top: 14),
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                                elevation: 5,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    ImageViewSize('assets/icon/total_c.png',50,50,mergin: const EdgeInsets.only(left: 10),),
                                    Expanded(child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        TextView(model.vitalData.length==0?'':AppUtils.addT(model.vitalData[0].t3, model.vitalData[0].t4, model.vitalData[0].tsh,'/'),size: 12,weight: FontWeight.w500, colors: Theme.of(context).primaryColor,
                                          mergin: const EdgeInsets.only(top: 20,bottom: 5,left: 7),),
                                        TextView('Total Cholesterol',size: 10, weight: FontWeight.w400,colors: Theme.of(context).hintColor,
                                          mergin: const EdgeInsets.only(top: 1,bottom: 20,left: 7),),
                                      ],
                                    ))

                                  ],
                                ),
                              ),
                            )),
                          ],
                        ),

                        TextView('Prescription History',size: 14,weight: FontWeight.w400, colors: Theme.of(context).hintColor,
                          mergin: const EdgeInsets.only(top: 20,bottom: 5,left: 15),),


                        ListView.builder(
                            itemCount: model.arrBooking.length,
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context,index){
                             return InkWell(
                                  onTap: (){
                                    if(!AppUtils.isEmpty(model.arrBooking[index].pdfurl))
                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>InnerWebPage(model.arrBooking[index].pdfurl)));

                                  },
                                  child: PrescriptionAdapter(model.arrBooking[index])
                              );

                            })




                      ],
                    ),
                  ),




                ],
              );
            },),
          )
      ) ,
    );
  }

}