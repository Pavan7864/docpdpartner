import 'package:flutter/material.dart';

class FullImageView extends StatelessWidget{
     FullImageView(this.name,{this.mergin,this.padding,this.fit,this.colors});

     final String name;

     Color colors;
     BoxFit fit = BoxFit.none;
     EdgeInsets mergin=EdgeInsets.all(0);
     EdgeInsets padding=EdgeInsets.all(0);
  @override
  Widget build(BuildContext context) {
     AssetImage assetImage=AssetImage(name);
     Image image=Image(image: assetImage,
       fit: this.fit,
       color: colors,);
    return Container(child: image,margin: mergin,padding: padding,);
  }

}