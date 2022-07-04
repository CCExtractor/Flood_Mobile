import 'package:flood_mobile/Components/RSSFeedHomePage.dart';
import 'package:flood_mobile/Components/testingpage.dart';
import 'package:flutter/material.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import '../Constants/theme_provider.dart';

class RSSFeedButtonWidget extends StatefulWidget {
  @override
  State<RSSFeedButtonWidget> createState() => _RSSFeedButtonWidgetState();
}

class _RSSFeedButtonWidgetState extends State<RSSFeedButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showFlexibleBottomSheet(
          minHeight: 0,
          initHeight: 0.5,
          maxHeight: 1,
          bottomSheetColor: Colors.transparent,
          context: context,
          builder: _buildBottomSheet,
          anchors: [0, 0.5, 1],
          isSafeArea: true,
        );
      },
      icon: Icon(Icons.rss_feed),
    );
  }

  Widget _buildBottomSheet(
      BuildContext context,
      ScrollController scrollController,
      double bottomSheetOffset,
      ) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
          color: ThemeProvider.theme.primaryColorLight,
        ),
        child: ListView(
          scrollDirection: Axis.vertical,
          controller: scrollController,
          children: [
            RSSFeedHomePage()
          ],
        ),
    );
  }
}
