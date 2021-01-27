import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

class FilterParams {
  final FilterDate filterDate;
  final bool isFavorite;

  FilterParams({
    @required this.filterDate,
    @required this.isFavorite,
  });

  @override
  String toString() =>
      'FilterParams(filterDate: $filterDate, isFavorite: $isFavorite)';
}

enum FilterDate { lastMonth, thisWeek, lastTwentyFourHours, all }

extension FilterParamsExtension on FilterDate {
  String get description {
    switch (this) {
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

extension FilterParamsDateExtension on FilterDate {
  String get date {
    final now = DateTime.now();
    final weekDay = now.weekday;

    switch (this) {
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
