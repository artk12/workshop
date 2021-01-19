
class GetData{
  //-----------------------------------stockpile
  static final String getItemName = "SELECT `ID`, `name` , `category` FROM `item_available_name`";
  static final String getItems = "SELECT * FROM `item`";
  static final String getFabric = "SELECT * FROM `fabric` WHERE `log`='1'";
  //--------------------------------------------
}