
class TimeFormat{

  static String timeFormat(int time){
    if(time < 10){
      return '0$time';
    }else{
      return time.toString();
    }
  }

  static String timeFormatFromDuration(Duration d){
    String h = timeFormat(d.inHours.remainder(60));
    String m = timeFormat(d.inMinutes.remainder(60));
    String s = timeFormat(d.inSeconds.remainder(60));
    return "$h:$m:$s";
  }

  static Duration stringToDuration(String time){
    String h = time.substring(0,2);
    String m = time.substring(3,5);
    String s = time.substring(6,8);
    return Duration(hours: int.parse(h),minutes: int.parse(m),seconds: int.parse(s));
  }

  // static String printDuration(Duration duration) {
  //   String twoDigits(int n) => n.toString().padLeft(2, "0");
  //   String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  //   String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  //   return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  // }
}