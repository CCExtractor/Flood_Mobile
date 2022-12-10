import 'dart:ui';
import '../models/onboard_page_model.dart';

List<OnboardPageModel> onboardData = [
  OnboardPageModel(
    Color(0xff293341),
    Color(0xff39C481),
    Color(0xFFFFE074),
    0,
    'assets/images/flutter_onboarding_1.png',
    'INSIGHT',
    'FLOOD-MOBILE',
    'Flood is a torrent monitoring service that works with a variety of clients. The Flood-Mobile app aims to provide a user-friendly mobile interface utilizing the Flood as a backend.',
  ),
  OnboardPageModel(
    Color(0xff39C481),
    Color(0xff293341),
    Color(0xFFE6E6E6),
    1,
    'assets/images/flutter_onboarding_2.png',
    'CORE',
    'FEATURES',
    'The Flood-Mobile core features includes the RSS-FEED feature, background notifications, torrent download using magnet/torrent files, video streaming, etc',
  ),
  OnboardPageModel(
    Color(0xff293341),
    Color(0xff39C481),
    Color(0xFFE6E6E6),
    2,
    'assets/images/flutter_onboarding_3.png',
    'SOME MORE',
    'COOL FEATURES',
    'The app also provides some more cool features like filtering torrents, direct download, multiple convenience/controlling features in settings, light/dark mode support, etc.',
  ),
];
