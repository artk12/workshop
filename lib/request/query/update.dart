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
    return "UPDATE `assignment` SET `pause_date_time`='$pauseDateTime',`play`='$play',`score`='$score',`remaining_time`='$remainingTime' WHERE `ID`='$id'";
  }
  static String playMonitorCard({String play,String id}){
    return "UPDATE `assignment` SET `play`='$play' WHERE `ID`='$id'";
  }

  static String playAllMonitorCard(){
    return "UPDATE `assignment` SET `play`='1' ";
  }
}
