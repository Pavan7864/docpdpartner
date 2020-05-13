import 'package:docpdpartner/custom_ui/imageView/TextView.dart';
import 'package:docpdpartner/page/attempt_call_page.dart';
import 'package:docpdpartner/page/missed_call_page.dart';
import 'package:docpdpartner/provider/history_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryContainer extends StatefulWidget{

  @override
  _HistoryContainer createState()=>_HistoryContainer();
}
class _HistoryContainer extends State<HistoryContainer> with SingleTickerProviderStateMixin{

  TabController tabController;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    tabController=new TabController(length: 2, vsync: this);
  }

     @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Theme.of(context).backgroundColor,
       key: _scaffoldKey,
       body: SafeArea(
           child: ChangeNotifierProvider<HistoryProvider>(
               create: (context)=>HistoryProvider(context,_scaffoldKey),
               child: Consumer(builder: (context,HistoryProvider model,child){
                 return Column(
                     children: <Widget>[
                       Container(
                         padding: const EdgeInsets.all(10),
                         child: Row(
                           children: <Widget>[
                             IconButton(icon: Icon(Icons.arrow_back,size: 25,), onPressed: ()=>Navigator.of(context).pop()),
                             Expanded(
                               child: TextView(
                                 'History',align: TextAlign.center,colors: Theme.of(context).primaryColor,size: 20,
                               ),

                             ),

                             Container(
                               width:30 ,
                             )

                           ],
                         ),
                       ),
                       Container(
                         color: Theme.of(context).dividerColor,
                         child: TabBar(
                            controller: tabController,
                             tabs: <Widget>[
                               Tab(text: 'Missed Calls',),
                               Tab(text: 'Attended Calls',),
                             ],
                            isScrollable: false,
                            indicatorColor: Colors.white,
                             labelColor: Colors.white,

                         ),
                       ),

                       Expanded(child: TabBarView(
                           controller: tabController,
                           children: <Widget>[
                             MissedCallScreen(),
                             AttemptedCallScreen(),
                       ])),

                       (model.isMissedLoad || model.isAttemptedLoad)
                        ?CircularProgressIndicator():Container()


                     ],
                   );
               }),
           )

       ),
    );
  }
}