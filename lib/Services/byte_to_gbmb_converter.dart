import 'dart:math';

String byteToGbMbKbConverter({double byte}) {
  return (byte / pow(10, 9)) <= 1
      ? (byte / pow(10, 6)) <= 1
          ? (byte / pow(10, 3)).toStringAsFixed(2) + ' KB'
          : (byte / pow(10, 6)).toStringAsFixed(2) + ' MB'
      : (byte / pow(10, 9)).toStringAsFixed(2) + ' GB';
}
