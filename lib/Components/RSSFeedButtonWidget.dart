import 'package:flood_mobile/Components/RSSFeedHomePage.dart';
import 'package:flutter/material.dart';
import '../Constants/theme_provider.dart';

class RSSFeedButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
            ),
          ),
          isScrollControlled: true,
          context: context,
          backgroundColor: ThemeProvider.theme.backgroundColor,
          builder: (context) {
            return  RSSFeedHomePage();
          },
        );
      },
      icon: Icon(Icons.rss_feed),
    );
  }
}
