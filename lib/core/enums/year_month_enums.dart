enum YearMonth { year, month }

extension YearMonthExt on YearMonth {
  String get value {
    switch (this) {
      case YearMonth.year:
        return "Year";
      case YearMonth.month:
        return "Month";
    }
  }
}
