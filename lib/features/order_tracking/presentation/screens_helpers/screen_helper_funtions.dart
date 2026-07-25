import 'package:intl/intl.dart';

String formatDateString(String dateString) {
  try {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
    return formattedDate;
  } catch (e) {
    return dateString;
  }
}
