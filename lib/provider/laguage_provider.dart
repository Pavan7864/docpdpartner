import 'package:docpdpartner/model/language_model.dart';
import 'package:docpdpartner/utils/AppUtils.dart';
import 'package:flutter/cupertino.dart';

class LanguageProvider extends ChangeNotifier{

  List<LanguageModel> arrLanguage=[];
  List<LanguageModel> arrSelected=[];

  LanguageProvider(List<LanguageModel> list){
    arrSelected=list;
    getLanguage();
  }

  void getLanguage(){
    arrLanguage=AppUtils.getLanguage();
    for(LanguageModel model in arrSelected){
      for(LanguageModel language in arrLanguage){
                 if(model.position==language.position && model.isSelected){
                   language.isSelected=true;
                 }
      }
    }
    notifyListeners();
  }

  void select(int position){
    arrLanguage[position].isSelected=!arrLanguage[position].isSelected;
    notifyListeners();
  }


}