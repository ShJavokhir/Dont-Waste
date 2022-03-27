import 'package:easy_localization/easy_localization.dart';

class DateTimeUtility{

  static String getReadableTime(int? timestamp){
    if(timestamp == null) return "null";
    final normalTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final today = DateTime.now();
    if(normalTime.day == today.day && normalTime.month == today.month && normalTime.year == today.year) return "today_at".tr(args: [ getNormalDayOrMonth(normalTime.hour) + ":" + getNormalDayOrMonth(normalTime.minute)]);
    //print("datetime: " + today.compareTo(normalTime).toString());
    if((normalTime.millisecondsSinceEpoch-today.millisecondsSinceEpoch).abs() <= 86400000) return 'yesterday'.tr();
    return getNormalDayOrMonth(normalTime.day) + '.' + getNormalDayOrMonth(normalTime.month);
  }

  static String getNormalDayOrMonth(int dayOrMonth){
    return dayOrMonth.toString().length==1?'0' + dayOrMonth.toString():dayOrMonth.toString();
  }
}

