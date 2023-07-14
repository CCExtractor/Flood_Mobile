import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/l10n/l10n.dart';

class AboutScreen extends StatefulWidget {
  final int themeIndex;

  const AboutScreen({Key? key, required this.themeIndex}) : super(key: key);
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeBloc.theme(widget.themeIndex).primaryColor,
      body: SingleChildScrollView(
        child: Padding(
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
                    context.l10n.app_info,
                    key: Key('App info text key'),
                    style: TextStyle(
                        color: ThemeBloc.theme(widget.themeIndex)
                            .textTheme
                            .bodyLarge
                            ?.color,
                        fontSize: 15),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    context.l10n.feedback_heading,
                    style: TextStyle(
                        color: ThemeBloc.theme(widget.themeIndex)
                            .textTheme
                            .bodyLarge
                            ?.color,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    context.l10n.feedback_text,
                    key: Key('Feedback text key'),
                    style: TextStyle(
                        color: ThemeBloc.theme(widget.themeIndex)
                            .textTheme
                            .bodyLarge
                            ?.color,
                        fontSize: 15),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    context.l10n.more_info_text,
                    style: TextStyle(
                        color: ThemeBloc.theme(widget.themeIndex)
                            .textTheme
                            .bodyLarge
                            ?.color,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    context.l10n.check_out_info,
                    key: Key('More info text key'),
                    style: TextStyle(
                        color: ThemeBloc.theme(widget.themeIndex)
                            .textTheme
                            .bodyLarge
                            ?.color,
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
      ),
    );
  }
}
