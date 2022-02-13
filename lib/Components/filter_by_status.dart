import 'package:flood_mobile/Constants/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/filter_provider.dart';
import '../Provider/home_provider.dart';

class FilterByStatus extends StatefulWidget {
  @override
  _FilterByStatusState createState() => _FilterByStatusState();
}

class _FilterByStatusState extends State<FilterByStatus> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FilterProvider>(builder: (context, filterModel, child) {
      return Consumer<HomeProvider>(builder: (context, model, child) {
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
                    groupValue: filterModel.filterStatus,
                    onChanged: (FilterValue? value) {
                      Provider.of<FilterProvider>(context, listen: false)
                          .settrackerURISelected('null');
                      Provider.of<FilterProvider>(context, listen: false)
                          .setFilterSelected(value!);
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
                    groupValue: filterModel.filterStatus,
                    onChanged: (FilterValue? value) {
                      Provider.of<FilterProvider>(context, listen: false)
                          .settrackerURISelected('null');
                      Provider.of<FilterProvider>(context, listen: false)
                          .setFilterSelected(value!);
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
                    groupValue: filterModel.filterStatus,
                    onChanged: (FilterValue? value) {
                      Provider.of<FilterProvider>(context, listen: false)
                          .settrackerURISelected('null');
                      Provider.of<FilterProvider>(context, listen: false)
                          .setFilterSelected(value!);
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
                    groupValue: filterModel.filterStatus,
                    onChanged: (FilterValue? value) {
                      Provider.of<FilterProvider>(context, listen: false)
                          .settrackerURISelected('null');
                      Provider.of<FilterProvider>(context, listen: false)
                          .setFilterSelected(value!);
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
                    groupValue: filterModel.filterStatus,
                    onChanged: (FilterValue? value) {
                      Provider.of<FilterProvider>(context, listen: false)
                          .settrackerURISelected('null');
                      Provider.of<FilterProvider>(context, listen: false)
                          .setFilterSelected(value!);
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
                    groupValue: filterModel.filterStatus,
                    onChanged: (FilterValue? value) {
                      Provider.of<FilterProvider>(context, listen: false)
                          .settrackerURISelected('null');
                      Provider.of<FilterProvider>(context, listen: false)
                          .setFilterSelected(value!);
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
                    groupValue: filterModel.filterStatus,
                    onChanged: (FilterValue? value) {
                      Provider.of<FilterProvider>(context, listen: false)
                          .settrackerURISelected('null');
                      Provider.of<FilterProvider>(context, listen: false)
                          .setFilterSelected(value!);
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
                    groupValue: filterModel.filterStatus,
                    onChanged: (FilterValue? value) {
                      Provider.of<FilterProvider>(context, listen: false)
                          .settrackerURISelected('null');
                      Provider.of<FilterProvider>(context, listen: false)
                          .setFilterSelected(value!);
                    },
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filterModel.trackerURIsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        minLeadingWidth: 2,
                        visualDensity:
                            VisualDensity(horizontal: -4, vertical: -2),
                        title: Text(
                            filterModel.trackerURIsList[index].toString(),
                            style: TextStyle(
                                color: ThemeProvider
                                    .theme.textTheme.bodyText1?.color,
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                fontWeight: FontWeight.normal)),
                        trailing: Radio<String>(
                          value: filterModel.trackerURIsList[index].toString(),
                          groupValue: filterModel.trackerURISelected,
                          onChanged: (value) {
                            Provider.of<FilterProvider>(context, listen: false)
                                .setFilterSelected(null);
                            Provider.of<FilterProvider>(context, listen: false)
                                .settrackerURISelected(value.toString());
                          },
                        ),
                      );
                    }),
              ],
            ),
          ),
        );
      });
    });
  }
}
