
class GetData{
  //-----------------------------------stockpile
  static final String getItemName = "SELECT `ID`, `name` , `category` FROM `item_available_name`";
  static final String getItems = "SELECT * FROM `item`";
  static final String getFabric = "SELECT * FROM `fabric`";
  static final String getStockPileMessage = "SELECT * FROM `messages` WHERE `stockpile`='1'";
  static final String getCutterMessage = "SELECT * FROM `messages` WHERE `cutter`='1'";
  static final String getFabricLogs = "SELECT * FROM `stock_pile_fabric_logs`";
  static final String getItemLogs = "SELECT `ID`, `item_id`, `log`, `person`, `amount`, `year`, `month`, `day`, `description` FROM `stock_pile_item_logs` WHERE 1";
  static String getUser(String user,String pass ){
    return "SELECT `ID`, `name`, `side`, `profile_address`, `user`, `pass` FROM `super_users` WHERE  `user`='$user' AND `pass`='$pass'";
  }
  //--------------------------------------------
}