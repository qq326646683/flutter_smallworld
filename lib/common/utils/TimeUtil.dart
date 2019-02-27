class TimeUtil {
  static String showDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String short = "${twoDigits(duration.inMinutes)}:${twoDigits(duration.inSeconds)}";

    if (duration.inHours > 0) {
      return "${twoDigits(duration.inHours)}:${short}";
    } else {
      return short;
    }

  }
}