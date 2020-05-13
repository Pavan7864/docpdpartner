import 'package:flutter/material.dart';

class ImageViewSize extends StatelessWidget{
     ImageViewSize(this.name,this.height,this.weight,{this.mergin,this.padding,this.fit,this.colors});

     final String name;
      double height;
      Color colors;
      double weight;
      BoxFit fit = BoxFit.none;
     EdgeInsets mergin=EdgeInsets.all(0);
     EdgeInsets padding=EdgeInsets.all(0);

  @override
  Widget build(BuildContext context) {
     AssetImage assetImage=AssetImage(name);
     Image image;
     if(weight!=0.0) {
       image=Image(image: assetImage,width: weight,
          fit: fit,
         height: height,
         color: colors,);
     }else {
       image=Image(image: assetImage,height: height, fit: fit,
         color: colors,);
     }
       return Container(child: image,margin: mergin,padding: padding,);
  }

}