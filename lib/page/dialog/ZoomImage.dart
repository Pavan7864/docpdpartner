import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ZoomImage extends StatefulWidget{
 final String url;
 ZoomImage(this.url);

   @override
   _ZoomImage createState()=>_ZoomImage();
}
class _ZoomImage extends State<ZoomImage>{


   @override
  Widget build(BuildContext context) {

    return Scaffold(
       backgroundColor: Theme.of(context).backgroundColor,
       body: InkWell(
         onTap: (){
           Navigator.pop(context);
         },
         child: Stack(
           children: <Widget>[
             PhotoView(
               imageProvider: NetworkImage(widget.url),//Image.network(),
             ),

             Container(
               child:Align(
                 alignment: Alignment.topCenter,
                 child: Container(
                    margin: const EdgeInsets.only(top: 35),
                   child: IconButton(icon: Icon(Icons.close,size: 35,color: Colors.red,), onPressed: (){
                      Navigator.pop(context);
                   }),
                 ),
               ),
             )
           ],
         ),
       )//Image.network(ApiClient.imageBaseUrl+rcvdData['url'].toString()),
    );
  }
}