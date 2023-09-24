String parseDate(DateTime date) {
  late String finalM;
  late String finalD;

  final y = date.year;
  final m = date.month;
  final d = date.day;

  if (m < 10) {
    finalM = '0$m';
  } else {
    finalM = '$m';
  }

  if (d < 10) {
    finalD = '0$d';
  } else {
    finalD = '$d';
  }

  return '/$y/$finalM/$finalD';
}
