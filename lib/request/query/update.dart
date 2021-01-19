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
}
