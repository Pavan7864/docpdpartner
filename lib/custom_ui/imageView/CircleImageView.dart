import 'package:docpdpartner/custom_ui/imageView/FullImageView.dart';
import 'package:docpdpartner/utils/AppUtils.dart';
import 'package:flutter/material.dart';

class CircleImageView extends StatelessWidget{
     CircleImageView(this.url,this.size,{this.mergin,this.padding,this.fit,this.colors});

     final String url;
      Color colors;
      double size;
      BoxFit fit = BoxFit.none;
     EdgeInsets mergin=EdgeInsets.all(0);
     EdgeInsets padding=EdgeInsets.all(0);

  @override
  Widget build(BuildContext context) {

       return Container(child: ClipRRect(
         borderRadius: new BorderRadius.circular(size/2),
         child:  Container(
           width: size,
           height: size,
           decoration: BoxDecoration(
             border: Border.all(color: colors==null?Colors.black:colors,width: 1),
             borderRadius: BorderRadius.all(Radius.circular(size/2)),

           ),
           padding: const EdgeInsets.all(1),
           child: ClipRRect(
                 borderRadius: new BorderRadius.circular(size/2),
                 child: AppUtils.isEmpty(url)?FullImageView("assets/icon/placeholder.png"):FadeInImage.assetNetwork(
                   placeholder: 'assets/icon/placeholder.png',
                   image:url,
                   fit: BoxFit.fill,
                 ),
           ),
         ),
       ),margin: mergin,padding: padding,);
  }

}