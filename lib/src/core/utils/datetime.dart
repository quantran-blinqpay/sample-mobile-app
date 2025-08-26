import 'package:easy_localization/easy_localization.dart';

class DateTimeUtil {
  static String formatDateToString(DateTime? date,
      {String parttern = 'dd/MM/yyyy', String? locale}) {
    if (date == null) return '';
    return DateFormat(parttern, locale).format(date);
  }

  static String formatDateNow({String parttern = 'dd/MM/yyyy'}) {
    return formatDateToString(DateTime.now(), parttern: parttern);
  }

  static String durationToString(int? durationInMinutes) {
    if (durationInMinutes == null) return '';
    final int hours = durationInMinutes ~/ 60;
    final int minutes = durationInMinutes % 60;
    final String cinemaHoursTime = (hours > 0) ? '${hours}giờ ' : '';
    final String cinemaMinutesTime = (minutes > 0) ? '${minutes}phút' : '';
    return '$cinemaHoursTime$cinemaMinutesTime';
  }

  static String formatDurationAndCinemaDate({
    int? durationInMinutes,
    DateTime? dateTime,
  }) {
    final durationString = durationToString(durationInMinutes);
    final formatDateString = formatDateToString(dateTime,
        parttern: "d 'Thg' M, yyyy", locale: 'vi_VN');
    return '$durationString $formatDateString';
  }

  static String getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years year${years == 1 ? '' : 's'} ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months month${months == 1 ? '' : 's'} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else {
      return 'just now';
    }
  }
}
