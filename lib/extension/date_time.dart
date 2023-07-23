import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String formatMonth() => DateFormat('M').format(this);

  String formatDateTime() => DateFormat('M/dd H:mm').format(this);
}
