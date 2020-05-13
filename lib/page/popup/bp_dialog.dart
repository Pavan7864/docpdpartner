import 'package:docpdpartner/custom_ui/imageView/CircleImageView.dart';
import 'package:docpdpartner/custom_ui/imageView/ImageViewSize.dart';
import 'package:docpdpartner/custom_ui/imageView/TextView.dart';
import 'package:docpdpartner/custom_ui/imageView/TextView.dart';
import 'package:docpdpartner/custom_ui/imageView/TextView.dart';
import 'package:docpdpartner/model/appointment_model.dart';
import 'package:docpdpartner/utils/AppUtils.dart';
import 'package:docpdpartner/utils/app_color.dart';
import 'package:flutter/material.dart';

class BPLevelDialog extends StatefulWidget{
  AppointmentModel appointmentModel;
  BPLevelDialog(this.appointmentModel);

     @override
   _BPLevelDialog createState()=>_BPLevelDialog();
}
class _BPLevelDialog extends State<BPLevelDialog>  {

  TextEditingController systoicController;
  TextEditingController diastolicController;

  bool errorbox1=false;
  bool errorbox2=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    systoicController=new TextEditingController(text: widget.appointmentModel.bpSystolic??'');
    diastolicController=new TextEditingController(text:  widget.appointmentModel.bpDiastolic??'');
  }

  @override
  Widget build(BuildContext context) {

//    final  Map<String, Object> data = ModalRoute.of(context).settings.arguments;
//    appointmentModel=AppointmentModel.fromJSON(data);




    return  Scaffold(
         resizeToAvoidBottomInset: false,
         resizeToAvoidBottomPadding: false,
         body:  SafeArea(
           top: true,
           child: Container(
             color: Colors.white,
             child: Column(
               children: <Widget>[

                 Container(
                   padding: const EdgeInsets.all(10),
                   child: Row(
                     children: <Widget>[
                       IconButton(icon: Icon(Icons.arrow_back,size: 25,), onPressed: ()=>Navigator.of(context).pop()),
                       Expanded(
                         child: TextView(
                           'Blood Presure',align: TextAlign.center,weight: FontWeight.w500,colors: Theme.of(context).primaryColor,size: 18,),

                       ),


                       Container(
                         width:40,
                       )

                     ],
                   ),
                 ),

                 Container(
                   margin: const EdgeInsets.only(top: 7,bottom: 3,left: 10,right: 10),
                   child: Card(
                     elevation: 5,
                     child: Container(
                       padding: const EdgeInsets.all(10),
                       child: InkWell(
                         onTap: (){
                           var map=widget.appointmentModel.toMap();
                           Navigator.pushNamed(context, '/PatientDetails',arguments: map);
                         },
                         child: Row(
                           children: <Widget>[
                             CircleImageView(widget.appointmentModel.userPic,60),
                             Expanded(
                               child: Container(
                                 margin: const EdgeInsets.only(left: 10,top: 7,bottom: 7),
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: <Widget>[
                                     TextView(widget.appointmentModel.userName,colors: Theme.of(context).primaryColor,size: 16,weight: FontWeight.w500,),
                                     Container(
                                       margin: const EdgeInsets.only(top: 5,bottom: 2),
                                       child: Row(
                                         children: <Widget>[

                                           TextView(AppUtils.covertDate(widget.appointmentModel.appoinmentDate,AppUtils.appointmentDate, AppUtils.appointment)
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

                 Expanded(child: Container(
                   margin: const EdgeInsets.all(10),
                   child:Align(
                     alignment: Alignment.topCenter,
                     child:  Card(
                       elevation: 5,
                       child: Container(
                         padding: const EdgeInsets.all(20),
                         child: Column(
                           children: <Widget>[

                             Container(
                               margin: const EdgeInsets.only(bottom: 5),
                               child: Row(
                                 children: <Widget>[
                                   Expanded(child: TextView('Blood Pressure',weight: FontWeight.w600,colors: Theme.of(context).primaryColor,size: 20,)),
                                   Icon(Icons.info_outline,size: 35,color: Theme.of(context).accentColor,)

                                 ],
                               ),
                             ),

                             Align(
                                 alignment: Alignment.topLeft,
                                 child: TextView('Your Blood Pressure Level',weight: FontWeight.w400,align: TextAlign.left,colors: Theme.of(context).hintColor,size: 17,)),

                             Container(
                               margin: const EdgeInsets.only(right: 15,top: 35,left: 15,bottom: 35),
                               child: Row(
                                 children: <Widget>[
                                   Expanded(child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: <Widget>[
                                       TextView('Systolic',size: 13,weight: FontWeight.w500,colors: Theme.of(context).hintColor
                                         ,mergin: const EdgeInsets.only(left: 2,bottom: 8),),
                                       InkWell(
                                         onTap: (){

                                         },
                                         child: TextField(
                                           controller: systoicController,
                                           scrollPadding: const EdgeInsets.all(0),
                                           decoration: InputDecoration(
                                               border: OutlineInputBorder(),
                                               labelText: '',
                                               contentPadding: const EdgeInsets.only(left: 10),
                                               errorText: errorbox1?'Is required':null

                                           ),
                                           maxLines: 1,
                                           keyboardType: TextInputType.number,
                                           textInputAction: TextInputAction.done,

                                         ),
                                       ),
                                     ],
                                   )),
                                   Container(width: 10,),
                                   Expanded(child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: <Widget>[
                                       TextView('Diastolic',size: 13,weight: FontWeight.w500,colors: Theme.of(context).hintColor
                                         ,mergin: const EdgeInsets.only(left: 2,bottom: 8),),
                                       TextField(
                                         controller: diastolicController,
                                         scrollPadding: const EdgeInsets.all(0),
                                         decoration: InputDecoration(
                                             border: OutlineInputBorder(),
                                             contentPadding: const EdgeInsets.only(left: 10),
                                             labelText: '',
                                             errorText:errorbox2?'Is required':null

                                         ),
                                         maxLines: 1,
                                         keyboardType: TextInputType.number,
                                         textInputAction: TextInputAction.done,

                                       ),
                                     ],
                                   )),


                                 ],
                               ),
                             ),


                             RaisedButton(
                               onPressed: validation,
                               color: background,
                               splashColor: Theme.of(context).backgroundColor,
                               child: TextView('Save',size: 18,colors: Theme.of(context).primaryColor,
                                 weight: FontWeight.w600,
                                 padding: const EdgeInsets.only(top: 15,bottom: 15,left: 45,right: 35),),
                             ),


                           ],
                         ),
                       ),
                     ),
                   ),
                 )),

                 Container(
                   height: 150,
                 )

               ],
             ),
           ),
         ),
      );
  }

  validation(){
    setState(() {
      errorbox2=false;
      errorbox1=false;
    });

    if(!AppUtils.isBigZero(systoicController.text.toString().trim())){
      setState(() {

        errorbox1=true;
      });
    }else if(!AppUtils.isBigZero(diastolicController.text.toString().trim())){
      setState(() {
        errorbox2=true;
      });

    }else{
      widget.appointmentModel.bpSystolic=systoicController.text.toString().trim();
      widget.appointmentModel.bpDiastolic=diastolicController.text.toString().trim();
      Navigator.pop(context,widget.appointmentModel);
    }
  }
}