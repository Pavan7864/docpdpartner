import 'package:docpdpartner/adapter/call_history.dart';
import 'package:docpdpartner/page/dialog/inner_web_page.dart';
import 'package:docpdpartner/provider/history_provider.dart';
import 'package:docpdpartner/utils/AppUtils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttemptedCallScreen extends StatefulWidget{

    @override
    _AttemptedCallScreen createState()=>_AttemptedCallScreen();
}
class _AttemptedCallScreen extends State<AttemptedCallScreen>{

  ScrollController controller;
  HistoryProvider _app;
  @override
  void initState() {
    super.initState();
    controller = new ScrollController()..addListener(_scrollListener);
  }
  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  _scrollListener() {
    if (controller.position.maxScrollExtent == controller.offset && _app!=null) {
       _app.getAttemptAppointment();
    }
  }

    @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context,HistoryProvider model,child){
      _app=model;
       return ListView.builder(
         controller: controller,
         itemCount: model.arrAttempted.length,
         itemBuilder: (context,index){
         return InkWell(
             onTap: (){
               if(!AppUtils.isEmpty(model.arrAttempted[index].pdfurl))
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>InnerWebPage(model.arrAttempted[index].pdfurl)));

             },
             child: CallHistoryAdapter( model.arrAttempted[index],2)
         );
       },  );
    }
    );
  }
}