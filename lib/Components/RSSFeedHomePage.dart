import 'package:flutter/material.dart';
import '../Constants/theme_provider.dart';

class RSSFeedHomePage extends StatefulWidget {
  @override
  State<RSSFeedHomePage> createState() => _RSSFeedHomePageState();
}

class _RSSFeedHomePageState extends State<RSSFeedHomePage> {
  bool isNewSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeProvider.theme.primaryColorLight,
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            style: TextStyle(
              color: ThemeProvider.theme.textTheme.bodyText1?.color,
            ),
            decoration: InputDecoration(
              labelText: 'Existing Feeds',
              hintText: 'No feeds defined.',
              labelStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  color: ThemeProvider.theme.textTheme.bodyText1?.color),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 230.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  isNewSelected = true;
                  print(isNewSelected);
                });
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                primary: ThemeProvider.theme.accentColor,
              ),
              child: Center(
                child: Text(
                  "New",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          (isNewSelected)
              ? Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 150,
                            child: TextField(
                              style: TextStyle(
                                color: ThemeProvider
                                    .theme.textTheme.bodyText1?.color,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Interval',
                                hintText: 'Interval',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: ThemeProvider
                                        .theme.textTheme.bodyText1?.color),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 150,
                            child: TextField(
                              style: TextStyle(
                                color: ThemeProvider
                                    .theme.textTheme.bodyText1?.color,
                              ),
                              decoration: InputDecoration(
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 80.0, right: 10, top: 5, bottom: 5),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      primary:
                                          ThemeProvider.theme.primaryColorDark,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: ThemeProvider
                                            .theme.textTheme.bodyText1?.color,
                                      ),
                                    ),
                                  ),
                                ),
                                labelText: 'Interval Unit',
                                hintText: 'Select interval unit',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: ThemeProvider
                                        .theme.textTheme.bodyText1?.color),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: TextField(
                          style: TextStyle(
                            color:
                                ThemeProvider.theme.textTheme.bodyText1?.color,
                          ),
                          decoration: InputDecoration(
                            labelText: 'URL',
                            hintText: 'URL',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                color: ThemeProvider
                                    .theme.textTheme.bodyText1?.color),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                              width: 150,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    isNewSelected = true;
                                    print(isNewSelected);
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  primary: Colors.red,
                                ),
                                child: Center(
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 10),
                            child: Container(
                              width: 150,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    isNewSelected = true;
                                    print(isNewSelected);
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  primary: ThemeProvider.theme.primaryColorDark,
                                ),
                                child: Center(
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : Container(),
          (isNewSelected)
              ? SizedBox(
                  height: 10,
                )
              : Container(),
          TextField(
            style: TextStyle(
              color: ThemeProvider.theme.textTheme.bodyText1?.color,
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: ThemeProvider.theme.textTheme.bodyText1?.color,
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(
                    left: 250.0, right: 10, top: 5, bottom: 5),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    primary: ThemeProvider.theme.primaryColorDark,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: ThemeProvider.theme.textTheme.bodyText1?.color,
                    ),
                  ),
                ),
              ),
              labelText: 'Browse Feed',
              hintText: 'Select Feed',
              labelStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  color: ThemeProvider.theme.textTheme.bodyText1?.color),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
