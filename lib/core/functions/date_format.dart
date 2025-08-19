import 'package:easy_localization/easy_localization.dart';

String formatDate(String dateTimeString) {
  final DateTime dateTime = DateTime.parse(dateTimeString);
  final String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
  return formattedDate;
}

String formatTime(String dateTimeString) {
  final DateTime dateTime = DateTime.parse(dateTimeString);
  final String formattedDate = DateFormat('hh:mm a').format(dateTime);
  return formattedDate;
}

String formatChatTimestamp(DateTime timestamp) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final messageDate = DateTime(timestamp.year, timestamp.month, timestamp.day);
  final difference = today.difference(messageDate).inDays;

  if (difference == 0) {
    // Today - show time
    return DateFormat('h:mm a').format(timestamp);
  } else if (difference == 1) {
    // Yesterday
    return 'Yesterday';
  } else if (difference < 7) {
    // This week - show day name
    return DateFormat('EEEE').format(timestamp);
  } else if (timestamp.year == now.year) {
    // This year - show month/day
    return DateFormat('M/d/y').format(timestamp);
  } else {
    // Previous years - show full date
    return DateFormat('M/d/yyyy').format(timestamp);
  }
}

bool isCurrentTimeBetween(String startTimeStr, String endTimeStr) {
  final now = DateTime.now();
  final startTimeParts = startTimeStr.split(':').map(int.parse).toList();
  final endTimeParts = endTimeStr.split(':').map(int.parse).toList();

  final startTime = DateTime(
    now.year,
    now.month,
    now.day,
    startTimeParts[0],
    startTimeParts[1],
    startTimeParts[2],
  );
  final endTime = DateTime(
    now.year,
    now.month,
    now.day,
    endTimeParts[0],
    endTimeParts[1],
    endTimeParts[2],
  );

  if (endTime.isBefore(startTime)) {
    return now.isAfter(startTime) || now.isBefore(endTime);
  } else {
    return now.isAfter(startTime) && now.isBefore(endTime);
  }
}

String reformatDate(String dateStr, String locale) {
  final DateTime parsedDate = DateTime.parse(dateStr);
  final String formattedDate = DateFormat(
    'EEEE, dd MMMM yyyy',
    locale,
  ).format(parsedDate);
  return formattedDate;
}

int calculateSessionDuration(String startTime, String endTime) {
  final DateTime start = DateFormat("HH:mm").parse(startTime);
  final DateTime end = DateFormat("HH:mm").parse(endTime);
  final Duration duration = end.difference(start);
  return duration.inMinutes;
}

String formatDateDifference(String startDate, String endDate) {
  final DateTime start = DateTime.parse(startDate);
  final DateTime end = DateTime.parse(endDate);

  final int totalDays = end.difference(start).inDays;
  final int years = (totalDays / 365).floor();
  final int remainingDays = totalDays % 365;
  final int months = (remainingDays / 30).floor();
  final int days = remainingDays % 30;

  final List<String> parts = [];

  if (years > 0) {
    parts.add("$years year${years > 1 ? 's' : ''}");
  }
  if (months > 0) {
    parts.add("$months month${months > 1 ? 's' : ''}");
  }
  if (days > 0) {
    parts.add("$days day${days > 1 ? 's' : ''}");
  }

  return parts.isEmpty ? "0 days" : parts.join(", ");
}

String getDayName(String dateString) {
  final DateTime date = DateTime.parse(dateString);
  final List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  return days[date.weekday - 1];
}

String getDayNumber(String dateString) {
  final DateTime date = DateTime.parse(dateString);
  return date.day.toString().padLeft(2, '0');
}

String getMonthName(String dateString) {
  final DateTime date = DateTime.parse(dateString);
  final List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];
  return months[date.month - 1];
}

String formatMedicineTime(String time) {
  try {
    final DateTime parsedTime = DateFormat("HH:mm:ss").parse(time);
    final String formattedTime = DateFormat("hh:mm a").format(parsedTime);
    return formattedTime;
  } catch (e) {
    return "Invalid time";
  }
}

String getRelativeTime(DateTime timestamp) {
  final now = DateTime.now().toUtc();
  final difference = now.difference(timestamp);

  if (difference.inSeconds < 60) {
    return 'now';
  } else if (difference.inMinutes < 60) {
    final minutes = difference.inMinutes;
    return '${minutes}m ago';
  } else if (difference.inHours < 24) {
    final hours = difference.inHours;
    return '${hours}h ago';
  } else if (difference.inDays < 7) {
    final days = difference.inDays;
    return '${days}d ago';
  } else {
    // For older than a week, show the actual date
    return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
  }
}
