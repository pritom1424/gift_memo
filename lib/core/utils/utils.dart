import 'package:intl/intl.dart';

class Utils {
  String dateTimeToText(DateTime dateTime) {
    return DateFormat.yMMMd().format(dateTime);
  }
}
