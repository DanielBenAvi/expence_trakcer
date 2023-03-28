/// format DateTime to String {yyyymmdd}
String dateTimeToString(DateTime date) {
  String year = date.year.toString();

  String month = date.month.toString();

  if (month.length == 1) {
    month = '0$month';
  }

  String day = date.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  String yyyymmdd = year + month + day;
  return yyyymmdd;
}
