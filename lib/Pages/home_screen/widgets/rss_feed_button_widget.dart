import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/Pages/home_screen/widgets/rss_feed_home_page.dart';
import 'package:flutter/material.dart';

class RSSFeedButtonWidget extends StatefulWidget {
  final int themeIndex;

  const RSSFeedButtonWidget({Key? key, required this.themeIndex})
      : super(key: key);
  @override
  State<RSSFeedButtonWidget> createState() => _RSSFeedButtonWidgetState();
}

class _RSSFeedButtonWidgetState extends State<RSSFeedButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: Key('Rss Feed Button ${widget.themeIndex}'),
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
      key: Key('Rss feed home bottom sheet ${widget.themeIndex}'),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
        color: ThemeBloc.theme(widget.themeIndex).primaryColorLight,
      ),
      child: ListView(
        scrollDirection: Axis.vertical,
        controller: scrollController,
        children: [RSSFeedHomePage(themeIndex: widget.themeIndex)],
      ),
    );
  }
}
