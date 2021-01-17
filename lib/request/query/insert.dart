
class Insert{

  static String queryAddAvailableItemToStockpile(String availableItemId,String firstQuantifier,String quantify,String secondQuantifier,String warning,int year,int month,int day) {
    return "INSERT INTO `item`(`item_id`, `quantifier_one`, `quantify`, `quantifier_two`, `warning`,`year`,`month`,`day`) VALUES ('${int.parse(availableItemId)}','$firstQuantifier','$quantify','$secondQuantifier','$warning','$year','$month','$day')";
  }
  static String queryAddFabricToStockpile(String manufacture,String calite,String metric,String color,String pieces,String description,int year,int month,int day){
    return "INSERT INTO `fabric`(`manufacture`, `calite`, `metric`, `color`, `pieces`, `description`,`year`,`month`,`day`) VALUES ('$manufacture','$calite','$metric','$color','$pieces','$description','$year','$month','$day')";
  }
}