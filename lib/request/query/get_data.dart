class GetData {
  //-----------------------------------stockpile
  static final String getItemName =
      "SELECT `ID`, `name` , `category` FROM `item_available_name`";
  static final String getItems = "SELECT * FROM `item`";
  static final String getFabric = "SELECT * FROM `fabric`";
  static final String getStockPileMessage =
      "SELECT * FROM `messages` WHERE `stockpile`='1'";
  static final String getCutterMessage =
      "SELECT * FROM `messages` WHERE `cutter`='1'";
  static final String getFabricLogs = "SELECT * FROM `stock_pile_fabric_logs`";
  static final String getItemLogs =
      "SELECT `ID`, `item_id`, `log`, `person`, `amount`, `year`, `month`, `day`, `description` FROM `stock_pile_item_logs` WHERE 1";
  static String getSuperUser(String user, String pass) {
    return "SELECT `ID`, `name`, `side`, `profile_address`, `user`, `pass` FROM `super_users` WHERE  `user`='$user' AND `pass`='$pass'";
  }

  static String getNormalUser(String nationalCode, String pass) {
    return "SELECT * FROM `user` WHERE  `national_code`='$nationalCode' AND `pass`='$pass'";
  }

  //--------------------------------------------publish manager
  static final String getAllUser = "SELECT * FROM `user`";
  static final String getAllTask = "SELECT * FROM `task`";
  static get getTodayAssignments {
    return "SELECT * FROM `assignment`";
  }

  static final String getPublishManagerMessage =
      "SELECT * FROM `messages` WHERE `publish_manager`='1'";

  static String getPersonnelTask(String id) {
    return "SELECT `ID`, `name`, `assign_date_time`, `time`, `remaining_time`, `cut_code`, `number`, `start_date_time`, `pause_date_time`, `play`,"
        " `submit_date_time`, `score`, `personnel_id` FROM `assignment` WHERE `personnel_id` = '$id'";
  }

  static final String getPersonnelLog =
      "SELECT `ID`, `personnel_id`, `personnel_name`, `task_name`, `cut_code`, `log` FROM `assignment_log`";

  static String getAbsentMonth(){
    DateTime dateTime = DateTime.now();
    String year = dateTime.year.toString();
    String month = dateTime.month.toString();
    String day = dateTime.day.toString();

    return "SELECT `ID`, `personnel_id`, `year`, `month`, `day` FROM `absent` WHERE `year`='$year' AND `month`='$month'";
  }

  static String getAllScore = "SELECT `ID`, `user_id`, `scores` FROM `user_score`";

  static String getAllWarning = "SELECT `ID`, `user_id`, `warnings` FROM `user_warnings`";

  //------------------------------------------personnel
  static final String getPersonnelMessage =
      "SELECT * FROM `messages` WHERE `personnel`='1'";

  static String getScorePersonnel(String id){
    return "SELECT `ID`, `user_id`, `scores` FROM `user_score` WHERE `user_id`='$id'";
  }
  // static final String getTodayAssignments = "SELECT * FROM `assignment` ";
}
