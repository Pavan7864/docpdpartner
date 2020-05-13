import 'dart:convert';

import 'package:docpdpartner/custom_ui/imageView/TextView.dart';
import 'package:docpdpartner/model/cancel_model.dart';
import 'package:docpdpartner/page/dialog/success_pop.dart';
import 'package:docpdpartner/provider/patient_appointment_provider.dart';
import 'package:docpdpartner/utils/ApiClient.dart';
import 'package:docpdpartner/utils/AppUtils.dart';
import 'package:docpdpartner/utils/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CancelAppointmentPop extends StatefulWidget{
List<CancelModel> cancelList;
String serviceid;

CancelAppointmentPop(this.serviceid,this.cancelList);

    @override
    _CancelAppointmentPop createState()=>_CancelAppointmentPop();
}

class _CancelAppointmentPop extends State<CancelAppointmentPop>{
  final globalKey = GlobalKey<ScaffoldState>();
  int selectedIndex=-1;
  bool isLoaded=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      body: SafeArea(
        top: true,
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.arrow_back,size: 25,), onPressed: (){
                    Navigator.pop(context);
                  }),
                  Expanded(
                    child: TextView(
                      'Appointment Status',align: TextAlign.center,colors: Theme.of(context).primaryColor,size: 20,),

                  ),

                  Container(
                    width: 40,
                  )

                ],
              ),
            ),
            Expanded(child: Container(
              color: background,
              child: ListView.builder(
                  itemCount: widget.cancelList.length,
                  padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
                  itemBuilder: (context,index){
                    return InkWell(
                      onTap: (){
                        setState(() {
                          selectedIndex=index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Card(
                          elevation: 2,
                          color: index==selectedIndex?Colors.white:background,
                          child: Container(
                            padding: const EdgeInsets.only(left: 10,right: 10,top:5,bottom:5),
                            child: Row(
                              children: <Widget>[

                                Expanded(child: TextView(widget.cancelList[index].cancelReason??'',weight: FontWeight.w400,size: 17,colors: Theme.of(context).primaryColor,mergin: const EdgeInsets.all(10),)),
                                Container(
                                  height: 24,
                                  width: 24,
                                  decoration: BoxDecoration(
                                      color: index==selectedIndex?Theme.of(context).dividerColor:null,
                                      border: Border.all(color: index==selectedIndex?Theme.of(context).dividerColor:Colors.grey,width: 1),
                                      borderRadius: BorderRadius.all(Radius.circular(12))
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            )),

          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        child: isLoaded?Center(child: CircularProgressIndicator()): RaisedButton(
          onPressed: (){
            if(selectedIndex==-1){
              globalKey.currentState.showSnackBar(SnackBar(
                content: Text("Select cancel reason..",style: TextStyle(color: Colors.red),),
              ));
            }else {

               cancelAppointment(context, widget.cancelList[selectedIndex].cancelReason);
            }
          },
          color: Colors.grey,
          splashColor: Colors.white,
          child: TextView("Submit Application Status",colors: Colors.black,size: 18,weight: FontWeight.w400,),
        ),
      ),
    );
  }

  cancelAppointment(BuildContext mContext,String cancelReason) async {

    setState(() {
      isLoaded=true;
    });

    var map={
      'ServiceID':widget.serviceid,
      'CancelReason':cancelReason,
    };
    try{

      String response=await ApiClient.post(ApiClient.paSetCancel, mContext,body: map,state: globalKey);
      if(!AppUtils.isEmpty(response)){
        var js=json.decode(response);
        if(js['Status']==1 || js['Status']=='1') {
          showDialog(
            barrierDismissible: false,
            context: mContext,
            builder: (BuildContext context) => SuccessPopUp(
                "Prescription Cancel\n Successfully"
            ),
          );
        }
      }

    }catch(_){
      print(_);
    }

   if(mounted){
     setState(() {
       isLoaded=false;
     });
   }

  }

}