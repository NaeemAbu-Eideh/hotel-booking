class DateRange {
  final DateTime start;
  final DateTime end;

  DateRange(this.start, this.end);
}

int countConflictingDateRanges(List<DateRange> dateRanges) {
  int conflictCount = 0;

  // Iterate through each pair of date ranges and check for conflicts
  for (int i = 0; i < dateRanges.length - 1; i++) {
    for (int j = i + 1; j < dateRanges.length; j++) {
      if (doDateRangesConflict(dateRanges[i], dateRanges[j])) {
        conflictCount++;
      }
    }
  }

  return conflictCount;
}

bool doDateRangesConflict(DateRange range1, DateRange range2) {
  if(range1.end.isAtSameMomentAs(range2.start)){return false;}
  else if(range1.start.isAtSameMomentAs(range2.end)){return false;}
  else{
    return !(range1.end.isBefore(range2.start) || range1.start.isAfter(range2.end));
  }
}

// void main() {
//   // Define your date ranges
//   List<DateRange> dateRanges = [
//     DateRange(DateTime(2023, 4, 1), DateTime(2023, 4, 3)),
//     DateRange(DateTime(2023, 4, 2), DateTime(2023, 4, 5)),
//     // Add more date ranges as needed
//   ];
//
//   // Count conflicting date ranges
//   int conflictCount = countConflictingDateRanges(dateRanges);
//
//   print('Number of conflicting date ranges: $conflictCount');
// }
