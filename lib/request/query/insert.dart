
class Insert{

  static String queryAddAvailableItemToStockpile(String availableItemId,String firstQuantifier,String quantify,String secondQuantifier,String warning,) {
    return "INSERT INTO `item`(`item_id`, `quantifier_one`, `quantify`, `quantifier_two`, `warning`) VALUES ('${int.parse(availableItemId)}','$firstQuantifier','$quantify','$secondQuantifier','$warning')";
  }
  static String queryAddFabricToStockpile(String manufacture,String calite,String metric,String color,String pieces,String description){
    return "INSERT INTO `fabric`(`manufacture`, `calite`, `metric`, `color`, `pieces`, `description`) VALUES ('$manufacture','$calite','$metric','$color','$pieces','$description')";
  }
}