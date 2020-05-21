import 'package:docpdpartner/custom_ui/imageView/TextView.dart';
import 'package:docpdpartner/model/language_model.dart';
import 'package:docpdpartner/provider/laguage_provider.dart';
import 'package:docpdpartner/utils/ApiClient.dart';
import 'package:docpdpartner/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LanguageScreen extends StatefulWidget{
final  List<LanguageModel> arrSelected;
LanguageScreen(this.arrSelected);

   @override
   _LanguageScreen createState()=>_LanguageScreen();
}
class _LanguageScreen extends State<LanguageScreen>{



     @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LanguageProvider>(
      create: (context)=>LanguageProvider(widget.arrSelected),
      child: Consumer(builder: (context,LanguageProvider model,child){
        return Scaffold(
           body: SafeArea(
             top: true,
             bottom: true,
             // ignore: missing_return
             child: WillPopScope( onWillPop: (){
                 Navigator.pop(context,model.arrLanguage);
             },
               child: Column(
                 children: <Widget>[
                   Container(
                     padding: const EdgeInsets.all(10),
                     child: Row(
                       children: <Widget>[
                         IconButton(icon: Icon(Icons.arrow_back,size: 25,), onPressed: ()=> Navigator.pop(context,model.arrLanguage)),
                         Expanded(
                           child: TextView(
                             'My Language',align: TextAlign.center,colors: Theme.of(context).primaryColor,size: 20,mergin: const EdgeInsets.only(right: 25),
                           ),

                         ),


                       ],
                     ),
                   ),

                   Expanded(child: Container(
                     color: background,
                     child: ListView.builder(
                         itemCount: model.arrLanguage.length,
                         padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
                         itemBuilder: (context,index){
                           return InkWell(
                             onTap: (){
                               model.select(index);
                             },
                             child: Container(
                               margin: const EdgeInsets.only(bottom: 0),
                               child: Card(
                                 elevation: 2,
                                 color: model.arrLanguage[index].isSelected?Colors.white:background,
                                 child: Container(
                                   padding: const EdgeInsets.only(left: 10,right: 10,top:5,bottom:5),
                                   child: Row(
                                     children: <Widget>[

                                       Expanded(child: TextView(model.arrLanguage[index].name??'',weight: FontWeight.w400,size: 15,colors: Theme.of(context).primaryColor,mergin: const EdgeInsets.all(10),)),
                                       Container(
                                         height: 24,
                                         width: 24,
                                         decoration: BoxDecoration(
                                             color: model.arrLanguage[index].isSelected?Theme.of(context).dividerColor:null,
                                             border: Border.all(color: model.arrLanguage[index].isSelected?Theme.of(context).dividerColor:Colors.grey,width: 1),
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
           ),
        );
      },),
    );
  }


}