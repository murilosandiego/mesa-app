import 'package:intl/intl.dart';

class FilterParams {
  FilterDate filterDate;
  bool isFavorite;
  int currentPage;

  FilterParams({
    this.filterDate,
    this.isFavorite,
    this.currentPage,
  });

  @override
  String toString() =>
      'FilterParams(filterDate: $filterDate, isFavorite: $isFavorite)';
}

enum FilterDate { lastYear, lastMonth, thisWeek, lastTwentyFourHours, all }

extension FilterParamsExtension on FilterDate {
  String get description {
    switch (this) {
      case FilterDate.lastYear:
        return 'Último ano';
      case FilterDate.lastMonth:
        return 'Último mês';
      case FilterDate.thisWeek:
        return 'Essa semana';
      case FilterDate.lastTwentyFourHours:
        return 'Últimas 24 horas';
      default:
        return 'Todas';
    }
  }
}

extension FilterParamsDateStringExtension on FilterDate {
  String get dateString {
    final now = DateTime.now();
    final weekDay = now.weekday;

    switch (this) {
      case FilterDate.lastYear:
        {
          final date = now.subtract(Duration(days: 365));
          return DateFormat('yyyy-MM-dd').format(date);
        }
      case FilterDate.lastMonth:
        {
          final date = now.subtract(Duration(days: 30));
          return DateFormat('yyyy-MM-dd').format(date);
        }
      case FilterDate.thisWeek:
        {
          final date = now.subtract(Duration(days: weekDay - 1));
          return DateFormat('yyyy-MM-dd').format(date);
        }
      case FilterDate.lastTwentyFourHours:
        {
          final date = now.subtract(Duration(hours: 24));
          return DateFormat('yyyy-MM-dd').format(date);
        }
      default:
        return null;
    }
  }
}

extension FilterParamsDateExtension on FilterDate {
  DateTime get date {
    final now = DateTime.now();
    final weekDay = now.weekday;

    switch (this) {
      case FilterDate.lastYear:
        return now.subtract(Duration(days: 500));
      case FilterDate.lastMonth:
        return now.subtract(Duration(days: 30));
      case FilterDate.thisWeek:
        return now.subtract(Duration(days: weekDay - 1));
      case FilterDate.lastTwentyFourHours:
        return now.subtract(Duration(hours: 24));
      default:
        return null;
    }
  }
}
