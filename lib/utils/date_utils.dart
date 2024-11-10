import 'package:intl/intl.dart';

class DateFormatUtils {
  
  static String formatToDDMMYYYY(DateTime date) {
    return DateFormat('dd / MM /yyyy').format(date);
  }
}
