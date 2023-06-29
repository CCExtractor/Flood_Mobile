import 'dart:ui';

class OnboardPageModel {
  final Color primeColor;
  final Color accentColor;
  final Color nextAccentColor;
  final int pageNumber;
  final String imagePath;
  final String caption;
  final String subhead;
  final String description;

  OnboardPageModel({
    required this.primeColor,
    required this.accentColor,
    required this.nextAccentColor,
    required this.pageNumber,
    required this.imagePath,
    required this.caption,
    required this.subhead,
    required this.description,
  });
}
