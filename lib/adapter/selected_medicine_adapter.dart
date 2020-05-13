import 'package:docpdpartner/custom_ui/imageView/TextView.dart';
import 'package:docpdpartner/model/medicine_model.dart';
import 'package:docpdpartner/utils/app_color.dart';
import 'package:flutter/material.dart';

class SelectedMedicineAdapter extends StatelessWidget{
final MedicineModel model;
Function remove;
SelectedMedicineAdapter(this.model,this.remove);

    @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
       width: 200,
      child: Card(
         color: background,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(child: TextView(model.name,size: 13,weight: FontWeight.w500,line: 2,mergin: const EdgeInsets.all(7),)),
               IconButton(icon:  Icon(Icons.delete,size: 25,), onPressed: (){
                 remove(model);
               })
              ],
            ),
            Row(
              children: <Widget>[
                TextView(model.frequencyDay.times??'',size: 12,colors: Theme.of(context).hintColor,weight: FontWeight.w500,mergin: const EdgeInsets.all(7),),
                Container(
                  color: Theme.of(context).hintColor,
                  height: 15,
                  width: 1,
                  margin: const EdgeInsets.only(left: 10,right: 10),
                ),
                TextView(model.howManyDay.times??''+' '+model.howManyDay.days??'',size: 12,colors: Theme.of(context).hintColor,weight: FontWeight.w500,mergin: const EdgeInsets.all(7),),
              ],
            )
          ],
        ),
      ),
    );
  }
}