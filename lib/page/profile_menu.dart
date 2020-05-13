import 'dart:io';

import 'package:docpdpartner/custom_ui/imageView/CircleImageView.dart';
import 'package:docpdpartner/custom_ui/imageView/FullImageView.dart';
import 'package:docpdpartner/custom_ui/imageView/ImageViewSize.dart';
import 'package:docpdpartner/custom_ui/imageView/TextView.dart';
import 'package:docpdpartner/main.dart';
import 'package:docpdpartner/page/dialog/version-check.dart';
import 'package:docpdpartner/provider/home_provider.dart';
import 'package:docpdpartner/provider/login_provider.dart';
import 'package:docpdpartner/provider/profile_provider.dart';
import 'package:docpdpartner/utils/AppUtils.dart';
import 'package:docpdpartner/utils/MyAppPrefrences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileMenu extends StatefulWidget{

  @override
  _ProfileMenu createState()=>_ProfileMenu();
}
class _ProfileMenu extends State<ProfileMenu>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
            top: true,
          child: ChangeNotifierProvider<ProfileProvider>(
            create: (context)=>ProfileProvider(context),
            child: Consumer(builder: (context,ProfileProvider model,child){

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                   Container(
                     padding: const EdgeInsets.all(10),
                     child: Row(
                       children: <Widget>[
                         IconButton(icon: Icon(Icons.arrow_back,size: 25,), onPressed: ()=>Navigator.of(context).pop()),
                         Expanded(
                           child: TextView(
                             'My Profile',align: TextAlign.center,colors: Theme.of(context).primaryColor,size: 20,
                           ),

                         ),
                         InkWell(
                           onTap: (){
                             Navigator.pushNamed(context, "/EditProfile");
                           },
                           child: Row(
                             children: <Widget>[
                               Icon(Icons.edit,size: 20,),
                               TextView(
                                 'Edit',align: TextAlign.center,colors: Theme.of(context).primaryColor,size: 12,mergin: const EdgeInsets.only(right: 10),
                               )
                             ],
                           ),
                         ),

                       ],
                     ),
                   ),


                  Expanded(child: ListView(
                    children: <Widget>[

                      Container(
                        color: Color(0xfff1f1f1),
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(top: 30,bottom: 30),
                        margin: const EdgeInsets.only(bottom: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircleImageView(model.doctor==null?'':model.doctor.Pic!=null?model.doctor.Pic:'https://image.freepik.com/free-photo/doctor-smiling-with-stethoscope_1154-36.jpg',120),
                            TextView(model.doctor==null?'':model.doctor.LastName==null || model.doctor.FirstName==null?'':model.doctor.LastName==null?model.doctor.FirstName:model.doctor.FirstName+' '+model.doctor.LastName,size: 16,align: TextAlign.center,weight: FontWeight.w500,
                              colors: Theme.of(context).primaryColor, mergin: const EdgeInsets.only(top: 3,bottom: 1),),
                            TextView(model.doctor==null?'':model.doctor.HighesQualification??'',size: 12,align: TextAlign.center,
                              weight: FontWeight.w400,colors: Theme.of(context).hintColor, mergin: const EdgeInsets.only(top: 1,bottom: 1),),
                            TextView(model.doctor==null?'':AppUtils.fullMonthName(model.doctor.DocCreateddate),size: 12,align: TextAlign.center,weight: FontWeight.w400,colors: Theme.of(context).hintColor,)
                          ],
                        ),
                      ),

                      Container(
                          padding: const EdgeInsets.only(left: 25,right: 25,top: 10,bottom: 10),
                          color: Theme.of(context).backgroundColor,
                          child: InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                ImageViewSize('assets/icon/dashboard.png',30,30,colors: Theme.of(context).hintColor,),
                                TextView(
                                  'DashBoard',align: TextAlign.center,colors: Theme.of(context).primaryColor,size: 16,weight: FontWeight.w500,
                                  mergin: const EdgeInsets.only(left: 15),
                                )
                              ],
                            ),
                          )
                      ),

                      Container(
                        color: Color(0xfff1f1f1),
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(top: 10,bottom: 10),
                        margin: const EdgeInsets.only(bottom: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            Container(
                                padding: const EdgeInsets.only(left: 25,right: 25,top: 10,bottom: 10),
                                child: InkWell(
                                  onTap: (){
                                    Navigator.pushNamed(context, "/AppointmentScreen");
                                  },
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      ImageViewSize('assets/icon/talk_todoctor.png',30,30,colors: Theme.of(context).hintColor,),
                                      TextView(
                                        'Appointment',align: TextAlign.center,colors: Theme.of(context).primaryColor,size: 16,weight: FontWeight.w500,
                                        mergin: const EdgeInsets.only(left: 15),
                                      )
                                    ],
                                  ),
                                )
                            ),


                            Container(
                                padding: const EdgeInsets.only(left: 25,right: 25,top: 10,bottom: 10),
                                child: InkWell(
                                  onTap: (){
                                    Navigator.pushNamed(context, "/HistoryContainer");


                                  },
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      ImageViewSize('assets/icon/file_icon.png',30,30,colors: Theme.of(context).hintColor,),
                                      TextView(
                                        'History',align: TextAlign.center,colors: Theme.of(context).primaryColor,size: 16,weight: FontWeight.w500,
                                        mergin: const EdgeInsets.only(left: 15),
                                      )
                                    ],
                                  ),
                                )
                            ),

                            Container(
                                padding: const EdgeInsets.only(left: 25,right: 25,top: 10,bottom: 10),
                                child: InkWell(
                                  onTap:(){
                                    Navigator.pushNamed(context, "/MyAvailability");
                                    },
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      ImageViewSize('assets/icon/history_icon.png',30,30,colors: Theme.of(context).hintColor,),
                                      TextView(
                                        'My Availability',align: TextAlign.center,colors: Theme.of(context).primaryColor,size: 16,weight: FontWeight.w500,
                                        mergin: const EdgeInsets.only(left: 15),
                                      )
                                    ],
                                  ),
                                )
                            ),


                          ],
                        ),
                      ),


                      Container(
                          padding: const EdgeInsets.only(left: 25,right: 25,top: 10,bottom: 10),
                          color: Theme.of(context).backgroundColor,
                          child: InkWell(
                            onTap:() async {
                              var url='https://www.docopd.com/contact-us';
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch';
                              }

                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                ImageViewSize('assets/icon/sport_iocn.png',30,30,colors: Theme.of(context).hintColor,),
                                TextView(
                                  'Contact Support',align: TextAlign.center,colors: Theme.of(context).primaryColor,size: 16,weight: FontWeight.w500,
                                  mergin: const EdgeInsets.only(left: 15),
                                )
                              ],
                            ),
                          )
                      ),

                      Container(
                          padding: const EdgeInsets.only(left: 25,right: 25,top: 10,bottom: 10),
                          color: Theme.of(context).backgroundColor,
                          child: InkWell(
                            onTap:() async {
                              var url='https://www.docopd.com/about-us';
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch';
                              }

                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                ImageViewSize('assets/icon/about.png',30,30,colors: Theme.of(context).hintColor,),
                                TextView(
                                  'About Us',align: TextAlign.center,colors: Theme.of(context).primaryColor,size: 16,weight: FontWeight.w500,
                                  mergin: const EdgeInsets.only(left: 15),
                                )
                              ],
                            ),
                          )
                      ),

                      Container(
                          padding: const EdgeInsets.only(left: 25,right: 25,top: 10,bottom: 10),
                          color: Theme.of(context).backgroundColor,
                          child: InkWell(
                            onTap: () async {
                              var url=Platform.isIOS?APP_STORE_URL:PLAY_STORE_URL;
                              if (await canLaunch(url)) {
                                 await launch(url);
                              } else {
                                 throw 'Could not launch';
                              }
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                ImageViewSize('assets/icon/staret_t_file_icon.png',30,30,colors: Theme.of(context).hintColor,),
                                TextView(
                                  'Feedback',align: TextAlign.center,colors: Theme.of(context).primaryColor,size: 16,weight: FontWeight.w500,
                                  mergin: const EdgeInsets.only(left: 15),
                                )
                              ],
                            ),
                          )
                      ),

                      Container(
                          padding: const EdgeInsets.only(left: 25,right: 25,top: 10,bottom: 10),
                          color: Color(0xfff1f1f1),
                          child: InkWell(
                            onTap: (){
                              MyAppPrefrences.clearLoginData();
                              Navigator.pushNamedAndRemoveUntil(context, '/NamasteScreen', (Route<dynamic> route) => false);
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                ImageViewSize('assets/icon/logout_icon.png',30,30,colors: Theme.of(context).hintColor,),
                                TextView(
                                  'Logout',align: TextAlign.center,colors: Theme.of(context).primaryColor,size: 16,weight: FontWeight.w500,
                                  mergin: const EdgeInsets.only(left: 15),
                                )
                              ],
                            ),
                          )
                      ),


                    ],
                  ))


                ],
              );
            }),
          )

      ),
      bottomNavigationBar: Container(
        height: 50,
        child:  TextView(
          'Version: 3.0.0',align: TextAlign.center,colors: Theme.of(context).hintColor.withOpacity(0.7),size: 12,weight: FontWeight.w400,
          mergin: const EdgeInsets.only(left: 15),
        ),
      ),
    );
  }
}