
class GetData{
  //-----------------------------------stockpile
  static final String getItemName = "SELECT `ID`, `name` , `category` FROM `item_available_name`";
  static final String getItems = "SELECT * FROM `item`";
  static final String getFabric = "SELECT * FROM `fabric` WHERE `log`='1'";
  static final String getFabricLogs = "SELECT * FROM `stock_pile_fabric_logs`";
  static final String getItemLogs = "SELECT `ID`, `item_id`, `log`, `person`, `amount`, `year`, `month`, `day`, `description` FROM `stock_pile_item_logs` WHERE 1";
  //--------------------------------------------
}