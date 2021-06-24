
class Delete {
   static String deleteTaskFolder(String id){
     return "DELETE FROM `task_group` WHERE `ID`='$id'";
   }
   static String deleteTask(String id){
     return "DELETE FROM `task` WHERE `ID`='$id'";
   }
}