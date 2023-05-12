import 'package:flood_mobile/Constants/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Api/event_handler_api.dart';
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
                    color:
                        filterModel.filterStatus.toString().split(".").last ==
                                "all"
                            ? Colors.blue
                            : ThemeProvider.theme.textTheme.bodyText1?.color,
                  ),
                  minLeadingWidth: 2,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                  title: Row(
                    children: [
                      Text('All',
                          style: TextStyle(
                              color: filterModel.filterStatus
                                          .toString()
                                          .split(".")
                                          .last ==
                                      "all"
                                  ? Colors.blue
                                  : ThemeProvider
                                      .theme.textTheme.bodyText1?.color,
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.normal)),
                      SizedBox(width: 5),
                      Container(
                        width: 18,
                        height: 18,
                        child: Center(
                          child: Text(torrentLength,
                              style: TextStyle(
                                  color: ThemeProvider.theme.primaryColorLight,
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: filterModel.filterStatus
                                      .toString()
                                      .split(".")
                                      .last ==
                                  "all"
                              ? Colors.blue
                              : Colors.blueGrey,
                        ),
                      )
                    ],
                  ),
                  trailing: Radio<FilterValue>(
                    value: FilterValue.all,
                    groupValue: filterModel.filterStatus,
                    onChanged: (FilterValue? value) {
                      Provider.of<FilterProvider>(context, listen: false)
                          .setTagSelected('null');
                      Provider.of<FilterProvider>(context, listen: false)
                          .settrackerURISelected('null');
                      Provider.of<FilterProvider>(context, listen: false)
                          .setFilterSelected(value!);
                    },
                    activeColor: Colors.blue,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.download_sharp,
                    size: 20,
                    color:
                        filterModel.filterStatus.toString().split(".").last ==
                                "downloading"
                            ? Colors.blue
                            : ThemeProvider.theme.textTheme.bodyText1?.color,
                  ),
                  minLeadingWidth: 2,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                  title: Row(
                    children: [
                      Text('Downloading',
                          style: TextStyle(
                              color: filterModel.filterStatus
                                          .toString()
                                          .split(".")
                                          .last ==
                                      "downloading"
                                  ? Colors.blue
                                  : ThemeProvider
                                      .theme.textTheme.bodyText1?.color,
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.normal)),
                      SizedBox(width: 5),
                      Container(
                        width: 18,
                        height: 18,
                        child: Center(
                          child: Text(
                              filterModel.mapStatus.keys
                                      .toList()
                                      .contains('downloading')
                                  ? filterModel.mapStatus['downloading']
                                      .toString()
                                  : '0',
                              style: TextStyle(
                                  color: ThemeProvider.theme.primaryColorLight,
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: filterModel.filterStatus
                                      .toString()
                                      .split(".")
                                      .last ==
                                  "downloading"
                              ? Colors.blue
                              : Colors.blueGrey,
                        ),
                      )
                    ],
                  ),
                  trailing: Radio<FilterValue>(
                    value: FilterValue.downloading,
                    groupValue: filterModel.filterStatus,
                    onChanged: (FilterValue? value) {
                      Provider.of<FilterProvider>(context, listen: false)
                          .setTagSelected('null');
                      Provider.of<FilterProvider>(context, listen: false)
                          .settrackerURISelected('null');
                      Provider.of<FilterProvider>(context, listen: false)
                          .setFilterSelected(value!);
                    },
                    activeColor: Colors.blue,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.upload_sharp,
                    size: 20,
                    color:
                        filterModel.filterStatus.toString().split(".").last ==
                                "seeding"
                            ? Colors.blue
                            : ThemeProvider.theme.textTheme.bodyText1?.color,
                  ),
                  minLeadingWidth: 2,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                  title: Row(
                    children: [
                      Text('Seeding',
                          style: TextStyle(
                              color: filterModel.filterStatus
                                          .toString()
                                          .split(".")
                                          .last ==
                                      "seeding"
                                  ? Colors.blue
                                  : ThemeProvider
                                      .theme.textTheme.bodyText1?.color,
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.normal)),
                      SizedBox(width: 5),
                      Container(
                        width: 18,
                        height: 18,
                        child: Center(
                          child: Text(
                              filterModel.mapStatus.keys
                                      .toList()
                                      .contains('seeding')
                                  ? filterModel.mapStatus['seeding'].toString()
                                  : '0',
                              style: TextStyle(
                                  color: ThemeProvider.theme.primaryColorLight,
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: filterModel.filterStatus
                                      .toString()
                                      .split(".")
                                      .last ==
                                  "seeding"
                              ? Colors.blue
                              : Colors.blueGrey,
                        ),
                      )
                    ],
                  ),
                  trailing: Radio<FilterValue>(
                    value: FilterValue.seeding,
                    groupValue: filterModel.filterStatus,
                    onChanged: (FilterValue? value) {
                      Provider.of<FilterProvider>(context, listen: false)
                          .setTagSelected('null');
                      Provider.of<FilterProvider>(context, listen: false)
                          .settrackerURISelected('null');
                      Provider.of<FilterProvider>(context, listen: false)
                          .setFilterSelected(value!);
                    },
                    activeColor: Colors.blue,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.done,
                    size: 20,
                    color:
                        filterModel.filterStatus.toString().split(".").last ==
                                "complete"
                            ? Colors.blue
                            : ThemeProvider.theme.textTheme.bodyText1?.color,
                  ),
                  minLeadingWidth: 2,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                  title: Row(
                    children: [
                      Text('Complete',
                          style: TextStyle(
                              color: filterModel.filterStatus
                                          .toString()
                                          .split(".")
                                          .last ==
                                      "complete"
                                  ? Colors.blue
                                  : ThemeProvider
                                      .theme.textTheme.bodyText1?.color,
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.normal)),
                      SizedBox(width: 5),
                      Container(
                        width: 18,
                        height: 18,
                        child: Center(
                          child: Text(
                              filterModel.mapStatus.keys
                                      .toList()
                                      .contains('complete')
                                  ? filterModel.mapStatus['complete'].toString()
                                  : '0',
                              style: TextStyle(
                                  color: ThemeProvider.theme.primaryColorLight,
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: filterModel.filterStatus
                                      .toString()
                                      .split(".")
                                      .last ==
                                  "complete"
                              ? Colors.blue
                              : Colors.blueGrey,
                        ),
                      )
                    ],
                  ),
                  trailing: Radio<FilterValue>(
                    value: FilterValue.complete,
                    groupValue: filterModel.filterStatus,
                    onChanged: (FilterValue? value) {
                      Provider.of<FilterProvider>(context, listen: false)
                          .setTagSelected('null');
                      Provider.of<FilterProvider>(context, listen: false)
                          .settrackerURISelected('null');
                      Provider.of<FilterProvider>(context, listen: false)
                          .setFilterSelected(value!);
                    },
                    activeColor: Colors.blue,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.stop,
                    size: 20,
                    color:
                        filterModel.filterStatus.toString().split(".").last ==
                                "stopped"
                            ? Colors.blue
                            : ThemeProvider.theme.textTheme.bodyText1?.color,
                  ),
                  minLeadingWidth: 2,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                  title: Row(
                    children: [
                      Text('Stopped',
                          style: TextStyle(
                              color: filterModel.filterStatus
                                          .toString()
                                          .split(".")
                                          .last ==
                                      "stopped"
                                  ? Colors.blue
                                  : ThemeProvider
                                      .theme.textTheme.bodyText1?.color,
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.normal)),
                      SizedBox(width: 5),
                      Container(
                        width: 18,
                        height: 18,
                        child: Center(
                          child: Text(
                              filterModel.mapStatus.keys
                                      .toList()
                                      .contains('stopped')
                                  ? filterModel.mapStatus['stopped'].toString()
                                  : '0',
                              style: TextStyle(
                                  color: ThemeProvider.theme.primaryColorLight,
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: filterModel.filterStatus
                                      .toString()
                                      .split(".")
                                      .last ==
                                  "stopped"
                              ? Colors.blue
                              : Colors.blueGrey,
                        ),
                      )
                    ],
                  ),
                  trailing: Radio<FilterValue>(
                    value: FilterValue.stopped,
                    groupValue: filterModel.filterStatus,
                    onChanged: (FilterValue? value) {
                      Provider.of<FilterProvider>(context, listen: false)
                          .setTagSelected('null');
                      Provider.of<FilterProvider>(context, listen: false)
                          .settrackerURISelected('null');
                      Provider.of<FilterProvider>(context, listen: false)
                          .setFilterSelected(value!);
                    },
                    activeColor: Colors.blue,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.trending_up_outlined,
                    size: 20,
                    color:
                        filterModel.filterStatus.toString().split(".").last ==
                                "active"
                            ? Colors.blue
                            : ThemeProvider.theme.textTheme.bodyText1?.color,
                  ),
                  minLeadingWidth: 2,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                  title: Row(
                    children: [
                      Text('Active',
                          style: TextStyle(
                              color: filterModel.filterStatus
                                          .toString()
                                          .split(".")
                                          .last ==
                                      "active"
                                  ? Colors.blue
                                  : ThemeProvider
                                      .theme.textTheme.bodyText1?.color,
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.normal)),
                      SizedBox(width: 5),
                      Container(
                        width: 18,
                        height: 18,
                        child: Center(
                          child: Text(
                              filterModel.mapStatus.keys
                                      .toList()
                                      .contains('active')
                                  ? filterModel.mapStatus['active'].toString()
                                  : '0',
                              style: TextStyle(
                                  color: ThemeProvider.theme.primaryColorLight,
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: filterModel.filterStatus
                                      .toString()
                                      .split(".")
                                      .last ==
                                  "active"
                              ? Colors.blue
                              : Colors.blueGrey,
                        ),
                      )
                    ],
                  ),
                  trailing: Radio<FilterValue>(
                    value: FilterValue.active,
                    groupValue: filterModel.filterStatus,
                    onChanged: (FilterValue? value) {
                      Provider.of<FilterProvider>(context, listen: false)
                          .setTagSelected('null');
                      Provider.of<FilterProvider>(context, listen: false)
                          .settrackerURISelected('null');
                      Provider.of<FilterProvider>(context, listen: false)
                          .setFilterSelected(value!);
                    },
                    activeColor: Colors.blue,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.trending_down_outlined,
                    size: 20,
                    color:
                        filterModel.filterStatus.toString().split(".").last ==
                                "inactive"
                            ? Colors.blue
                            : ThemeProvider.theme.textTheme.bodyText1?.color,
                  ),
                  minLeadingWidth: 2,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                  title: Row(
                    children: [
                      Text('Inactive',
                          style: TextStyle(
                              color: filterModel.filterStatus
                                          .toString()
                                          .split(".")
                                          .last ==
                                      "inactive"
                                  ? Colors.blue
                                  : ThemeProvider
                                      .theme.textTheme.bodyText1?.color,
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.normal)),
                      SizedBox(width: 5),
                      Container(
                        width: 18,
                        height: 18,
                        child: Center(
                          child: Text(
                              filterModel.mapStatus.keys
                                      .toList()
                                      .contains('inactive')
                                  ? filterModel.mapStatus['inactive'].toString()
                                  : '0',
                              style: TextStyle(
                                  color: ThemeProvider.theme.primaryColorLight,
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: filterModel.filterStatus
                                      .toString()
                                      .split(".")
                                      .last ==
                                  "inactive"
                              ? Colors.blue
                              : Colors.blueGrey,
                        ),
                      )
                    ],
                  ),
                  trailing: Radio<FilterValue>(
                    value: FilterValue.inactive,
                    groupValue: filterModel.filterStatus,
                    onChanged: (FilterValue? value) {
                      Provider.of<FilterProvider>(context, listen: false)
                          .setTagSelected('null');
                      Provider.of<FilterProvider>(context, listen: false)
                          .settrackerURISelected('null');
                      Provider.of<FilterProvider>(context, listen: false)
                          .setFilterSelected(value!);
                    },
                    activeColor: Colors.blue,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.error,
                    size: 20,
                    color:
                        filterModel.filterStatus.toString().split(".").last ==
                                "error"
                            ? Colors.blue
                            : ThemeProvider.theme.textTheme.bodyText1?.color,
                  ),
                  minLeadingWidth: 2,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                  title: Row(
                    children: [
                      Text('Error',
                          style: TextStyle(
                              color: filterModel.filterStatus
                                          .toString()
                                          .split(".")
                                          .last ==
                                      "error"
                                  ? Colors.blue
                                  : ThemeProvider
                                      .theme.textTheme.bodyText1?.color,
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.normal)),
                      SizedBox(width: 5),
                      Container(
                        width: 18,
                        height: 18,
                        child: Center(
                          child: Text(
                              filterModel.mapStatus.keys
                                      .toList()
                                      .contains('error')
                                  ? filterModel.mapStatus['error'].toString()
                                  : '0',
                              style: TextStyle(
                                  color: ThemeProvider.theme.primaryColorLight,
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: filterModel.filterStatus
                                      .toString()
                                      .split(".")
                                      .last ==
                                  "error"
                              ? Colors.blue
                              : Colors.blueGrey,
                        ),
                      )
                    ],
                  ),
                  trailing: Radio<FilterValue>(
                    value: FilterValue.error,
                    groupValue: filterModel.filterStatus,
                    onChanged: (FilterValue? value) {
                      Provider.of<FilterProvider>(context, listen: false)
                          .setTagSelected('null');
                      Provider.of<FilterProvider>(context, listen: false)
                          .settrackerURISelected('null');
                      Provider.of<FilterProvider>(context, listen: false)
                          .setFilterSelected(value!);
                    },
                    activeColor: Colors.blue,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Filter by tags",
                    style: TextStyle(
                        color: ThemeProvider.theme.textTheme.bodyText1?.color,
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
                ListTile(
                  minLeadingWidth: 2,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                  title: Row(
                    children: [
                      Text('All',
                          style: TextStyle(
                              color: filterModel.filterStatus
                                          .toString()
                                          .split(".")
                                          .last ==
                                      "all"
                                  ? Colors.blue
                                  : ThemeProvider
                                      .theme.textTheme.bodyText1?.color,
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.normal)),
                      SizedBox(width: 5),
                      Container(
                        width: 18,
                        height: 18,
                        child: Center(
                          child: Text(torrentLength,
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: filterModel.filterStatus
                                      .toString()
                                      .split(".")
                                      .last ==
                                  "all"
                              ? Colors.blue
                              : Colors.blueGrey,
                        ),
                      )
                    ],
                  ),
                  trailing: Radio<FilterValue>(
                    value: FilterValue.all,
                    groupValue: filterModel.filterStatus,
                    onChanged: (FilterValue? value) {
                      Provider.of<FilterProvider>(context, listen: false)
                          .settrackerURISelected('null');
                      Provider.of<FilterProvider>(context, listen: false)
                          .setFilterSelected(value!);
                      Provider.of<FilterProvider>(context, listen: false)
                          .setTagSelected('null');
                    },
                    activeColor: Colors.blue,
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filterModel.mapTags.keys.toList().length,
                    itemBuilder: (BuildContext context, int index) {
                      if (filterModel.mapTags.keys.toList()[index] !=
                          'Untagged') {
                        return ListTile(
                          minLeadingWidth: 2,
                          visualDensity:
                              VisualDensity(horizontal: -4, vertical: -2),
                          title: Row(
                            children: [
                              Flexible(
                                child: Text(
                                    filterModel.mapTags.keys.toList()[index],
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: filterModel.mapTags.keys
                                                    .toList()[index] ==
                                                filterModel.tagSelected
                                                    .toString()
                                            ? Colors.blue
                                            : ThemeProvider.theme.textTheme
                                                .bodyText1?.color,
                                        fontFamily: 'Montserrat',
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal)),
                              ),
                              SizedBox(width: 5),
                              Container(
                                width: 18,
                                height: 18,
                                child: Center(
                                  child: Text(
                                      filterModel.mapTags[filterModel
                                              .mapTags.keys
                                              .toList()[index]]
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontFamily: 'Montserrat',
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: filterModel.mapTags.keys
                                              .toList()[index] ==
                                          filterModel.tagSelected.toString()
                                      ? Colors.blue
                                      : Colors.blueGrey,
                                ),
                              )
                            ],
                          ),
                          trailing: Radio<String>(
                            value: filterModel.mapTags.keys
                                .toList()[index]
                                .toString(),
                            groupValue: filterModel.tagSelected,
                            onChanged: (value) {
                              Provider.of<FilterProvider>(context,
                                      listen: false)
                                  .setFilterSelected(null);
                              Provider.of<FilterProvider>(context,
                                      listen: false)
                                  .setTagSelected(value.toString());
                              Provider.of<FilterProvider>(context,
                                      listen: false)
                                  .settrackerURISelected('null');
                            },
                            activeColor: Colors.blue,
                          ),
                        );
                      } else {
                        return ListTile(
                          minLeadingWidth: 2,
                          visualDensity:
                              VisualDensity(horizontal: -4, vertical: -2),
                          title: Row(
                            children: [
                              Text('Untagged',
                                  style: TextStyle(
                                      color: filterModel.tagSelected
                                                  .toString()
                                                  .split(".")
                                                  .last ==
                                              "Untagged"
                                          ? Colors.blue
                                          : ThemeProvider
                                              .theme.textTheme.bodyText1?.color,
                                      fontFamily: 'Montserrat',
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal)),
                              SizedBox(width: 5),
                              Container(
                                width: 18,
                                height: 18,
                                child: Center(
                                  child: Text(
                                      Provider.of<FilterProvider>(context)
                                          .mapTags['Untagged']
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontFamily: 'Montserrat',
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: filterModel.tagSelected
                                              .toString()
                                              .split(".")
                                              .last ==
                                          "Untagged"
                                      ? Colors.blue
                                      : Colors.blueGrey,
                                ),
                              )
                            ],
                          ),
                          trailing: Radio<String>(
                            value: filterModel.mapTags.keys
                                .toList()[index]
                                .toString(),
                            groupValue: filterModel.tagSelected,
                            onChanged: (_) {
                              Provider.of<FilterProvider>(context,
                                      listen: false)
                                  .settrackerURISelected('null');
                              Provider.of<FilterProvider>(context,
                                      listen: false)
                                  .setTagSelected('Untagged');
                              Provider.of<FilterProvider>(context,
                                      listen: false)
                                  .setFilterSelected(null);
                            },
                            activeColor: Colors.blue,
                          ),
                        );
                      }
                    }),
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
                  title: Row(
                    children: [
                      Text('All',
                          style: TextStyle(
                              color: filterModel.filterStatus
                                          .toString()
                                          .split(".")
                                          .last ==
                                      "all"
                                  ? Colors.blue
                                  : ThemeProvider
                                      .theme.textTheme.bodyText1?.color,
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.normal)),
                      SizedBox(width: 5),
                      Container(
                        width: 18,
                        height: 18,
                        child: Center(
                          child: Text(torrentLength,
                              style: TextStyle(
                                  color: ThemeProvider.theme.primaryColorLight,
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: filterModel.filterStatus
                                      .toString()
                                      .split(".")
                                      .last ==
                                  "all"
                              ? Colors.blue
                              : Colors.blueGrey,
                        ),
                      )
                    ],
                  ),
                  trailing: Radio<FilterValue>(
                    value: FilterValue.all,
                    groupValue: filterModel.filterStatus,
                    onChanged: (FilterValue? value) {
                      Provider.of<FilterProvider>(context, listen: false)
                          .setTagSelected('null');
                      Provider.of<FilterProvider>(context, listen: false)
                          .settrackerURISelected('null');
                      Provider.of<FilterProvider>(context, listen: false)
                          .setFilterSelected(value!);
                    },
                    activeColor: Colors.blue,
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filterModel.maptrackerURIs.keys.toList().length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        minLeadingWidth: 2,
                        visualDensity:
                            VisualDensity(horizontal: -4, vertical: -2),
                        title: Row(
                          children: [
                            Text(
                                filterModel.maptrackerURIs.keys.toList()[index],
                                style: TextStyle(
                                    color: filterModel.maptrackerURIs.keys
                                                .toList()[index] ==
                                            filterModel.trackerURISelected
                                                .toString()
                                        ? Colors.blue
                                        : ThemeProvider
                                            .theme.textTheme.bodyText1?.color,
                                    fontFamily: 'Montserrat',
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal)),
                            SizedBox(width: 5),
                            Container(
                              width: 18,
                              height: 18,
                              child: Center(
                                child: Text(
                                    filterModel.maptrackerURIs[filterModel
                                            .maptrackerURIs.keys
                                            .toList()[index]]
                                        .toString(),
                                    style: TextStyle(
                                        color: ThemeProvider
                                            .theme.primaryColorLight,
                                        fontFamily: 'Montserrat',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: filterModel.maptrackerURIs.keys
                                            .toList()[index] ==
                                        filterModel.trackerURISelected
                                            .toString()
                                    ? Colors.blue
                                    : Colors.blueGrey,
                              ),
                            )
                          ],
                        ),
                        trailing: Radio<String>(
                          value: filterModel.maptrackerURIs.keys
                              .toList()[index]
                              .toString(),
                          groupValue: filterModel.trackerURISelected,
                          onChanged: (value) {
                            Provider.of<FilterProvider>(context, listen: false)
                                .setTagSelected('null');
                            Provider.of<FilterProvider>(context, listen: false)
                                .setFilterSelected(null);
                            Provider.of<FilterProvider>(context, listen: false)
                                .settrackerURISelected(value.toString());
                          },
                          activeColor: Colors.blue,
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
