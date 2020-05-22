import 'package:docpdpartner/custom_ui/imageView/TextView.dart';
import 'package:docpdpartner/model/investigation_model.dart';
import 'package:docpdpartner/provider/investigation_provider.dart';
import 'package:docpdpartner/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RedologyScreen extends StatefulWidget{

    @override
    _RedologyScreen createState()=>_RedologyScreen();
}
class _RedologyScreen extends State<RedologyScreen>{

      @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context,InvestigationProvider model,child){
       return model.isLoadRdiology?Center(
         child: CircularProgressIndicator(),
       ): SingleChildScrollView(
        /* child: Container(
           color: background,
           child: Wrap(
             children: model.arrRdiologi.map((InvestigationModel value){
               return Container(
                 margin: const EdgeInsets.only(right: 7,bottom: 7),
                 child: InkWell(
                   onTap: (){
                     model.selectInvestigation(value,0);
                   },
                   child: Card(
                     color: value.isSelected?Colors.white:background,
                     elevation: 2,
                     child: Container(
                       decoration: BoxDecoration(
                           border: value.isSelected?Border.all(color: Theme.of(context).dividerColor.withOpacity(0.7),width: 1):null
                       ),
                       padding: const EdgeInsets.all(10),

                       child: TextView(value.itemName,weight: FontWeight.w500,size: 14,),
                     ),
                   ),
                 ),
               );
             }).toList(),
           ),
         ),*/
       );
    });
  }
}
