class Insert {
  // 0 means output in log
  //1 means input in log

  static String queryInsertFabricToStockpile(
      String manufacture,
      String calite,
      String metric,
      String color,
      String pieces,
      String description,
      int year,
      int month,
      int day) {
    return "INSERT INTO `fabric`(`manufacture`, `calite`, `metric`, `color`, `pieces`, `description`,`year`,`month`,`day`) VALUES ('$manufacture','$calite','$metric','$color','$pieces','$description','$year','$month','$day')";
  }
  static String queryInsertInputToLog(
      String itemId,
      int amount,
      int year,
      int month,
      int day,) {
    return "INSERT INTO `stock_pile_item_logs`(`item_id`,`amount`,`log`, `person`, `year`, `month`, `day`, `description`) VALUES ('$itemId','$amount','1','-','$year','$month','$day','-')";
  }

  static String queryInsertOutputToLog(String itemId,
    String amount,
    int year,
    int month,
    int day,
    String person,
    String description) {
    return "INSERT INTO `stock_pile_item_logs`(`item_id`,`amount`,`log`, `person`, `year`, `month`, `day`, `description`) VALUES ('$itemId','$amount','0','$person','$year','$month','$day','$description')";
  }

  static String queryExportToFabricLog(String fabricId,String description,int year,int month,int day,String person){
    return "INSERT INTO `stock_pile_fabric_logs`(`fabric_id`,`person`, `log`, `description`, `year`, `month`, `day`) VALUES ('$fabricId','$person','0','$description','$year','$month','$day')";
  }

  static String queryInputToFabricLog(String fabricId,int year,int month,int day){
    return "INSERT INTO `stock_pile_fabric_logs`(`fabric_id`,`person`, `log`, `description`, `year`, `month`, `day`) VALUES ('$fabricId','-','1','-','$year','$month','$day')";
  }

}
