import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeUtils {
  static Future pickDate(context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    return selectedDate;
  }

  static Future pickDateRange(context) async {
    DateTimeRange? selectedDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
    return selectedDateRange;
  }

  static String formatDate(DateTime date) {
    //return DateFormat('dd MMM yyyy').format(date);
    return DateFormat('yyyy-MM-dd').format(date);
  }
}
