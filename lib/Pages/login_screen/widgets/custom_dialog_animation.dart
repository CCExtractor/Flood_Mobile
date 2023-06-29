import 'package:flutter/material.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:optimize_battery/optimize_battery.dart';

class CustomDialogAnimation extends StatelessWidget {
  final int themeIndex;

  const CustomDialogAnimation({Key? key, required this.themeIndex})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(context),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          // Bottom rectangular box
          margin:
              EdgeInsets.only(top: 40), // to push the box half way below circle
          decoration: BoxDecoration(
            color: ThemeBloc.theme(themeIndex).primaryColorLight,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.only(
            top: 0,
          ), // spacing inside the box
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              InkWell(
                child: Align(
                  child: CircleAvatar(
                    radius: 15.0,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.cancel,
                      color: ThemeBloc.theme(themeIndex).primaryColorDark,
                      size: 30,
                    ),
                  ),
                  alignment: Alignment.topRight,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 20),
                child: Column(
                  children: [
                    new Text("Action Required",
                        style: TextStyle(
                            fontSize: 20.0,
                            color: ThemeBloc.theme(themeIndex)
                                .textTheme
                                .bodyLarge
                                ?.color,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text("To make sure progress notification works smoothly.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14.0,
                            color: ThemeBloc.theme(themeIndex)
                                .textTheme
                                .bodyLarge
                                ?.color)),
                    SizedBox(height: 10),
                    Text(
                        "This might not be required for certain devices like MI/Redmi, etc as they don't have a rigorous battery optimization.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black45))
                  ],
                ),
              ) //
                  ),
              SizedBox(height: 24.0),
              InkWell(
                child: Container(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, bottom: 10),
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Remove battery \noptimisation",
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "All Apps > Flood > Don't \noptimize",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "OR",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "Long Press App Icon >\nApp Info > Battery usage >\nAllow background activity",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 80),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black26,
                                  size: 25,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 10),
                          child: ElevatedButton(
                              onPressed: () {
                                OptimizeBattery
                                    .openBatteryOptimizationSettings();
                              },
                              style: ElevatedButton.styleFrom(
                                side:
                                    BorderSide(width: 0.2, color: Colors.black),
                                backgroundColor: ThemeBloc.theme(themeIndex)
                                    .primaryColorDark,
                                elevation: 0.5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              child: Container(
                                height: 45,
                                child: Center(
                                  child: Text(
                                    'UPDATE BATTERY SETTINGS',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w800),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  OptimizeBattery.openBatteryOptimizationSettings();
                },
              )
            ],
          ),
        ),
        CircleAvatar(
          radius: 40.0,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.settings,
            color: ThemeBloc.theme(themeIndex).primaryColorDark,
            size: 50,
          ),
        ),
      ],
    );
  }
}
