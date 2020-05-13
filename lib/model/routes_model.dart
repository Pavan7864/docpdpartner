class RoutesModel{

   String id;
   String title;
   String description;
   RoutesModel({this.id,this.title,this.description});

   factory RoutesModel.fromJSON(Map<String,dynamic> map){
      return RoutesModel(
           id:map['ID'],
           title:map.containsKey('FormTitle')?map['FormTitle']:map['RouteTitle'],
           description:map['Explanation'],
      );
   }
}

var rout={
   "Status": 1,
   "RouteList": [
      {
         "Id": "17",
         "RouteTitle": "Transdermal",
         "Explanation": "Given through a patch placed on the skin"
      },
      {
         "Id": "16",
         "RouteTitle": "Topical",
         "Explanation": "Applied to the skin"
      },
      {

         "Id": "15",
         "RouteTitle": "Buccal",
         "Explanation": "Held inside the cheek"
      },
      {

         "Id": "14",
         "RouteTitle": "Sublingual",
         "Explanation": "Held under the tongue"
      },
      {

         "Id": "13",
         "RouteTitle": "Subcutaneous",
         "Explanation": "Injected just under the skin"
      },
      {

         "Id": "12",
         "RouteTitle": "Intrathecal",
         "Explanation": "Injected into your spine"
      },
      {

         "Id": "11",
         "RouteTitle": "Vaginal",
         "Explanation": "Substance is applied inside the vagina."
      },
      {
         "Id": "10",
         "RouteTitle": "Rectal",
         "Explanation": "Inserted into the rectum"
      },
      {
         "Id": "9",
         "RouteTitle": "Enteral",
         "Explanation": "Delivered directly into the stomach or intestine (with a G-tube or J-tube)"
      },
      {
         "Id": "8",
         "RouteTitle": "Otic",
         "Explanation": "Given by drops into the ear"
      },
      {
         "Id": "7",
         "RouteTitle": "Ophthalmic",
         "Explanation": "Given into the eye by drops, gel, or ointment"
      },
      {
         "Id": "6",
         "RouteTitle": "Nasal",
         "Explanation": "Given into the nose by spray or pump"
      },
      {
         "Id": "5",
         "RouteTitle": "Intramuscular",
         "Explanation": "Injected into muscle with a syringe"
      },
      {
         "Id": "4",
         "RouteTitle": "Intravenous",
         "Explanation": "Injected into a vein or into an IV line"
      },
      {

         "Id": "3",
         "RouteTitle": "infused",
         "Explanation": "injected into a vein with an IV line and slowly dripped in over time"
      },
      {

         "Id": "2",
         "RouteTitle": "inhalable, inhalation",
         "Explanation": "breathed in through a tube or mask"
      },
      {
         "Id": "1",
         "RouteTitle": "oral",
         "Explanation": "swallowed by mouth as a tablet, capsule, lozenge, or liquid"
      }
   ]
};

var does={
   "Status": 1,
   "DoseDetails": [
      {

         "Id": "12",
         "FormTitle": "other "
      },
      {

         "Id": "11",
         "FormTitle": "tablet"
      },
      {

         "Id": "10",
         "FormTitle": "suppository"
      },
      {

         "Id": "9",
         "FormTitle": "powder"
      },
      {

         "Id": "8",
         "FormTitle": "ointment"
      },
      {

         "Id": "7",
         "FormTitle": "metered dose inhaler"
      },
      {

         "Id": "6",
         "FormTitle": "eye ointment"
      },
      {

         "Id": "5",
         "FormTitle": "eye drops"
      },
      {

         "Id": "4",
         "FormTitle": "ear ointment"
      },
      {

         "Id": "3",
         "FormTitle": "ear drops"
      },
      {

         "Id": "2",
         "FormTitle": "cream"
      },
      {

         "Id": "1",
         "FormTitle": "capsule"
      }
   ]
};