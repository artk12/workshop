class Insert {
  // 0 means output in log
  //1 means input in log
  static DateTime dateTime = DateTime.now();
  static int year = dateTime.year;
  static int month = dateTime.month;
  static int day = dateTime.day;

  static String queryInsertInProject(String type, String brand, String roll,
      String styleCode, String size, String description) {
    return "INSERT INTO `project`(`type`, `brand`, `roll`, `style_code`, `size`, `description`) VALUES ('$type','$brand','$roll','$styleCode','$size','$description')";
  }

  static String queryInsertFabricToStockpile(
    String manufacture,
    String calite,
    String metric,
    String color,
    String pieces,
    String barcode,
    String description,
  ) {
    return "INSERT INTO `fabric`(`manufacture`, `calite`, `metric`, `color`, `pieces`, `description`,`year`,`month`,`day`,`barcode`) VALUES ('$manufacture','$calite','$metric','$color','$pieces','$description','$year','$month','$day','$barcode')";
  }

  static String queryInsertInputToLog(
    String itemId,
    int amount,
  ) {
    return "INSERT INTO `stock_pile_item_logs`(`item_id`,`amount`,`log`, `person`, `year`, `month`, `day`, `description`) VALUES ('$itemId','$amount','1','-','$year','$month','$day','-')";
  }

  static String queryInsertOutputToLog(
      String itemId, String amount, String person, String description) {
    return "INSERT INTO `stock_pile_item_logs`(`item_id`,`amount`,`log`, `person`, `year`, `month`, `day`, `description`) VALUES ('$itemId','$amount','0','$person','$year','$month','$day','$description')";
  }

  static String queryExportToFabricLog(
      String fabricId, String description, String person) {
    return "INSERT INTO `stock_pile_fabric_logs`(`fabric_id`,`person`, `log`, `description`, `year`, `month`, `day`) VALUES ('$fabricId','$person','0','$description','$year','$month','$day')";
  }

  static String queryInsertMessageNewProject(String brand) {
    String title = "ایجادپروژه جدید";
    String message =
        "یک پروژه جدید برای برند" + " $brand " + " توسط مدیر عامل اضافه شد.";
    return "INSERT INTO `messages`(`title`, `sender`, `message`, `stockpile`, `cutter`) VALUES ('$title','0','$message','1','1')";
  }

  static String queryInsertCutterProject(
      String projectId,
      String fabricId,
      String realUsage,
      String usage,
      String height,
      String pieces,
      String totalGoods,
      String cutCode,
      String description) {
    return "INSERT INTO `cutter`(`project_id`, `fabric_id`, `real_usage`, `all_usage`, `height`, `pieces`, `total_goods`, `cut_code`, `description`,`year`,`month`,`day`) VALUES"
        " ('$projectId','$fabricId','$realUsage','$usage','$height','$pieces','$totalGoods','$cutCode','$description','$year','$month','$day')";
  }

  static String queryInsertPersonnel(
      String name,
      String nationalCode,
      String fatherName,
      String birthDay,
      String hireDate,
      String position,
      String level) {
    return "INSERT INTO `user`(`name`, `national_code`, `father_name`, `birth_date`, `hire_date`, `position`, `level`) "
        "VALUES ('$name','$nationalCode','$fatherName','$birthDay','$hireDate','$position','$level')";
  }

  static String queryInsertTask(
      String name, String expertTime, String amateurTime, String internTime,String groupId) {
    return "INSERT INTO `task`(`name`, `expert_time`, `amateur_time`, `intern_time`,`group_id`) VALUES ('$name','$expertTime','$amateurTime','$internTime','$groupId')";
  }
  static String queryInsertNewFolderTask(String name){
    return "INSERT INTO `task_group`(`name`) VALUES ('$name')";
  }

// static String queryInputToFabricLog(String fabricId,int year,int month,int day){
//   return "INSERT INTO `stock_pile_fabric_logs`(`fabric_id`,`person`, `log`, `description`, `year`, `month`, `day`) VALUES ('$fabricId','-','1','-','$year','$month','$day')";
// }

}
