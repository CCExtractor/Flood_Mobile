import 'package:animated_theme_switcher/animated_theme_switcher.dart'
    as ThemePackage;
import 'package:flood_mobile/Constants/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeProvider.theme.primaryColor,
      body: Padding(
        padding: EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
            ),
            Image(
              key: Key('App icon asset image'),
              image: AssetImage(
                'assets/images/icon.png',
              ),
              width: 150,
              height: 150,
            ),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                SvgPicture.network(
                  'https://img.shields.io/github/v/release/CCExtractor/Flood_Mobile?include_prereleases',
                  key: Key('release badge key'),
                ),
                SvgPicture.network(
                  'https://img.shields.io/github/last-commit/CCExtractor/Flood_Mobile?label=commit',
                  key: Key('commit badge key'),
                ),
                SvgPicture.network(
                  'https://img.shields.io/github/workflow/status/CCExtractor/Flood_Mobile/Flutter%20CI',
                  key: Key('build badge key'),
                ),
                SvgPicture.network(
                  'https://img.shields.io/github/issues/CCExtractor/Flood_Mobile',
                  key: Key('issues badge key'),
                ),
                SvgPicture.network(
                  'https://img.shields.io/github/issues-pr/CCExtractor/Flood_Mobile?label=PR',
                  key: Key('PR badge key'),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Flood is a monitoring service for various torrent clients. It\'s a Node.js service that communicates with your favorite torrent client and serves a decent mobile UI for administration. This project is based on the original Flood project.',
                  key: Key('App info text key'),
                  style: TextStyle(
                      color: ThemeProvider.theme.textTheme.bodyText1?.color,
                      fontSize: 15),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Feedback',
                  style: TextStyle(
                      color: ThemeProvider.theme.textTheme.bodyText1?.color,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'If you have a specific issue or bug, please file a GitHub issue. Please join the Flood Discord server to discuss feature requests and implementation details.',
                  key: Key('Feedback text key'),
                  style: TextStyle(
                      color: ThemeProvider.theme.textTheme.bodyText1?.color,
                      fontSize: 15),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'More Information',
                  style: TextStyle(
                      color: ThemeProvider.theme.textTheme.bodyText1?.color,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Check out the Wiki for more information.',
                  key: Key('More info text key'),
                  style: TextStyle(
                      color: ThemeProvider.theme.textTheme.bodyText1?.color,
                      fontSize: 15),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
