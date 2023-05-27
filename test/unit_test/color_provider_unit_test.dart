import 'package:flood_mobile/Components/onboarding/data/onboard_page_data.dart';
import 'package:flood_mobile/Provider/color_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ColorProvider', () {
    late ColorProvider colorProvider;

    setUp(() {
      colorProvider = ColorProvider();
    });

    test(
        'Initial color should match the first accent color from the onboard data',
        () {
      expect(colorProvider.color, equals(onboardData[0].accentColor));
    });

    test('Setting a new color should update the color value', () {
      const newColor = Colors.blue;
      colorProvider.color = newColor;
      expect(colorProvider.color, equals(newColor));
    });
  });
}
