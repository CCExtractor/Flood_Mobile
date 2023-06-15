import 'dart:ui';
import 'package:flood_mobile/Model/onboard_page_model.dart';

List<OnboardPageModel> onboardData = [
  OnboardPageModel(
    primeColor: Color(0xff293341),
    accentColor: Color(0xff39C481),
    nextAccentColor: Color(0xFFFFE074),
    pageNumber: 0,
    imagePath: 'assets/images/flutter_onboarding_1.png',
    caption: 'INSIGHT',
    subhead: 'FLOOD-MOBILE',
    description:
        'Flood is a torrent monitoring service that works with a variety of clients. The Flood-Mobile app aims to provide a user-friendly mobile interface utilizing the Flood as a backend.',
  ),
  OnboardPageModel(
    primeColor: Color(0xff39C481),
    accentColor: Color(0xff293341),
    nextAccentColor: Color(0xFFE6E6E6),
    pageNumber: 1,
    imagePath: 'assets/images/flutter_onboarding_2.png',
    caption: 'CORE',
    subhead: 'FEATURES',
    description:
        'The Flood-Mobile core features includes the RSS-FEED feature, background notifications, torrent download using magnet/torrent files, video streaming, etc',
  ),
  OnboardPageModel(
    primeColor: Color(0xff293341),
    accentColor: Color(0xff39C481),
    nextAccentColor: Color(0xFFE6E6E6),
    pageNumber: 2,
    imagePath: 'assets/images/flutter_onboarding_3.png',
    caption: 'SOME MORE',
    subhead: 'COOL FEATURES',
    description:
        'The app also provides some more cool features like filtering torrents, direct download, multiple convenience/controlling features in settings, light/dark mode support, etc.',
  ),
];
