import 'package:intl/intl.dart';

String timeAgoSinceDate(String dateString, {bool numericDates = true}) {
  DateTime notificationDate = DateTime.parse(dateString);
  final date2 = DateTime.now();
  final difference = date2.difference(notificationDate);
  if (difference.inDays > 7 || difference.inDays < 0) {
    return DateFormat('dd MMM yyyy').format(notificationDate);
  } else if (difference.inDays > 2) {
    return '${difference.inDays} days ago';
  } else if (difference.inDays >= 1) {
    return numericDates ? '1 day ago' : 'Yesterday';
  } else if (difference.inHours > 1) {
    return '${difference.inHours} hrs ago';
  } else if (difference.inMinutes > 1) {
    return '${difference.inMinutes} mins ago';
  } else if (difference.inSeconds > 3) {
    return '${difference.inSeconds} secs ago';
  } else {
    return 'Just now';
  }
}