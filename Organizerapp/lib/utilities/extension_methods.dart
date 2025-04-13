// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
// DateTime Extension Methods

// DateTime format to dd-mmm-yyyy as string
extension DateTimeExtension on DateTime {
  String toDDMMMYYYY() {
    return DateFormat('dd-MMM-yyyy').format(this);
  }
}
