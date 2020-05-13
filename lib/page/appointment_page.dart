import 'package:docpdpartner/adapter/appointment_adapter.dart';
import 'package:docpdpartner/custom_ui/imageView/CircleImageView.dart';
import 'package:docpdpartner/custom_ui/imageView/FullImageView.dart';
import 'package:docpdpartner/custom_ui/imageView/ImageViewSize.dart';
import 'package:docpdpartner/custom_ui/imageView/TextView.dart';
import 'package:docpdpartner/main.dart';
import 'package:docpdpartner/provider/appointment_provider.dart';
import 'package:docpdpartner/provider/login_provider.dart';
import 'package:docpdpartner/utils/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppointmentScreen extends StatefulWidget{

  @override
  _AppointmentScreen createState()=>_AppointmentScreen();
}
class _AppointmentScreen extends State<AppointmentScreen>{
   String mobile;

   GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: SafeArea(
            top: true,
          child: ChangeNotifierProvider<AppointmentProvider>(
            create: (context)=>AppointmentProvider(context),
            child: Consumer(builder: (context,AppointmentProvider model,child){

              return Column(

                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: <Widget>[
                        IconButton(icon: Icon(Icons.arrow_back,size: 25,), onPressed: ()=>Navigator.of(context).pop()),
                        Expanded(
                          child: TextView(
                            'Appointment',align: TextAlign.center,colors: Theme.of(context).primaryColor,size: 20,
                          ),

                        ),
                        Container(
                          width:40,
                        )

                      ],
                    ),
                  ),

                  Expanded(
                      child: Container(
                        color: background,
                        child: model.isLoaded?Center(
                          child: CircularProgressIndicator(),
                        ):ListView.builder(
                            itemCount: model.arrAppointment.length,
                            itemBuilder: (context,index){
                              return InkWell(
                                  onTap: () async {
                                    var map=model.arrAppointment[index].toMap();
                                    var isRemove=await Navigator.pushNamed(context, '/PatientOtherDetails', arguments: map);
                                    if(isRemove!=null){
                                       model.removeAt(index);
                                    }

                                  },
                                  child: AppointmentAdapter(model.arrAppointment[index])
                              );
                            }
                  ),
                      )
                  )

                ],
              );
            }),
          )

      ),

    );
  }
}