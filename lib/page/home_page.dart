import 'package:docpdpartner/custom_ui/imageView/CircleImageView.dart';
import 'package:docpdpartner/custom_ui/imageView/TextView.dart';
import 'package:docpdpartner/page/dialog/success_pop.dart';
import 'package:docpdpartner/provider/home_provider.dart';
import 'package:docpdpartner/utils/AppUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'dialog/version-check.dart';

class HomePage extends StatefulWidget{

   @override
   _HomePage createState()=>_HomePage();
}

class _HomePage extends State<HomePage>{

  HomeProvider app;

    @override
  void initState() {
    super.initState();
    _configureSelectNotificationSubject();
    }

    @override
  Widget build(BuildContext context) {
      versionCheck(context);
      app=HomeProvider(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body:SafeArea(
          top: false,
          child: ChangeNotifierProvider<HomeProvider>(
             create: (context)=>app,
            child: Consumer(builder: (context,HomeProvider model,child){
              return Column(
                children: <Widget>[
                  Container(
                    color: Theme.of(context).backgroundColor,
                    height: 80,
                    child: TextView('Dashboard',size: 22,align: TextAlign.center,colors: Theme.of(context).primaryColor,
                    mergin: const EdgeInsets.only(top: 40),),
                    margin: const EdgeInsets.only(bottom: 10),
                  ),
                  Container(
                     color: Color(0xfff1f1f1),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(top: 30,bottom: 30),
                    margin: const EdgeInsets.only(bottom: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                            onTap:() async {
                               var a =await Navigator.pushNamed(context, '/ProfileMenu');
                                model.refresh();
                            },
                            child: CircleImageView(model.doctor==null?'':model.doctor.Pic,90)
                        ),
                         TextView(model.doctor==null?'':model.doctor.LastName==null || model.doctor.FirstName==null?'':model.doctor.LastName==null?model.doctor.FirstName:model.doctor.FirstName+' '+model.doctor.LastName,size: 16,align: TextAlign.center,weight: FontWeight.w500,
                           colors: Theme.of(context).primaryColor, mergin: const EdgeInsets.only(top: 10,bottom: 1),),
                         TextView(model.doctor==null?'':model.doctor.HighesQualification??'',size: 12,align: TextAlign.center,
                           weight: FontWeight.w400,colors: Theme.of(context).hintColor, mergin: const EdgeInsets.only(top: 3,bottom: 3),),
                         TextView(model.doctor==null?'':AppUtils.fullMonthName(model.doctor.DocCreateddate),size: 12,align: TextAlign.center,weight: FontWeight.w400,colors: Theme.of(context).hintColor,)
                      ],
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () async {
                       var a=await Navigator.pushNamed(context, "/AppointmentScreen");
                         model.refresh();
                      },
                      child: Card(
                        elevation: 5,
                        child:Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: <Widget>[

                              TextView(model.doctor==null?'':model.doctor.T2DcallAssignmentToday??'',size: 35,align: TextAlign.center,
                                weight: FontWeight.w700,colors: Theme.of(context).primaryColor, mergin: const EdgeInsets.only(top: 15,bottom: 1),),
                              TextView('Appointment',size: 16,align: TextAlign.center,
                                weight: FontWeight.w600,colors: Theme.of(context).hintColor, mergin: const EdgeInsets.only(top: 3,bottom: 22),),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),


                  Container(
                    margin: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () async {
                        var a=await Navigator.pushNamed(context, "/HistoryContainer");
                         model.refresh();

                      },
                      child: Card(
                        elevation: 5,
                        child:Container(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: <Widget>[

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  TextView(model.doctor==null?'':model.doctor.MissedCallsMonthally=='null'?'0':model.doctor.MissedCallsMonthally??'',size: 24,align: TextAlign.center,
                                    weight: FontWeight.w700,colors: Colors.red, mergin: const EdgeInsets.only(top: 20,bottom: 1),),

                                  Container(
                                    height: 30,
                                    width: 1,
                                    margin: const EdgeInsets.only(left: 10,right: 10,top: 15),
                                    color: Theme.of(context).hintColor.withOpacity(0.7),
                                  ),
                                  TextView(model.doctor==null?'':model.doctor.T2DcallAssignmentMonthally??'',size: 24,align: TextAlign.center,
                                    weight: FontWeight.w700,colors: Theme.of(context).dividerColor, mergin: const EdgeInsets.only(top: 20,bottom: 1),),

                                  Container(
                                    height: 30,
                                    width: 1,
                                    margin: const EdgeInsets.only(left: 10,right: 10,top: 15),
                                    color: Theme.of(context).hintColor.withOpacity(0.7),
                                  ),
                                  TextView(model.doctor==null?'':model.doctor.TotalCallsMonthally??'',size: 24,align: TextAlign.center,
                                    weight: FontWeight.w700,colors: Colors.orange, mergin: const EdgeInsets.only(top: 20,bottom: 1),),

                                ],
                              ),

                             TextView('History',size: 16,align: TextAlign.center,
                                weight: FontWeight.w600,colors: Theme.of(context).primaryColor, mergin: const EdgeInsets.only(top: 5,bottom: 20),),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),


                ],
              );
            },),
          )
      ) ,
    );
  }


  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) async {

      //await Navigator.pushNamed(context, '/PatientOtherDetails',arguments: {"id" :payload});

    });
  }

}