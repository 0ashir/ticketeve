import 'package:intl/intl.dart';

extension StringExtension on String {
  /// String Extension Method to get Title Case
  String toTitleCase() {
    return split(' ').map((word) => word[0].toUpperCase() + word.substring(1)).join(' ');
  }
}

extension DateTimeExtension on DateTime? {

  /// DateTime Extension Method to get Date in MMM dd, yyyy format
  String? toFormattedDate() {
    //null check
    if (this == null) {
      return null;
    }
    return DateFormat('MMM dd, yyyy').format(this!);
  }

  String? toFormattedDateTimeYYYYMMDD() {
    //null check
    if (this == null) {
      return null;
    }
    return DateFormat('yyyy-M-d').format(this!);
  }
}
extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
