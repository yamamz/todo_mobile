import 'package:intl/intl.dart';

String getDayNumberString(DateTime date) {
  final DateFormat dayFormat = DateFormat('dd');
  return dayFormat.format(date);
}

String getMonthAbbrString(DateTime date) {
  final DateFormat dayFormat = DateFormat(DateFormat.ABBR_MONTH);
  return dayFormat.format(date);
}

String getYearAbbrString(DateTime date) {
  final DateFormat dayFormat = DateFormat(DateFormat.YEAR);
  return dayFormat.format(date);
}
