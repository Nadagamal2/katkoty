enum RepeatType { once, allDays, specificDays, custom }

enum AlarmDay { monday, tuesday, wednesday, thursday, friday, saturday, sunday }

extension DayNumberExtension on String {
  int get dayNumber {
    switch (this) {
      case "monday":
        return 1;
      case "tuesday":
        return 2;
      case "wednesday":
        return 3;
      case "thursday":
        return 4;
      case "friday":
        return 5;
      case "saturday":
        return 6;
      case "sunday":
        return 7;
      default:
        return 0;
    }
  }
}
