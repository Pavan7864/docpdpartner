import 'package:docpdpartner/custom_ui/imageView/CircleImageView.dart';
import 'package:docpdpartner/custom_ui/imageView/ImageViewSize.dart';
import 'package:docpdpartner/custom_ui/imageView/TextView.dart';
import 'package:docpdpartner/main.dart';
import 'package:docpdpartner/model/appointment_model.dart';
import 'package:docpdpartner/utils/AppUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppointmentAdapter extends StatelessWidget{
  final AppointmentModel model;
  AppointmentAdapter(this.model);

   @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 7,bottom: 3,left: 10,right: 10),
      child: Card(
        child: Container(
           padding: const EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              CircleImageView(model.userPic,60),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 10,top: 10,bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextView(model.userName,colors: Theme.of(context).primaryColor,size: 18,weight: FontWeight.w500,),
                      Container(
                        margin: const EdgeInsets.only(top: 7,bottom: 3),
                        child: Row(
                          children: <Widget>[
                            ImageViewSize('assets/icon/history_icon.png',25,25,colors: Theme.of(context).accentColor,),
                            TextView(AppUtils.covertDate(model.appoinmentDate,AppUtils.appointmentDate, AppUtils.appointment),
                              align: TextAlign.start,colors: Theme.of(context).accentColor.withOpacity(0.7),size: 14,weight: FontWeight.w500,
                              mergin: const EdgeInsets.only(left: 5),
                            )
                          ],
                        ),
                      ),

                      model.appoinmentReason==null?Container():model.appoinmentReason.length==0?Container():TextView(
                        model.appoinmentReason,
                        align: TextAlign.start,
                        colors: Theme.of(context).hintColor,size: 14,weight: FontWeight.w600,
                        mergin: const EdgeInsets.only(top: 4,left: 5),
                      )
                    ],
                  ),
                ),
              ),

              Icon(Icons.arrow_forward_ios,size: 22,color: Theme.of(context).hintColor.withOpacity(0.5),)

            ],
          ),
        ),
      ),
    );
  }
}