class Update {
  static String queryUpdateStockQuantifier(String id, String quantifier) {
    return "UPDATE `item` SET `quantifier_one`='$quantifier' WHERE `ID`='$id'";
  }

  static String queryUpdateLogInFabricTable(String id, String log) {
    return "UPDATE `fabric` SET `log`='$log' WHERE `ID`='$id'";
  }

  static String queryUpdateItemInStockpile(
      String itemId,
      String firstQuantifier,
      String quantify,
      String category,
      String warning) {
    return "UPDATE `item` SET `quantifier_one`='$firstQuantifier',`quantify`='$quantify',`category`='$category',`warning`='$warning' WHERE `ID`='$itemId'";
  }

  static String pauseMonitorCard({String pauseDateTime,String play,String score,String id,String remainingTime}){
    return "UPDATE `assignment` SET `pause_date_time`='$pauseDateTime',`play`='$play',`score`='$score',`remaining_time`='$remainingTime' ,`play_date_time`=NULL WHERE `ID`='$id'";
  }
  static String playMonitorCard({String play,String id,String dateTime}){

    return "UPDATE `assignment` SET `play`='$play', `play_date_time`='$dateTime' WHERE `ID`='$id'";
  }

  static String playAllMonitorCard(){
    String dateTime = DateTime.now().toString().substring(0,19);
    return "UPDATE `assignment` SET `play`='1' , `play_date_time`='$dateTime' WHERE `start_date_time` IS NOT NULL";
  }

  static String updateTask(String id,String name,String expertTime,String amateur,String internTime){
    return "UPDATE `task` SET `name`='$name',`expert_time`='$expertTime',`amateur_time`='$amateur',`intern_time`='$internTime' WHERE `ID`='$id'";
  }
}
