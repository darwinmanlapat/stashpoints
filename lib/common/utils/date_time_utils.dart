import 'package:intl/intl.dart';

class DateTimeUtils {
  static String formatTime(String timeString) {
    /// Parse the time string to a DateTime object
    DateTime time = DateFormat('HH:mm:ss').parse(timeString);

    String pattern = 'h:mm a';

    if (time.minute == 0) {
      pattern = 'h a';
    }

    /// Format the DateTime object to 'h:mm a' format
    String formattedTime = DateFormat(pattern).format(time);

    formattedTime = formattedTime.replaceAll(' ', '');

    return formattedTime.toLowerCase();
  }
}
