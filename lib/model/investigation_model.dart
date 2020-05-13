class InvestigationModel{

   String id='';
   String itemID='';
   String subCategoryId='';
   String itemDept='';
   String itemName='';
   String itemHospitalName='';
   String itemBranchName='';
   String itemCost='';
   String itemDiscountPercentage='';
   String actualCost='';
   bool isSelected=false;

   InvestigationModel({this.id,this.itemID,this.subCategoryId,this.itemDept,this.itemName,this.itemHospitalName,this.itemBranchName,this.itemCost,this.itemDiscountPercentage,
    this.actualCost});

   factory InvestigationModel.fromJSON(Map<String,dynamic> map){

      return InvestigationModel(
           id: map['\$id'].toString(),
           itemID: map.containsKey('InvestigationmasterID')?map['InvestigationmasterID'].toString():map['ItemID'].toString(),
          subCategoryId: map['SubCategoryId'].toString(),
          itemDept: map['ItemDept'],
          itemName: map.containsKey('InvestigationName')?map['InvestigationName']:map['ItemName'],
          itemHospitalName: map['ItemHospitalName'],
          itemBranchName: map['ItemBranchName'],
          itemCost: map['ItemCost'].toString(),
          itemDiscountPercentage: map.containsKey('DiscountedPrice')?map['DiscountedPrice'].toString():map['ItemDiscountPercentage'].toString(),
          actualCost: map['ActualCost'].toString(),
      );
   }

  Map<String,String>toMap() {
     return {
         'InvestigationmasterID':itemID??'',
         'InvestigationName':itemName??'',
         'ActualCost':actualCost??'',
         'DiscountedCost':itemDiscountPercentage??'',
         'InvestigationType':itemBranchName??'',
     };
  }
}