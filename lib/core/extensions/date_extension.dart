import 'package:intl/intl.dart';

extension DateStringExtension on String? {
  String toFormattedDateTime() {
    if (this == null || this!.isEmpty) return '';
    try {
      final dt = DateTime.parse(this!).toLocal();
      final date = DateFormat('d MMM yyyy').format(dt);
      final time = DateFormat('h:mm a').format(dt);
      return '$date  •  $time';
    } catch (_) {
      return this!;
    }
  }
}
