import 'package:intl/intl.dart' as intl;

extension DateTimeExtensions on DateTime {
  String toDateFormat(String format) {
    final intl.DateFormat formatter = intl.DateFormat(format);
    final String formatted = formatter.format(this);
    return formatted;
  }
}
