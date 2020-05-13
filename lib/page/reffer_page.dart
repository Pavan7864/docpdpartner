import 'dart:async';

import 'package:docpdpartner/custom_ui/imageView/TextView.dart';
import 'package:docpdpartner/model/reffer_model.dart';
import 'package:docpdpartner/provider/reffer_provider.dart';
import 'package:docpdpartner/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RefferScreen extends StatefulWidget{
//  RefferScreen(List<InvestigationModel> arrSelected);

//  List<InvestigationModel> arrSelected;

  @override
  _RefferScreen createState()=>_RefferScreen();
}
class _RefferScreen extends State<RefferScreen> with SingleTickerProviderStateMixin{

  Timer timer;
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController=new TabController(length: 2, vsync: this);
  }

     @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Theme.of(context).backgroundColor,
       body: SafeArea(
           child: ChangeNotifierProvider<ReferProvider>(
              create: (context)=>ReferProvider(context),
              child: Consumer(builder: (context,ReferProvider model,child){
                return Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          IconButton(icon: Icon(Icons.arrow_back,size: 25,), onPressed: ()=>Navigator.of(context).pop()),
                          Expanded(
                            child: TextView(
                              'Search & Add Investigation',align: TextAlign.center,colors: Theme.of(context).primaryColor,size: 20,
                            ),

                          ),

                        ],
                      ),
                    ),

                    Container(
                        color: background,
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: TextView('Available Doctors',weight: FontWeight.w500,size: 14,colors: Theme.of(context).hintColor,
                              mergin: const EdgeInsets.all(10),))),

                    Expanded(child:  model.isLoaded?Center(
                      child: CircularProgressIndicator(),
                    ): SingleChildScrollView(
                      child: Container(
                        color: background,
                        child: Wrap(
                          children: model.arrReffer.map((RefferModel value){
                            return Container(
                              margin: const EdgeInsets.only(right: 7,bottom: 7),
                              child: InkWell(
                                onTap: (){
//                                  model.selectInvestigation(value,0);
                                },
                                child: Card(
                                  color: value.isSelected?Colors.white:background,
                                  elevation: 2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: value.isSelected?Border.all(color: Theme.of(context).dividerColor.withOpacity(0.7),width: 1):null
                                    ),
                                    padding: const EdgeInsets.all(10),

                                    child: TextView(value.name,weight: FontWeight.w500,size: 14,),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ))


                  ],
                );
              }),
           )
       ),
    );
  }
}