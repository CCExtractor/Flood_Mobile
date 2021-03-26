String dateConverter({int timestamp}) {
  return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000).day.toString() +
      ' / ' +
      DateTime.fromMillisecondsSinceEpoch(timestamp * 1000).month.toString() +
      ' / ' +
      DateTime.fromMillisecondsSinceEpoch(timestamp * 1000).year.toString();
}
