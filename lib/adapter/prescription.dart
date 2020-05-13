import 'package:docpdpartner/custom_ui/imageView/CircleImageView.dart';
import 'package:docpdpartner/custom_ui/imageView/ImageViewSize.dart';
import 'package:docpdpartner/custom_ui/imageView/TextView.dart';
import 'package:docpdpartner/main.dart';
import 'package:docpdpartner/model/book_model.dart';
import 'package:docpdpartner/utils/AppUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrescriptionAdapter extends StatelessWidget{
  PrescriptionAdapter(this.model);
  BookingModel model;

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
              CircleImageView(model.userPic,70),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 10,top: 10,bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextView(model.userName,colors: Theme.of(context).primaryColor,size: 18,weight: FontWeight.w500,),
                      Container(
                        margin: const EdgeInsets.only(top: 5,bottom: 2),
                        child: Row(
                          children: <Widget>[

                            TextView(AppUtils.covertDate(model.appoinmentDate, AppUtils.appointmentDate, AppUtils.appointment),align: TextAlign.start,colors: Theme.of(context).hintColor,size: 13,weight: FontWeight.w400,
                              mergin: const EdgeInsets.only(left: 0),
                            )
                          ],
                        ),
                      ),

                      TextView(
                        model.appoinmentReason??'',
                        align: TextAlign.start,
                        colors: Theme.of(context).hintColor,size: 13,weight: FontWeight.w400,
                        mergin: const EdgeInsets.only(top: 2),
                      )
                    ],
                  ),
                ),
              ),

              ImageViewSize('assets/icon/pdf.png',30,30)

            ],
          ),
        ),
      ),
    );
  }
}