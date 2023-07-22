import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String formatMonth() => DateFormat('M').format(this);
}
