import 'package:docpdpartner/custom_ui/imageView/CircleImageView.dart';
import 'package:docpdpartner/custom_ui/imageView/ImageViewSize.dart';
import 'package:docpdpartner/custom_ui/imageView/TextView.dart';
import 'package:docpdpartner/main.dart';
import 'package:docpdpartner/model/history_model.dart';
import 'package:docpdpartner/utils/AppUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CallHistoryAdapter extends StatelessWidget{
  final HistoryModel model;
  final int type;
  CallHistoryAdapter(this.model,this.type);

   @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 7,bottom: 3),
      child: Card(
        elevation: 5,
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
                      TextView(model.userName,line: 1,colors: Theme.of(context).primaryColor,size: 18,weight: FontWeight.w500,),
                      Container(
                        margin: const EdgeInsets.only(top: 5,bottom: 2),
                        child: Row(
                          children: <Widget>[

                            TextView(AppUtils.covertDate(model.bookingDate,AppUtils.appointmentDate,AppUtils.monthNameForamte)+' ${model.bookingTime}',align: TextAlign.start,colors: Theme.of(context).hintColor,size: 13,weight: FontWeight.w400,
                              mergin: const EdgeInsets.only(left: 0),
                            )
                          ],
                        ),
                      ),

                      TextView(
                         model.reason!=null?model.reason:model.serviceType!=null?model.serviceType:'',
                        align: TextAlign.start,
                        colors: Theme.of(context).hintColor,size: 13,weight: FontWeight.w400,
                        mergin: const EdgeInsets.only(top: 2),
                      )
                    ],
                  ),
                ),
              ),

              ImageViewSize(type==1?'assets/icon/missedcall.png':'assets/icon/pdf.png',type==1?25:40,type==1?25:40,mergin: const EdgeInsets.only(right: 10),)

            ],
          ),
        ),
      ),
    );
  }
}