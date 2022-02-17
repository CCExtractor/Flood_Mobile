import 'package:flood_mobile/Constants/theme_provider.dart';
import 'package:flood_mobile/Pages/torrent_screen.dart';
import 'package:flutter/material.dart';

class FilterByStatus extends StatefulWidget {
  @override
  _FilterByStatusState createState() => _FilterByStatusState();
}

enum FilterValue {
  all,
  downloading,
  seeding,
  complete,
  stopped,
  active,
  inactive
}
FilterValue? filterStatus = FilterValue.all;
String trackerURISelected = '';

class _FilterByStatusState extends State<FilterByStatus> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(15), topLeft: Radius.circular(15)),
        color: ThemeProvider.theme.primaryColorLight,
      ),
      height: 500,
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Filter by status",
                style: TextStyle(
                    color: ThemeProvider.theme.textTheme.bodyText1?.color,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
            ListTile(
              leading: Icon(
                Icons.star_sharp,
                size: 20,
              ),
              minLeadingWidth: 2,
              visualDensity: VisualDensity(horizontal: -4, vertical: -2),
              title: Text('All',
                  style: TextStyle(
                      color: ThemeProvider.theme.textTheme.bodyText1?.color,
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.normal)),
              trailing: Radio<FilterValue>(
                value: FilterValue.all,
                groupValue: filterStatus,
                onChanged: (FilterValue? value) {
                  setState(() {
                    trackerURISelected = 'null';
                    filterStatus = value;
                  });
                },
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.download,
                size: 20,
              ),
              minLeadingWidth: 2,
              visualDensity: VisualDensity(horizontal: -4, vertical: -2),
              title: Text('Downloading',
                  style: TextStyle(
                      color: ThemeProvider.theme.textTheme.bodyText1?.color,
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.normal)),
              trailing: Radio<FilterValue>(
                value: FilterValue.downloading,
                groupValue: filterStatus,
                onChanged: (FilterValue? value) {
                  setState(() {
                    trackerURISelected = 'null';
                    filterStatus = value;
                  });
                },
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.upload_sharp,
                size: 20,
              ),
              minLeadingWidth: 2,
              visualDensity: VisualDensity(horizontal: -4, vertical: -2),
              title: Text('Seeding',
                  style: TextStyle(
                      color: ThemeProvider.theme.textTheme.bodyText1?.color,
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.normal)),
              trailing: Radio<FilterValue>(
                value: FilterValue.seeding,
                groupValue: filterStatus,
                onChanged: (FilterValue? value) {
                  setState(() {
                    trackerURISelected = 'null';
                    filterStatus = value;
                  });
                },
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.done,
                size: 20,
              ),
              minLeadingWidth: 2,
              visualDensity: VisualDensity(horizontal: -4, vertical: -2),
              title: Text('Complete',
                  style: TextStyle(
                      color: ThemeProvider.theme.textTheme.bodyText1?.color,
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.normal)),
              trailing: Radio<FilterValue>(
                value: FilterValue.complete,
                groupValue: filterStatus,
                onChanged: (FilterValue? value) {
                  setState(() {
                    trackerURISelected = 'null';
                    filterStatus = value;
                  });
                },
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.stop,
                size: 20,
              ),
              minLeadingWidth: 2,
              visualDensity: VisualDensity(horizontal: -4, vertical: -2),
              title: Text('Stopped',
                  style: TextStyle(
                      color: ThemeProvider.theme.textTheme.bodyText1?.color,
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.normal)),
              trailing: Radio<FilterValue>(
                value: FilterValue.stopped,
                groupValue: filterStatus,
                onChanged: (FilterValue? value) {
                  setState(() {
                    trackerURISelected = 'null';
                    filterStatus = value;
                  });
                },
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.trending_up_outlined,
                size: 20,
              ),
              minLeadingWidth: 2,
              visualDensity: VisualDensity(horizontal: -4, vertical: -2),
              title: Text('Active',
                  style: TextStyle(
                      color: ThemeProvider.theme.textTheme.bodyText1?.color,
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.normal)),
              trailing: Radio<FilterValue>(
                value: FilterValue.active,
                groupValue: filterStatus,
                onChanged: (FilterValue? value) {
                  setState(() {
                    trackerURISelected = 'null';
                    filterStatus = value;
                  });
                },
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.trending_down_outlined,
                size: 20,
              ),
              minLeadingWidth: 2,
              visualDensity: VisualDensity(horizontal: -4, vertical: -2),
              title: Text('Inactive',
                  style: TextStyle(
                      color: ThemeProvider.theme.textTheme.bodyText1?.color,
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.normal)),
              trailing: Radio<FilterValue>(
                value: FilterValue.inactive,
                groupValue: filterStatus,
                onChanged: (FilterValue? value) {
                  setState(() {
                    trackerURISelected = 'null';
                    filterStatus = value;
                  });
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Filter by trackers",
                style: TextStyle(
                    color: ThemeProvider.theme.textTheme.bodyText1?.color,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
            ListTile(
              minLeadingWidth: 2,
              visualDensity: VisualDensity(horizontal: -4, vertical: -2),
              title: Text('All',
                  style: TextStyle(
                      color: ThemeProvider.theme.textTheme.bodyText1?.color,
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.normal)),
              trailing: Radio<FilterValue>(
                value: FilterValue.all,
                groupValue: filterStatus,
                onChanged: (FilterValue? value) {
                  setState(() {
                    trackerURISelected = 'null';
                    filterStatus = value;
                  });
                },
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: trackerURIsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    minLeadingWidth: 2,
                    visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                    title: Text(trackerURIsList[index].toString(),
                        style: TextStyle(
                            color:
                            ThemeProvider.theme.textTheme.bodyText1?.color,
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                            fontWeight: FontWeight.normal)),
                    trailing: Radio<String>(
                      value: trackerURIsList[index].toString(),
                      groupValue: trackerURISelected,
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          filterStatus = null;
                          trackerURISelected = value.toString();
                        });
                      },
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}